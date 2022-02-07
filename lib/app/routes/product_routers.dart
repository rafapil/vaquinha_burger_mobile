import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:vaquinha_burger_mobile/app/modules/home/home_bindings.dart';
import 'package:vaquinha_burger_mobile/app/modules/home/home_page.dart';
import 'package:vaquinha_burger_mobile/app/modules/product_detail/product_detail_bindings.dart';
import 'package:vaquinha_burger_mobile/app/modules/product_detail/product_detail_page.dart';

class ProductRouters {
  ProductRouters._();

  static final routers = <GetPage>[
    GetPage(
      name: '/product_detail',
      binding: ProductDetailBindings(),
      page: () => const ProductDetailPage(),
    ),
  ];
}
