import 'package:client/data/dto/source_dto.dart';

class ShortTagsDTO {
  final String? title;
  final String? artist;
  final String? album;
  final int? year;
  final int? trackNumber;

  const ShortTagsDTO({
    required this.title,
    required this.artist,
    required this.album,
    required this.year,
    required this.trackNumber,
  });

  factory ShortTagsDTO.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'title': String? title,
        'artist': String? artist,
        'album': String? album,
        'year': int? year,
        'trackNumber': int? trackNumber,
      } =>
        ShortTagsDTO(
          title: title,
          artist: artist,
          album: album,
          year: year,
          trackNumber: trackNumber,
        ),
      _ => throw const FormatException('Failed to load ShortTagsDTO'),
    };
  }
}

class FileDTO {
  final int id;
  final SourceDTO source;
  final String status;
  final String sourceUrl;
  final ShortTagsDTO? shortTags;

  const FileDTO({
    required this.id,
    required this.source,
    required this.status,
    required this.sourceUrl,
    required this.shortTags,
  });

  factory FileDTO.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'source': Map<String, dynamic> source,
        'status': String status,
        'sourceUrl': String sourceUrl,
        'tags': Map<String, dynamic>? shortTags,
      } =>
        FileDTO(
          id: id,
          source: SourceDTO.fromJson(source),
          status: status,
          sourceUrl: sourceUrl,
          shortTags:
              shortTags != null ? ShortTagsDTO.fromJson(shortTags) : null,
        ),
      _ => throw const FormatException('Failed to load FileDTO'),
    };
  }
}
