import 'package:client/feature/home/pages/home_page.dart';
import 'package:get/get.dart';

import 'bindings/home_binding.dart';
import 'routes.dart';

import 'package:client/feature/home/pages/login_page.dart';
import 'package:client/feature/home/pages/splash_screen_page.dart';
import 'package:client/feature/home/pages/settings_page.dart';

class Pages {
  static final List<GetPage> pages = [
    GetPage(
      name: Routes.splashScreen,
      page: () => SplashScreenPage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => LoginPage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.settings,
      page: () => SettingsPage(),
      binding: HomeBinding(),
    )
  ];
}
