import 'package:flutter_svg/svg.dart';

abstract class AssetsRepository {
  Future<void> loadAssets();

  SvgPicture getIconBySourceId(String id);
}
