import '../application/request_agent.dart';

class AuthenticationModel {
  final _requestAgent = RequestAgent();

  Future<bool> login({required String username, required String password}) {
    return _requestAgent.login(
        credentials: Credentials(username: username, password: password));
  }
}
