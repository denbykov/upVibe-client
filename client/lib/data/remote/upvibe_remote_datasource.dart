import 'dart:async';

import 'package:client/data/dto/file_dto.dart';
import 'package:dio/dio.dart';

import 'package:client/exceptions/login_failure.dart';
import 'package:client/exceptions/upvibe_timeout.dart';
import 'package:client/exceptions/upvibe_error.dart';

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

  UpvibeRemoteDatasource() {
    dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 3),
      baseUrl: 'https://10.0.2.2:3000/up-vibe/',
      responseType: ResponseType.json,
    ));
  }

  void setAccessToken(String accessToken) {
    dio.options.headers['authorization'] = 'Bearer $accessToken';
  }

  Future<void> testConnection() async {
    try {
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

  Future<void> downloadIconBySourceId(int id, String path) async {
    try {
      final tempDio = Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 3),
        baseUrl: 'http://10.0.2.2:8000/',
      ));

      await tempDio.download(
        'icons/youtube-logo.svg',
        path,
      );
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) throw UpvibeTimeout();
      if (ex.type == DioExceptionType.badResponse &&
          ex.response!.statusCode == 400) {
        throwErrorFromBadResponse(ex.response!);
      }
      rethrow;
    }
  }

  Future<List<FileDTO>> getFiles() async {
    try {
      var response = await dio.get('v1/files');
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

  Future<FileDTO> getFile(int id) async {
    try {
      var response = await dio.get('v1/files/$id');
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
}
