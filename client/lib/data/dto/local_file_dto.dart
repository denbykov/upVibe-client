import 'package:client/domain/entities/local_file.dart';

class LocalFileDTO {
  final String id;
  final String remoteId;
  final String path;
  final DateTime createdAt;
  final DateTime updatedAt;

  const LocalFileDTO({
    required this.id,
    required this.remoteId,
    required this.path,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LocalFileDTO.fromEntity(LocalFile entity) {
    return LocalFileDTO(
      id: entity.id,
      remoteId: entity.remoteId,
      path: entity.path,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'remoteId': remoteId,
      'path': path,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
