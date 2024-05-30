import 'dart:io';

import 'package:client/data/dto/tokens_dto.dart';
import 'package:client/domain/entities/binary_file.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart' as p;

import 'package:shared_preferences/shared_preferences.dart';

import 'package:device_info_plus/device_info_plus.dart';

class StorageKeys {
  static const String debugToken = 'debugToken';
  static const String uuid = 'uuid';
  static const String defaultFilePath = 'defaultFilePath';
  static const String appState = 'appState';
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
    return _prefs.getString(StorageKeys.uuid);
  }

  Future<void> storeUuid(String uuid) async {
    await _prefs.setString(StorageKeys.uuid, uuid);
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

  Future<void> saveFile(BinaryFile file, String path) async {
    final filePath = p.join(path, file.name);

    await File(filePath).writeAsBytes(file.data);
  }

  Future<void> storeDefaultFilePath(String? data) async {
    if (data == null && _prefs.containsKey(StorageKeys.defaultFilePath)) {
      await _prefs.remove(StorageKeys.defaultFilePath);
    } else {
      await _prefs.setString(StorageKeys.defaultFilePath, data!);
    }
  }

  String? getDefaultFilePath() {
    return _prefs.getString(StorageKeys.defaultFilePath);
  }

  Future<void> setAppStatus(bool isActive) async {
    await _prefs.setBool(StorageKeys.appState, isActive);
  }

  bool? getAppStatus() {
    return _prefs.getBool(StorageKeys.appState);
  }
}
