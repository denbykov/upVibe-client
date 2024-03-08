import 'package:client/data/dto/source_dto.dart';

class FileDTO {
  final int id;
  final SourceDTO source;
  final String status;
  final String sourceUrl;

  const FileDTO(
      {required this.id,
      required this.source,
      required this.status,
      required this.sourceUrl});

  factory FileDTO.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'source': Map<String, dynamic> source,
        'status': String status,
        'sourceUrl': String sourceUrl,
      } =>
        FileDTO(
          id: id,
          source: SourceDTO.fromJson(source),
          status: status,
          sourceUrl: sourceUrl,
        ),
      _ => throw const FormatException('Failed to load FileDTO'),
    };
  }
}
