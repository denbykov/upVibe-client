import 'package:get/get.dart';

import 'bindings/home_binding.dart';
import 'routes.dart';

import '../feature/home/pages/login_page.dart';

class Pages {
  static final List<GetPage> pages = [
    GetPage(
      name: Routes.home,
      page: () => LoginPage(),
      binding: HomeBinding(),
    )
  ];
}
