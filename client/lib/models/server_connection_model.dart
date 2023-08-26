import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import '../database/database.dart';

class _ServerConnection {
  String? host;
  int? port;
}

class ServerConnectionModel extends ChangeNotifier {
  final _database = Database();

  final _serverConnection = _ServerConnection();

  String? get host => _serverConnection.host;
  set host(String? host) => _serverConnection.host = host;

  int? get port => _serverConnection.port;
  set port(int? port) => _serverConnection.port = port;

  ServerConnectionModel() {
    read();
  }

  Future<void> read() async {
    var connectionData = await _database.getServerConnection();
    if (connectionData != null) {
      _serverConnection
        ..host = connectionData.host
        ..port = connectionData.port;
    }
    notifyListeners();
  }

  Future<void> write() async {
    await _database.setServerConnection(
      ServerConnectionsCompanion(
        host: Value(_serverConnection.host!),
        port: Value(_serverConnection.port!),
      ),
    );
    notifyListeners();
  }
}
