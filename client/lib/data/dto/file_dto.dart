import 'package:client/data/dto/source_dto.dart';
import 'package:client/data/dto/short_tags_dto.dart';
import 'package:client/domain/entities/file.dart';

class FileDTO {
  final String id;
  final SourceDTO source;
  final String status;
  final String sourceUrl;
  final bool isSynchronized;
  final ShortTagsDTO? shortTags;

  const FileDTO({
    required this.id,
    required this.source,
    required this.status,
    required this.sourceUrl,
    required this.isSynchronized,
    required this.shortTags,
  });

  factory FileDTO.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'source': Map<String, dynamic> source,
        'status': String status,
        'sourceUrl': String sourceUrl,
        'isSynchronized': bool isSynchronized,
        'tags': Map<String, dynamic>? shortTags,
      } =>
        FileDTO(
          id: id,
          source: SourceDTO.fromJson(source),
          status: status,
          sourceUrl: sourceUrl,
          isSynchronized: isSynchronized,
          shortTags:
              shortTags != null ? ShortTagsDTO.fromJson(shortTags) : null,
        ),
      _ => throw const FormatException('Failed to load FileDTO'),
    };
  }

  File toEntity() {
    return File(
      id: id,
      source: source.toEntity(),
      status: status,
      sourceUrl: sourceUrl,
      isSynchronized: isSynchronized,
      shortTags: shortTags?.toEntity(),
    );
  }
}
