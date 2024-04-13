import 'package:client/data/dto/file_dto.dart';
import 'package:client/data/dto/tag_mapping_dto.dart';

import 'package:client/domain/entities/extended_file.dart';

class ExtendedFileDTO {
  final FileDTO file;
  final TagMappingDTO? mapping;

  const ExtendedFileDTO({
    required this.file,
    required this.mapping,
  });

  factory ExtendedFileDTO.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'file': Map<String, dynamic> file,
        'mapping': Map<String, dynamic>? mapping,
      } =>
        ExtendedFileDTO(
          file: FileDTO.fromJson(file),
          mapping: mapping != null ? TagMappingDTO.fromJson(mapping) : null,
        ),
      _ => throw const FormatException('Failed to load ExtendedFileDTO {'),
    };
  }

  ExtendedFile toEntity() {
    return ExtendedFile(
      file: file.toEntity(),
      mapping: mapping?.toEntity(),
    );
  }
}
