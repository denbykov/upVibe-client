import 'package:client/domain/entities/extended_file.dart';
import 'package:client/domain/entities/file.dart';

abstract class FileRepository {
  Future<File> addFile(String url);

  Future<List<File>> getFiles();

  Future<ExtendedFile> getFile(String id);
}
