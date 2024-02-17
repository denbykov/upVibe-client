import 'package:auth0_flutter/auth0_flutter.dart';

const appScheme = 'flutterdemo';

class AuthorizationRemoteDatasource {
  late Auth0 _auth0;
  Credentials? _credentials;

  AuthorizationRemoteDatasource() {
    _auth0 = Auth0('up-vibe.eu.auth0.com', 'NsrwVzfSOpezBAZAwn10LytMShLlpKlf');
  }

  Future<void> login() async {
    _credentials = await _auth0
        .webAuthentication(scheme: appScheme)
        .login(audience: 'volodymyr-test-null');
  }

  Future<void> logout() async {
    await _auth0.webAuthentication(scheme: appScheme).logout();
  }
}
