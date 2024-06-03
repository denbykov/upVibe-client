import 'package:client/data/dto/local_file_dto.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:client/data/sqlite/open_database.dart' as open_database;

class UpvibeLocalDatasource {
  late Database _database;

  Future<void> initialize() async {
    _database = await open_database.openDatabase();
  }

  Future<void> upsertFile(LocalFileDTO file) async {
    final data = file.toMap();
    data.remove('id');

    try {
      await _database.insert(
        'files',
        data,
        conflictAlgorithm: ConflictAlgorithm.fail,
      );
      return;
    } catch (e) {
      debugPrint(e.toString());
    }

    await _database.update(
      'files',
      file.toMap(),
      where: 'id = ?',
      whereArgs: [file.id],
    );
  }
}
