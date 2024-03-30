import 'package:client/domain/entities/tag.dart';

class TagDTO {
  final int id;
  final int fileId;
  final int source;
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
    return TagDTO(
      id: json['id'] as int,
      fileId: json['fileId'] as int,
      source: json['source'] as int,
      status: json['status'] as String,
      title: json['title'] as String?,
      artist: json['artist'] as String?,
      album: json['album'] as String?,
      year: json['year'] as int?,
      trackNumber: json['trackNumber'] as int?,
    );
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
