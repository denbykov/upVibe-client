import 'package:client/domain/entities/source.dart';

class SourceDTO {
  final int id;
  final String source;

  const SourceDTO({required this.id, required this.source});

  factory SourceDTO.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
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
