import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:client/feature/theme.dart';

import 'pages.dart';
import 'routes.dart';

class App extends StatelessWidget {
  final bool inBrightMode;

  const App({super.key, required this.inBrightMode});

  @override
  Widget build(BuildContext context) {
    return FilesystemPickerDefaultOptions(
      fileTileSelectMode: FileTileSelectMode.wholeTile,
      theme: FilesystemPickerTheme(
        topBar: FilesystemPickerTopBarThemeData(
          backgroundColor: Colors.red[700],
        ),
      ),
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
        darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
        themeMode: inBrightMode ? ThemeMode.light : ThemeMode.dark,
        initialRoute: Routes.login,
        getPages: Pages.pages,
      ),
    );
  }
}
