import 'package:client/domain/entities/short_tags.dart';

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

  ShortTags toEntity() {
    return ShortTags(
      title: title,
      artist: artist,
      album: album,
      year: year,
      trackNumber: trackNumber,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'artist': artist,
      'album': album,
      'year': year,
      'trackNumber': trackNumber,
    };
  }

  factory ShortTagsDTO.fromEntity(ShortTags entity) {
    return ShortTagsDTO(
      title: entity.title,
      artist: entity.artist,
      album: entity.album,
      year: entity.year,
      trackNumber: entity.trackNumber,
    );
  }
}
