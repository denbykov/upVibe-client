import "../repositories/authorization_repository.dart";

class LoginUseCase {
  final AuthorizationRepository _repository;

  LoginUseCase(this._repository);

  Future<bool> call() async {
    await _repository.login();
    return true;
  }
}
