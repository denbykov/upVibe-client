import 'package:client/domain/repositories/authorization_repository.dart';
import 'package:client/data/remote/authorization_remote_datasource.dart';

import 'package:get/get.dart';

class AuthorizationRepositoryImpl extends AuthorizationRepository {
  final AuthorizationRemoteDatasource _datasource =
      Get.find<AuthorizationRemoteDatasource>();

  @override
  Future<void> login() async {
    return _datasource.login();
  }

  @override
  Future<void> logout() async {
    return _datasource.logout();
  }
}
