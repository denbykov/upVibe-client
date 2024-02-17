import '../../domain/repositories/authorization_repository.dart';
import '../remote/authorization_remote_datasource.dart';

class AuthorizationRepositoryImpl extends AuthorizationRepository {
  final AuthorizationRemoteDatasource _datasource;

  AuthorizationRepositoryImpl(this._datasource);

  @override
  Future<void> login() async {
    return _datasource.login();
  }

  @override
  Future<void> logout() async {
    return _datasource.logout();
  }
}
