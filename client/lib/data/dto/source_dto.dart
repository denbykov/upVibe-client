import 'package:client/domain/entities/source.dart';

class SourceDTO {
  final String id;
  final String source;

  const SourceDTO({required this.id, required this.source});

  factory SourceDTO.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'source': String source,
      } =>
        SourceDTO(
          id: id,
          source: source,
        ),
      _ => throw const FormatException('Failed to load SourceDTO'),
    };
  }

  Source toEntity() {
    return Source(id: id, source: source);
  }
}
