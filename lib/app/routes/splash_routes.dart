import 'package:get/route_manager.dart';
import 'package:vaquinha_burger_mobile/app/modules/splash/splash_bindings.dart';
import 'package:vaquinha_burger_mobile/app/modules/splash/splash_page.dart';

class SplashRouters {
  SplashRouters._();

  static final routers = <GetPage>[
    GetPage(
      name: '/',
      binding: SplashBindings(),
      page: () => const SplashPage(),
    ),
  ];
}
