import 'package:client/domain/entities/file.dart';

abstract class FileRepository {
  Future<File> addFile(String url);

  Future<List<File>> getFiles();

  Future<File> getFile(int id);
}
