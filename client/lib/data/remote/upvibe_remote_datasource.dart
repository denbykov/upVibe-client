import 'dart:async';
import 'dart:typed_data';

import 'package:client/data/dto/binary_file_dto.dart';
import 'package:client/data/dto/file_dto.dart';
import 'package:client/data/dto/playlist_dto.dart';
import 'package:client/data/dto/etxended_file_dto.dart';
import 'package:client/data/dto/source_dto.dart';
import 'package:client/data/dto/tag_dto.dart';
import 'package:client/data/dto/tag_mapping_dto.dart';
import 'package:client/data/dto/tag_mapping_priority_dto.dart';
import 'package:client/domain/repositories/authorization_repository.dart';
import 'package:dio/dio.dart';

import 'package:client/exceptions/login_failure.dart';
import 'package:client/exceptions/upvibe_timeout.dart';
import 'package:client/exceptions/upvibe_error.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' as getx;

import 'package:client/env.dart';

const appScheme = 'flutterdemo';

UpvibeError throwErrorFromBadResponse(Response response) {
  Map<int, UpvibeErrorType> errorCodeToTypeMapping = {
    -1: UpvibeErrorType.generic,
  };

  Map<String, dynamic> json = response.data;
  throw switch (json) {
    {
      'message': String message,
      'code': int code,
    } =>
      UpvibeError(message: message, type: errorCodeToTypeMapping[code]!),
    _ => throw const FormatException(
        'Failed to load UpvibeError from bad response'),
  };
}

class UpvibeRemoteDatasource {
  late Dio dio;
  Function() ensureAuthorized = () async {
    await getx.Get.find<AuthorizationRepository>().login();
  };

  UpvibeRemoteDatasource() {
    dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 3),
      receiveTimeout: const Duration(seconds: 120),
      baseUrl: 'https://${Env.upVibeServerIp}:3000/up-vibe/',
      responseType: ResponseType.json,
    ));
  }

  void setAccessToken(String accessToken) {
    dio.options.headers['authorization'] = 'Bearer $accessToken';
  }

  Future<void> testConnection() async {
    try {
      await ensureAuthorized();
      var response = await dio.get(
        'v1/auth-test',
      );

      if (response.statusCode != 200) {
        throw LoginFailure();
      }
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) throw UpvibeTimeout();
      rethrow;
    }
  }

  Future<FileDTO> addFile(String url) async {
    try {
      await ensureAuthorized();
      var response = await dio.post('v1/files', data: {'url': url});
      var json = response.data;
      return FileDTO.fromJson(json);
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) throw UpvibeTimeout();
      if (ex.type == DioExceptionType.badResponse &&
          ex.response!.statusCode == 400) {
        throwErrorFromBadResponse(ex.response!);
      }
      rethrow;
    }
  }

  Future<List<FileDTO>> getFiles(String deviceId,
      {List<String>? statuses, bool? isSynronized}) async {
    try {
      await ensureAuthorized();
      final queryParameters = {
        'deviceId': deviceId,
      };

      if (statuses != null) {
        queryParameters['statuses'] = statuses.join(',');
      }

      if (isSynronized != null) {
        queryParameters['synchronized'] = isSynronized.toString();
      }

      var response = await dio.get(
        'v1/files',
        queryParameters: queryParameters,
      );
      var json = response.data;
      return (json as List).map((object) => FileDTO.fromJson(object)).toList();
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) throw UpvibeTimeout();
      if (ex.type == DioExceptionType.badResponse &&
          ex.response!.statusCode == 400) {
        throwErrorFromBadResponse(ex.response!);
      }
      rethrow;
    }
  }

  Future<ExtendedFileDTO> getFile(String id, String deviceId) async {
    try {
      await ensureAuthorized();
      var response = await dio.get(
        'v1/files/$id',
        queryParameters: {
          'deviceId': deviceId,
          'expand': 'mapping',
        },
      );
      var json = response.data;
      return ExtendedFileDTO.fromJson(json);
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) throw UpvibeTimeout();
      if (ex.type == DioExceptionType.badResponse &&
          ex.response!.statusCode == 400) {
        throwErrorFromBadResponse(ex.response!);
      }
      rethrow;
    }
  }

  Future<List<TagDTO>> getTagsForFile(String id) async {
    try {
      await ensureAuthorized();
      var response = await dio.get('v1/files/$id/tags');
      var json = response.data;
      return (json as List).map((object) => TagDTO.fromJson(object)).toList();
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) throw UpvibeTimeout();
      if (ex.type == DioExceptionType.badResponse &&
          ex.response!.statusCode == 400) {
        throwErrorFromBadResponse(ex.response!);
      }
      rethrow;
    }
  }

  Future<void> registerDevice(String uuid, String name) async {
    try {
      await ensureAuthorized();
      await dio.post('v1/register', data: {
        'deviceId': uuid,
        'deviceName': name,
      });
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) {
        throw UpvibeTimeout();
      }
      if (ex.type == DioExceptionType.badResponse &&
          ex.response!.statusCode == 400) {
        throwErrorFromBadResponse(ex.response!);
      }
      rethrow;
    }
  }

  Future<List<SourceDTO>> getSources() async {
    try {
      await ensureAuthorized();
      var response = await dio.get('v1/sources');
      var json = response.data;
      return (json as List)
          .map((object) => SourceDTO.fromJson(object))
          .toList();
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) {
        throw UpvibeTimeout();
      }
      if (ex.type == DioExceptionType.badResponse &&
          ex.response!.statusCode == 400) {
        throwErrorFromBadResponse(ex.response!);
      }
      rethrow;
    }
  }

  Future<SvgPicture> getSourceLogo(String id) async {
    try {
      await ensureAuthorized();
      var response = await dio.get('v1/sources/$id/logo');
      var file = response.data;
      return SvgPicture.string(file);
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) {
        throw UpvibeTimeout();
      }
      if (ex.type == DioExceptionType.badResponse &&
          ex.response!.statusCode == 400) {
        throwErrorFromBadResponse(ex.response!);
      }
      rethrow;
    }
  }

  Future<Uint8List?> getTagImage(String tagId) async {
    try {
      await ensureAuthorized();
      var response = await dio.get('v1/tags/$tagId/picture',
          options: Options(responseType: ResponseType.bytes));
      return response.data;
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) {
        throw UpvibeTimeout();
      }
      if (ex.type == DioExceptionType.badResponse &&
          ex.response!.statusCode == 400) {
        return null;
      }
      rethrow;
    }
  }

  Future<void> updateMapping(String fileId, TagMappingDTO mapping) async {
    try {
      await ensureAuthorized();
      await dio.put('v1/files/$fileId/tag-mapping', data: mapping.toJson());
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) {
        throw UpvibeTimeout();
      }
      if (ex.type == DioExceptionType.badResponse &&
          ex.response!.statusCode == 400) {
        throwErrorFromBadResponse(ex.response!);
      }
      rethrow;
    }
  }

  Future<TagMappingPriorityDTO> getTagMappingPriority() async {
    try {
      await ensureAuthorized();
      var response = await dio.get('v1/tags/tag-mapping-priority');
      var json = response.data;
      return TagMappingPriorityDTO.fromJson(json);
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) {
        throw UpvibeTimeout();
      }
      if (ex.type == DioExceptionType.badResponse &&
          ex.response!.statusCode == 400) {
        throwErrorFromBadResponse(ex.response!);
      }
      rethrow;
    }
  }

  Future<void> updateTagMappingPriority(TagMappingPriorityDTO priority) async {
    try {
      await ensureAuthorized();
      await dio.put('v1/tags/tag-mapping-priority', data: priority.toJson());
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) {
        throw UpvibeTimeout();
      }
      if (ex.type == DioExceptionType.badResponse &&
          ex.response!.statusCode == 400) {
        throwErrorFromBadResponse(ex.response!);
      }
      rethrow;
    }
  }

  Future<BinaryFileDTO> downloadFile(String id) async {
    try {
      await ensureAuthorized();
      var response = await dio.get('v1/files/$id/download',
          options: Options(
            responseType: ResponseType.bytes,
          ));
      final filename =
          response.headers['Content-Disposition']!.first.split('filename=')[1];
      return BinaryFileDTO(filename, response.data, 'Audio/mp3');
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) {
        throw UpvibeTimeout();
      }
      if (ex.type == DioExceptionType.badResponse &&
          ex.response!.statusCode == 400) {
        throwErrorFromBadResponse(ex.response!);
      }
      rethrow;
    }
  }

  Future<void> confirmFile(String id, String deviceId) async {
    try {
      await ensureAuthorized();
      await dio.post(
        'v1/files/$id/confirm',
        queryParameters: {
          'deviceId': deviceId,
        },
      );
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) {
        throw UpvibeTimeout();
      }
      if (ex.type == DioExceptionType.badResponse &&
          ex.response!.statusCode == 400) {
        throwErrorFromBadResponse(ex.response!);
      }
      rethrow;
    }
  }

  Future<PlaylistDTO> addPlaylist(String url) async {
    try {
      await ensureAuthorized();
      var response = await dio.post('v1/playlists', data: {'url': url});
      var json = response.data;
      return PlaylistDTO.fromJson(json);
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) throw UpvibeTimeout();
      if (ex.type == DioExceptionType.badResponse &&
          ex.response!.statusCode == 400) {
        throwErrorFromBadResponse(ex.response!);
      }
      rethrow;
    }
  }

  Future<List<PlaylistDTO>> getPlaylists() async {
    try {
      await ensureAuthorized();
      var response = await dio.get('v1/playlists');
      var json = response.data;
      return (json as List)
          .map((object) => PlaylistDTO.fromJson(object))
          .toList();
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) throw UpvibeTimeout();
      if (ex.type == DioExceptionType.badResponse &&
          ex.response!.statusCode == 400) {
        throwErrorFromBadResponse(ex.response!);
      }
      rethrow;
    }
  }
}
