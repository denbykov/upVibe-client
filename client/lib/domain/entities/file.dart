import 'package:client/domain/entities/source.dart';

class ShortTags {
  final String? title;
  final String? artist;
  final String? album;
  final int? year;
  final int? trackNumber;

  const ShortTags({
    required this.title,
    required this.artist,
    required this.album,
    required this.year,
    required this.trackNumber,
  });
}

class File {
  final int id;
  final Source source;
  final String status;
  final String sourceUrl;
  final ShortTags? shortTags;

  const File({
    required this.id,
    required this.source,
    required this.status,
    required this.sourceUrl,
    required this.shortTags,
  });
}
