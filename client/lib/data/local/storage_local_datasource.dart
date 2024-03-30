import 'dart:io';
import 'dart:ui';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static const String debugToken = 'debugToken';
}

class StorageLocalDatasource {
  late SharedPreferences _prefs;
  late PackageInfo _packageInfo;

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    _packageInfo = await PackageInfo.fromPlatform();
  }

  String getAppVesrion() {
    return _packageInfo.version;
  }

  Future<void> storeDebugAccessToken(String token) async {
    await _prefs.setString(Preferences.debugToken, token);
  }

  String? getDebugAccessToken() {
    return _prefs.getString(Preferences.debugToken);
  }

  Future<String> getIconPathBySourceId(int id) async {
    final directory = await getApplicationDocumentsDirectory();

    return '${directory.path}/icons/$id.svg';
  }

  Future<SvgPicture> getIconBySourceId(int id) async {
    final path = await getIconPathBySourceId(id);

    return SvgPicture.file(
      File(path),
      colorFilter:
          ColorFilter.mode(Get.theme.colorScheme.tertiary, BlendMode.srcIn),
    );
  }
}
