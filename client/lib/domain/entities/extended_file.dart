import 'package:client/domain/entities/file.dart';
import 'package:client/domain/entities/tag_mapping.dart';

class ExtendedFile {
  final File file;
  final TagMapping? mapping;

  const ExtendedFile({
    required this.file,
    required this.mapping,
  });
}
