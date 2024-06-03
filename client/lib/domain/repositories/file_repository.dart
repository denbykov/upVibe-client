import 'package:client/domain/entities/extended_file.dart';
import 'package:client/domain/entities/file.dart';
import 'package:client/domain/entities/binary_file.dart';
import 'package:client/domain/entities/local_file.dart';

abstract class FileRepository {
  Future<File> addFile(String url);

  Future<List<File>> getFiles(String deviceId,
      {List<String>? statuses, bool? isSynronized});

  Future<ExtendedFile> getFile(String id, String deviceId);

  Future<BinaryFile> downloadFile(String id);

  Future<void> confirmFile(String id, String deviceId);

  Future<void> upsertFile(LocalFile file);
}
