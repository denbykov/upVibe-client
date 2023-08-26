import 'package:drift/drift.dart';

class ServerConnections extends Table {
  TextColumn get host => text()();
  IntColumn get port => integer()();
}
