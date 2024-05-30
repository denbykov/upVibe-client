class LocalFile {
  final String id;
  final String remoteId;
  final String path;
  final DateTime createdAt;
  final DateTime updatedAt;

  const LocalFile({
    required this.id,
    required this.remoteId,
    required this.path,
    required this.createdAt,
    required this.updatedAt,
  });
}
