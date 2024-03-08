import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:client/feature/theme.dart';

import 'pages.dart';
import 'routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      themeMode: ThemeMode.dark,
      initialRoute: Routes.splashScreen,
      getPages: Pages.pages,
    );
  }
}
