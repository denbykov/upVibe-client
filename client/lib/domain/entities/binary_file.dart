import 'package:flutter/foundation.dart';

class BinaryFile {
  final String name;
  final Uint8List data;
  final String mimeType;

  BinaryFile(this.name, this.data, this.mimeType);
}
