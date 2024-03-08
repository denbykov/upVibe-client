import 'package:auth0_flutter/auth0_flutter.dart';

import 'package:client/exceptions/login_failure.dart';

const appScheme = 'flutterdemo';

class AuthorizationRemoteDatasource {
  late Auth0 _auth0;

  AuthorizationRemoteDatasource() {
    _auth0 = Auth0('up-vibe.eu.auth0.com', 'NsrwVzfSOpezBAZAwn10LytMShLlpKlf');
  }

  Future<String> login() async {
    try {
      var credentials = await _auth0
          .webAuthentication(scheme: appScheme)
          .login(audience: 'volodymyr-test-null');

      return credentials.accessToken;
    } on WebAuthenticationException {
      throw LoginFailure();
    }
  }

  Future<void> logout() async {
    await _auth0.webAuthentication(scheme: appScheme).logout();
  }
}
