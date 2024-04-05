import 'package:flutter_svg/svg.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:device_info_plus/device_info_plus.dart';

class Preferences {
  static const String debugToken = 'debugToken';
  static const String uuid = 'uuid';
}

class StorageLocalDatasource {
  late SharedPreferences _prefs;
  late PackageInfo _packageInfo;
  late DeviceInfoPlugin _deviceInfo;

  final _sourceIcons = <int, SvgPicture>{};

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    _packageInfo = await PackageInfo.fromPlatform();
    _deviceInfo = DeviceInfoPlugin();
  }

  String getAppVesrion() {
    return _packageInfo.version;
  }

  Future<String> getDeviceName() async {
    AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
    return androidInfo.model;
  }

  Future<void> storeDebugAccessToken(String token) async {
    await _prefs.setString(Preferences.debugToken, token);
  }

  String? getDebugAccessToken() {
    return _prefs.getString(Preferences.debugToken);
  }

  Future<SvgPicture> getIconBySourceId(int id) async {
    return _sourceIcons[id]!;
  }

  String? getUuid() {
    return _prefs.getString(Preferences.uuid);
  }

  Future<void> storeUuid(String uuid) async {
    await _prefs.setString(Preferences.uuid, uuid);
  }

  Future<void> cacheSourceLogo(int id, SvgPicture logo) async {
    _sourceIcons[id] = logo;
  }
}
