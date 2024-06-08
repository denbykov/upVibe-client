import 'package:envied/envied.dart';
part 'env.g.dart';

@Envied(path: 'secrets.env')
abstract class Env {
  @EnviedField(varName: 'AUTH0_DOMAIN', obfuscate: true)
  static final String auth0Domain = _Env.auth0Domain;

  @EnviedField(varName: 'AUTH0_CLIENT_ID', obfuscate: true)
  static final String auth0ClientId = _Env.auth0ClientId;

  @EnviedField(varName: 'AUTH0_AUDIENCE', obfuscate: true)
  static final String auth0Audience = _Env.auth0Audience;
}
