abstract class AuthorizationRepository {
  Future<void> login();
  Future<void> logout();
}
