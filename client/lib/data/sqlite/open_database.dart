import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

import 'package:client/data/sqlite/migration_scripts/v1/changeset.dart' as v1;

Future onConfigure(Database db) async {
  await db.execute('PRAGMA foreign_keys = ON');
}

Future<Database> openDatabase() async {
  final databasesPath = await getDatabasesPath();
  const dbName = 'upvibe.db';
  final fullPath = path.join(databasesPath, dbName);

  const databaseVersion = 1;

  try {
    await Directory(databasesPath).create(recursive: true);
    // await databaseFactory.deleteDatabase(fullPath);
  } catch (_) {}

  return await databaseFactory.openDatabase(
    fullPath,
    options: OpenDatabaseOptions(
      version: databaseVersion,
      onConfigure: onConfigure,
      onUpgrade: (db, oldVersion, newVersion) async {
        var batch = db.batch();

        if (oldVersion == 0 && newVersion >= 1) {
          for (var script in v1.changeset) {
            batch.execute(script);
          }
        }

        await batch.commit();
      },
      onDowngrade: onDatabaseDowngradeDelete,
    ),
  );
}
