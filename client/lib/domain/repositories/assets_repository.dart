import 'package:flutter_svg/svg.dart';

abstract class AssetsRepository {
  Future<void> donwloadIconBySourceId(int id);

  Future<SvgPicture> getIconBySourceId(int id);
}
