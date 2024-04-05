import 'package:get/get.dart';

import 'package:flutter_svg/svg.dart';

import 'package:client/domain/repositories/assets_repository.dart';

class AssetsController extends GetxController {
  final AssetsRepository _repository = Get.find<AssetsRepository>();

  Future<SvgPicture> getIconBySourceId(int id) async {
    return await _repository.getIconBySourceId(id);
  }
}
