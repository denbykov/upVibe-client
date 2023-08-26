import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart' hide Table, Column;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import 'tables/server_connections.dart';
import 'tables/authentication.dart';

import 'schema_versions.dart';

part 'database.g.dart';

@DriftDatabase(tables: [ServerConnections, Authentication])
class Database extends _$Database {
  static final Database _instance = Database._internal();

  factory Database() {
    return _instance;
  }

  Database._internal() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: stepByStep(
        from1To2: (m, schema) async {
          await m.createTable(schema.authentication);
        },
        from2To3: (m, schema) async {
          await m.addColumn(
              schema.authentication, schema.authentication.accessToken);
        },
      ),
    );
  }

  Future<ServerConnection?> getServerConnection() async {
    var connections = await select(serverConnections).get();
    if (connections.length > 1) {
      throw Exception('Unexpected multiple serverConnection entries');
    }
    if (connections.isEmpty) {
      return null;
    }
    return connections.first;
  }

  Future<void> setServerConnection(ServerConnectionsCompanion entry) async {
    await delete(serverConnections).go();
    await into(serverConnections).insert(entry);
  }

  Future<void> setAuthentication(AuthenticationCompanion entry) async {
    await delete(authentication).go();
    await into(authentication).insert(entry);
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'db.sqlite'));

    debugPrint(path.join(dbFolder.path, 'db.sqlite'));

    return NativeDatabase.createInBackground(file);
  });
}
