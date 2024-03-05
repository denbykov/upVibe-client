import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static const String debugToken = 'debugToken';
}

class StorageLocalDatasource {
  late SharedPreferences _prefs;

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    debugPrint('$appName $packageName $version $buildNumber');
  }

  Future<void> storeDebugAccessToken(String token) async {
    await _prefs.setString(Preferences.debugToken, token);
  }

  String? getDebugAccessToken() {
    return _prefs.getString(Preferences.debugToken);
  }
}
