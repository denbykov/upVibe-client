import 'package:get/get.dart';

import 'package:client/core/routes.dart';

import 'package:client/domain/entities/file.dart';

class FileListItemController extends GetxController {
  void onTapped(File file) {
    Get.toNamed(Routes.file, arguments: {'id': file.id.toString()});
  }
}
