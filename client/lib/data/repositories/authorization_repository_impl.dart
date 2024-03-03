import 'package:client/domain/repositories/authorization_repository.dart';
import 'package:client/data/remote/authorization_remote_datasource.dart';
import 'package:client/data/remote/upvibe_remote_datasource.dart';

import 'package:get/get.dart';

class AuthorizationRepositoryImpl extends AuthorizationRepository {
  final AuthorizationRemoteDatasource _authDatasource =
      Get.find<AuthorizationRemoteDatasource>();

  final UpvibeRemoteDatasource _upvibeDatasource =
      Get.find<UpvibeRemoteDatasource>();

  @override
  Future<void> login() async {
    var token = await _authDatasource.login();
    _upvibeDatasource.setAccessToken(token);
    await _upvibeDatasource.testConnection();
  }

  @override
  Future<void> logout() async {
    _authDatasource.logout();
  }
}
