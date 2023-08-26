import 'dart:convert';

import 'package:drift/drift.dart';
import '../database/database.dart';

import 'package:http/http.dart' as http;

class Credentials {
  final String username;
  final String password;

  const Credentials({required this.username, required this.password});

  Map<String, dynamic> toJson() => {
        'name': username,
        'password': password,
      };
}

class RequestAgent {
  static final RequestAgent _instance = RequestAgent._internal();
  final _database = Database();

  String? _refreshToken;
  String? _accessToken;

  factory RequestAgent() {
    return _instance;
  }

  String? _baseUrl;

  RequestAgent._internal() {
    // var connectionData = await _database.getServerConnection();
  }

  void setBaseUrl(String host, String port) {
    _baseUrl = 'https://$host:$port/up-vibe';
  }

  Future<http.Response> get({required String uri}) {
    return http.get(Uri.parse('$_baseUrl$uri'));
  }

  Future<void> storeTokens() async {
    await _database.setAuthentication(
      AuthenticationCompanion(
        refreshToken: Value(_refreshToken!),
        accessToken: Value(_accessToken!),
      ),
    );
  }

  Future<bool> login({required Credentials credentials}) async {
    try {
      var response = await http.post(Uri.parse('$_baseUrl/v1/auth/login'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(credentials.toJson()));

      if (response.statusCode == 200) {
        var tokens = jsonDecode(response.body);
        _accessToken = tokens['accessToken'];
        _refreshToken = tokens['refreshToken'];
        await storeTokens();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
