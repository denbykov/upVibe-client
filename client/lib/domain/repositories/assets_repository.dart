import 'package:flutter_svg/svg.dart';

abstract class AssetsRepository {
  Future<void> loadAssets();

  Future<SvgPicture> getIconBySourceId(int id);
}
