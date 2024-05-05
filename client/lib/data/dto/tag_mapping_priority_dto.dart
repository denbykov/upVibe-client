import 'package:client/domain/entities/tag_mapping_priority.dart';

class TagMappingPriorityDTO {
  final List<String> title;
  final List<String> artist;
  final List<String> album;
  final List<String> year;
  final List<String> trackNumber;
  final List<String> picture;

  TagMappingPriorityDTO({
    required this.title,
    required this.artist,
    required this.album,
    required this.year,
    required this.trackNumber,
    required this.picture,
  });

  factory TagMappingPriorityDTO.fromJson(Map<String, dynamic> json) {
    return TagMappingPriorityDTO(
      title: List<String>.from(json['title']),
      artist: List<String>.from(json['artist']),
      album: List<String>.from(json['album']),
      year: List<String>.from(json['year']),
      trackNumber: List<String>.from(json['trackNumber']),
      picture: List<String>.from(json['picture']),
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

  TagMappingPriority toEntity() {
    return TagMappingPriority(
      title: title,
      artist: artist,
      album: album,
      year: year,
      trackNumber: trackNumber,
      picture: picture,
    );
  }

  static TagMappingPriorityDTO fromEntity(TagMappingPriority entity) {
    return TagMappingPriorityDTO(
      title: entity.title,
      artist: entity.artist,
      album: entity.album,
      year: entity.year,
      trackNumber: entity.trackNumber,
      picture: entity.picture,
    );
  }
}
