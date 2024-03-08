import 'dart:async';

import 'package:client/data/dto/file_dto.dart';
import 'package:dio/dio.dart';

import 'package:client/exceptions/login_failure.dart';
import 'package:client/exceptions/upvibe_timeout.dart';

const appScheme = 'flutterdemo';

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
      rethrow;
    }
  }
}
