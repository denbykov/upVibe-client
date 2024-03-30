class Tag {
  final int id;
  final int fileId;
  final int source;
  final String status;
  final String? title;
  final String? artist;
  final String? album;
  final int? year;
  final int? trackNumber;

  const Tag({
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
}
