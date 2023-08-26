import 'dart:convert';
import '../application/request_agent.dart';

class ApiInfo {
  final String message;

  const ApiInfo({required this.message});

  factory ApiInfo.fromJson(Map<String, dynamic> json) {
    return ApiInfo(
      message: json['message'],
    );
  }
}

class ApiInfoModel {
  final _requestAgent = RequestAgent();

  Future<ApiInfo> getApiInfo(
      {required String host, required String port}) async {
    try {
      _requestAgent.setBaseUrl(host, port);
      var response = await _requestAgent.get(uri: '/v1/info');

      if (response.statusCode == 200) {
        return ApiInfo.fromJson(jsonDecode(response.body));
      } else {
        return Future.error("Bad request");
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
