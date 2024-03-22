import 'package:client/domain/entities/file.dart';

abstract class FileRepository {
  Future<void> addFile(String url);

  Future<List<File>> getFiles();

  Future<File> getFile(int id);
}
