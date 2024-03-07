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
      theme: themeData,
      initialRoute: Routes.splashScreen,
      getPages: Pages.pages,
    );
  }
}
