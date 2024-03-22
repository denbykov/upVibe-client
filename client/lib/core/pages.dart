import 'package:client/feature/file/pages/file_page.dart';
import 'package:client/feature/home/pages/home_page.dart';
import 'package:get/get.dart';

import 'bindings/home_binding.dart';
import 'routes.dart';

import 'package:client/feature/home/pages/login_page.dart';
import 'package:client/feature/home/pages/splash_screen_page.dart';
import 'package:client/feature/home/pages/settings_page.dart';
import 'package:client/feature/home/pages/add_page.dart';
import 'package:client/feature/file/pages/add_file_page.dart';
import 'package:client/feature/file/pages/files_page.dart';

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
    ),
    GetPage(
      name: Routes.add,
      page: () => AddPage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.addFile,
      page: () => AddFilePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.files,
      page: () => FilesPage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.file,
      page: () => FilePage(),
      binding: HomeBinding(),
    )
  ];
}
