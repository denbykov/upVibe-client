import 'package:client/data/dto/source_dto.dart';

class File {
  final int id;
  final SourceDTO source;
  final String status;
  final String sourceUrl;

  const File(
      {required this.id,
      required this.source,
      required this.status,
      required this.sourceUrl});
}
