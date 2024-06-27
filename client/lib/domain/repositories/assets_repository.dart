import 'package:flutter_svg/svg.dart';
import 'package:client/domain/entities/source.dart';

abstract class AssetsRepository {
  Future<void> loadAssets();

  SvgPicture getIconBySourceId(String id);

  Future<List<Source>> getSources();
}
