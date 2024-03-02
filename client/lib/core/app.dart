import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages.dart';
import 'routes.dart';
// import 'bindings/home_binding.dart';

// import '../feature/home/pages/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pink,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      initialRoute: Routes.home,
      getPages: Pages.pages,
    );
  }
}
