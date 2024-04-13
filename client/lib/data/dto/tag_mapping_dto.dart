import 'package:client/domain/entities/tag_mapping.dart';

class TagMappingDTO {
  final String title;
  final String artist;
  final String album;
  final String year;
  final String trackNumber;
  final String picture;

  const TagMappingDTO({
    required this.title,
    required this.artist,
    required this.album,
    required this.year,
    required this.trackNumber,
    required this.picture,
  });

  factory TagMappingDTO.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'title': String title,
        'artist': String artist,
        'album': String album,
        'year': String year,
        'trackNumber': String trackNumber,
        'picture': String picture,
      } =>
        TagMappingDTO(
          title: title,
          artist: artist,
          album: album,
          year: year,
          trackNumber: trackNumber,
          picture: picture,
        ),
      _ => throw const FormatException('Failed to load TagMappingDTO'),
    };
  }

  TagMapping toEntity() {
    return TagMapping(
      title: title,
      artist: artist,
      album: album,
      year: year,
      trackNumber: trackNumber,
      picture: picture,
    );
  }

  factory TagMappingDTO.fromEntity(TagMapping entity) {
    return TagMappingDTO(
      title: entity.title,
      artist: entity.artist,
      album: entity.album,
      year: entity.year,
      trackNumber: entity.trackNumber,
      picture: entity.picture,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'artist': artist,
      'album': album,
      'year': year,
      'trackNumber': trackNumber,
      'picture': picture,
    };
  }
}
