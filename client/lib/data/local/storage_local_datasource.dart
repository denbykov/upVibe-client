import 'package:client/data/dto/tokens_dto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
  late FlutterSecureStorage _secureStorage;

  final _sourceIcons = <String, SvgPicture>{};

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    _packageInfo = await PackageInfo.fromPlatform();
    _deviceInfo = DeviceInfoPlugin();

    AndroidOptions getAndroidOptions() => const AndroidOptions(
          encryptedSharedPreferences: true,
        );

    _secureStorage = FlutterSecureStorage(aOptions: getAndroidOptions());
  }

  String getAppVesrion() {
    return _packageInfo.version;
  }

  Future<String> getDeviceName() async {
    AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
    return androidInfo.model;
  }

  SvgPicture getIconBySourceId(String id) {
    return _sourceIcons[id]!;
  }

  String? getUuid() {
    return _prefs.getString(Preferences.uuid);
  }

  Future<void> storeUuid(String uuid) async {
    await _prefs.setString(Preferences.uuid, uuid);
  }

  Future<void> cacheSourceLogo(String id, SvgPicture logo) async {
    _sourceIcons[id] = logo;
  }

  Future<TokensDTO?> getTokens() async {
    String? refreshToken = await _secureStorage.read(key: "refreshToken");
    String? accessToken = await _secureStorage.read(key: "accessToken");

    if (refreshToken != null && accessToken != null) {
      return TokensDTO(accessToken: accessToken, refreshToken: refreshToken);
    }
    return null;
  }

  Future<void> storeTokens(TokensDTO tokens) async {
    await _secureStorage.write(key: "refreshToken", value: tokens.refreshToken);
    await _secureStorage.write(key: "accessToken", value: tokens.accessToken);
  }
}
