import 'package:client/data/dto/source_dto.dart';
import 'package:client/domain/entities/playlist.dart';

class PlaylistDTO {
  final String id;
  final SourceDTO source;
  final String status;
  final String? sourceUrl;
  final DateTime? synchronizationTs;
  final String? title;

  const PlaylistDTO({
    required this.id,
    required this.source,
    required this.status,
    required this.sourceUrl,
    required this.synchronizationTs,
    required this.title,
  });

  factory PlaylistDTO.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'source': Map<String, dynamic> source,
        'status': String status,
        'sourceUrl': String? sourceUrl,
        'synchronizationTs': String? syncrhonizationTs,
        'title': String? title,
      } =>
        PlaylistDTO(
          id: id,
          source: SourceDTO.fromJson(source),
          status: status,
          sourceUrl: sourceUrl,
          synchronizationTs: syncrhonizationTs != null
              ? DateTime.parse(syncrhonizationTs)
              : null,
          title: title,
        ),
      _ => throw const FormatException('Failed to load PlatlistDTO'),
    };
  }

  Playlist toEntity() {
    return Playlist(
      id: id,
      source: source.toEntity(),
      status: status,
      sourceUrl: sourceUrl,
      synchronizationTs: synchronizationTs,
      title: title,
    );
  }
}
