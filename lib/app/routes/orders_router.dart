import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:vaquinha_burger_mobile/app/modules/order/finished/finished_page.dart';
import 'package:vaquinha_burger_mobile/app/modules/order/pix/pix_page.dart';

class OrdersRouter {
  OrdersRouter._();

  static final routers = <GetPage>[
    GetPage(
      name: '/orders/finished',
      // binding: ProductDetailBindings(),
      page: () => FinishedPage(),
    ),
    GetPage(
      name: '/orders/pix',
      page: () => PixPage(),
    ),
  ];
}
