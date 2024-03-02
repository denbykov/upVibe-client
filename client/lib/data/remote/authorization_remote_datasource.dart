import 'package:auth0_flutter/auth0_flutter.dart';

import 'package:client/exceptions/login_failure.dart';

const appScheme = 'flutterdemo';

class AuthorizationRemoteDatasource {
  late Auth0 _auth0;
  Credentials? _credentials;

  AuthorizationRemoteDatasource() {
    _auth0 = Auth0('up-vibe.eu.auth0.com', 'NsrwVzfSOpezBAZAwn10LytMShLlpKlf');
  }

  Future<void> login() async {
    try {
      _credentials = await _auth0
          .webAuthentication(scheme: appScheme)
          .login(audience: 'volodymyr-test-null');
    } on WebAuthenticationException catch (ex) {
      throw LoginFailure();
    }
  }

  Future<void> logout() async {
    await _auth0.webAuthentication(scheme: appScheme).logout();
  }
}
