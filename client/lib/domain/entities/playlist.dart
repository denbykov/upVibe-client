import 'package:client/domain/entities/source.dart';

class Playlist {
  final String id;
  final Source source;
  final String status;
  final String? sourceUrl;
  final DateTime? synchronizationTs;
  final String? title;

  const Playlist({
    required this.id,
    required this.source,
    required this.status,
    required this.sourceUrl,
    required this.synchronizationTs,
    required this.title,
  });
}
