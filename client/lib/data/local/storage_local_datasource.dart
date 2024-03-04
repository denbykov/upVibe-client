import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class StorageLocalDatasource {
  StorageLocalDatasource() {}

  Future<void> initialize() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    debugPrint('$appName $packageName $version $buildNumber');
  }
}
