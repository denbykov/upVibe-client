import 'package:drift/drift.dart';

class Authentication extends Table {
  TextColumn get refreshToken => text()();
  TextColumn get accessToken => text()();
}
