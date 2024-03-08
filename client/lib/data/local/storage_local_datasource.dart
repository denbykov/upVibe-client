import 'package:package_info_plus/package_info_plus.dart';

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
}
