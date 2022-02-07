import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:vaquinha_burger_mobile/app/modules/home/home_bindings.dart';
import 'package:vaquinha_burger_mobile/app/modules/home/home_page.dart';

class HomeRouters {
  HomeRouters._();

  static final routers = <GetPage>[
    GetPage(
      name: '/HOME',
      binding: HomeBindings(),
      page: () => const HomePage(),
    ),
  ];
}
