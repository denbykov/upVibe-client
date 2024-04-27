enum LoginFailureType { invalidRefreshToken, unknownError }

class LoginFailure implements Exception {
  final String? message;
  LoginFailureType type;

  @override
  String toString() {
    String result = 'LoginFailure';
    if (message is String) return '$result: $message';
    return result;
  }

  LoginFailure({this.message, this.type = LoginFailureType.unknownError});
}
