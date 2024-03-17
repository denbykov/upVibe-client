enum UpvibeErrorType { generic }

class UpvibeError implements Exception {
  final String message;
  final UpvibeErrorType type;

  String errMsg() => message;

  const UpvibeError(
      {required this.message, this.type = UpvibeErrorType.generic});
}
