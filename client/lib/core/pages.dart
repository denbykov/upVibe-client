import 'package:client/feature/home/pages/home_page.dart';
import 'package:get/get.dart';

import 'bindings/home_binding.dart';
import 'routes.dart';

import '../feature/home/pages/login_page.dart';

class Pages {
  static final List<GetPage> pages = [
    GetPage(
      name: Routes.login,
      page: () => LoginPage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => HomePage(),
      binding: HomeBinding(),
    )
  ];
}
