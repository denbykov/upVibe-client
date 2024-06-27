import 'package:client/domain/entities/source.dart';
import 'package:client/domain/entities/short_tags.dart';

class File {
  final String id;
  final Source source;
  final String status;
  final String sourceUrl;
  final bool isSynchronized;
  final ShortTags? shortTags;

  const File({
    required this.id,
    required this.source,
    required this.status,
    required this.sourceUrl,
    required this.isSynchronized,
    required this.shortTags,
  });
}
