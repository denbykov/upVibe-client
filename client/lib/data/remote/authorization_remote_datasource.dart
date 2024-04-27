import 'package:auth0_flutter/auth0_flutter.dart';

import 'package:client/exceptions/login_failure.dart';

import 'package:client/data/dto/tokens_dto.dart';
import 'package:dio/dio.dart';

const appScheme = 'flutterdemo';

class AuthorizationRemoteDatasource {
  late Auth0 _auth0;
  late Dio _dio;

  AuthorizationRemoteDatasource() {
    _auth0 = Auth0('up-vibe.eu.auth0.com', 'NsrwVzfSOpezBAZAwn10LytMShLlpKlf');
    _dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 3),
      baseUrl: 'https://up-vibe.eu.auth0.com/oauth/',
      responseType: ResponseType.json,
    ));
    _dio.options.headers['content-type'] = 'application/x-www-form-urlencoded';
  }

  Future<TokensDTO> login() async {
    try {
      var credentials = await _auth0.webAuthentication(scheme: appScheme).login(
          audience: 'volodymyr-test-null',
          scopes: {'openid', 'profile', 'email', 'offline_access'});

      return TokensDTO(
          accessToken: credentials.accessToken,
          refreshToken: credentials.refreshToken!);
    } on WebAuthenticationException {
      throw LoginFailure();
    }
  }

  Future<TokensDTO?> refreshToken(String refreshToken) async {
    try {
      var response = await _dio.post('token', data: {
        'grant_type': 'refresh_token',
        'client_id': 'NsrwVzfSOpezBAZAwn10LytMShLlpKlf',
        'refresh_token': refreshToken
      });
      var json = response.data;

      return TokensDTO(
          accessToken: json['access_token'],
          refreshToken: json['refresh_token']);
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.badResponse) {
        if (ex.response!.data['error_description'] ==
            'Unknown or invalid refresh token.') {
          throw LoginFailure(
              message: ex.response!.data['error_description'],
              type: LoginFailureType.invalidRefreshToken);
        }
        throw LoginFailure(message: ex.response!.data['error_description']);
      }
    } catch (e) {
      throw LoginFailure();
    }

    return null;
  }

  Future<void> logout() async {
    await _auth0.webAuthentication(scheme: appScheme).logout();
  }
}
