import 'package:get/get.dart';

import 'bindings/home_binding.dart';
import 'routes.dart';

import '../feature/home/pages/home_page.dart';

class Pages {
  static final List<GetPage> pages = [
    GetPage(
      name: Routes.home,
      page: () => HomePage(),
      binding: HomeBinding(),
    )
  ];
}
