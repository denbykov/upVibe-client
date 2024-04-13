import 'package:client/domain/entities/tag.dart';

class TagDTO {
  final String id;
  final String fileId;
  final String source;
  final String status;
  final String? title;
  final String? artist;
  final String? album;
  final int? year;
  final int? trackNumber;

  const TagDTO({
    required this.id,
    required this.fileId,
    required this.source,
    required this.status,
    required this.title,
    required this.artist,
    required this.album,
    required this.year,
    required this.trackNumber,
  });

  factory TagDTO.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'fileId': String fileId,
        'source': String source,
        'status': String status,
        'title': String? title,
        'artist': String? artist,
        'album': String? album,
        'year': int? year,
        'trackNumber': int? trackNumber,
      } =>
        TagDTO(
          id: id,
          fileId: fileId,
          source: source,
          status: status,
          title: title,
          artist: artist,
          album: album,
          year: year,
          trackNumber: trackNumber,
        ),
      _ => throw const FormatException('Failed to load TagDTO'),
    };
  }

  Tag toEntity() {
    return Tag(
      id: id,
      fileId: fileId,
      source: source,
      status: status,
      title: title,
      artist: artist,
      album: album,
      year: year,
      trackNumber: trackNumber,
    );
  }
}
