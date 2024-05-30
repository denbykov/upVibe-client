import 'package:client/domain/entities/binary_file.dart';
import 'package:flutter/foundation.dart';

class BinaryFileDTO {
  final String name;
  final Uint8List data;
  final String mimeType;

  BinaryFileDTO(this.name, this.data, this.mimeType);

  BinaryFile toEntity() {
    return BinaryFile(name, data, mimeType);
  }
}
