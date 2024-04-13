import 'package:get/get.dart';

import 'package:flutter_svg/svg.dart';

import 'package:client/domain/repositories/assets_repository.dart';

class SourceIconController extends GetxController {
  final AssetsRepository _repository = Get.find<AssetsRepository>();

  final data = Rxn<SvgPicture>();

  Future<void> loadIconBySourceId(String id) async {
    data.value = _repository.getIconBySourceId(id);
  }
}
