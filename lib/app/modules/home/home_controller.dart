import 'package:flutter/src/widgets/navigator.dart';
import 'package:get/get.dart';
import 'package:vaquinha_burger_mobile/app/core/services/auth_service.dart';
import 'package:vaquinha_burger_mobile/app/core/services/shooping_card_service.dart';
import 'package:vaquinha_burger_mobile/app/modules/menu/menu_bindings.dart';
import 'package:vaquinha_burger_mobile/app/modules/menu/menu_page.dart';

class HomeController extends GetxController {
  static const NAVIGASTOR_KEY = 1;
  final ShoopingCardService _shoopingCardService;

  final _tabs = ['/menu', '/order/shopping_card', '/exit'];

  HomeController({required ShoopingCardService shoopingCardService})
      : _shoopingCardService = shoopingCardService;

  final _tabIndex = 0.obs;
  int get tabIndex => _tabIndex.value;
  int get totalProductsInShoopingCard => _shoopingCardService.totalProducts;

  set tabIndex(int index) {
    _tabIndex(index);
    if (_tabs[index] == '/exit') {
      Get.find<AuthService>().logout();
    } else {
      Get.toNamed(_tabs[index], id: NAVIGASTOR_KEY);
    }
  }

  Route? onGeneratedRouter(RouteSettings settings) {
    if (settings.name == '/menu') {
      return GetPageRoute(
        settings: settings,
        page: () => const MenuPage(), //
        binding: MenuBindings(),
        transition: Transition.fadeIn,
      );
    }
    // no video estava shopping_card
    if (settings.name == '/order/shopping_card') {}
  }
}
