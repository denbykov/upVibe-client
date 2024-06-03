import 'package:client/data/sqlite/migration_scripts/v1/create_files.dart'
    as create_files;

final List<String> changeset = [
  create_files.query,
];
