import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:vaquinha_burger_mobile/app/core/services/auth_service.dart';
import 'package:vaquinha_burger_mobile/app/core/ui/widgets/icon_badge.dart';
import 'package:vaquinha_burger_mobile/app/core/ui/widgets/vakinha_appbar.dart';
import './home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VakinhaAppBar(),
      bottomNavigationBar: Obx(
        () {
          return BottomNavigationBar(
            onTap: (value) => controller.tabIndex = value,
            currentIndex: controller.tabIndex,
            items: [
              const BottomNavigationBarItem(
                  icon: Icon(Icons.list), label: 'Produtos'),
              BottomNavigationBarItem(
                icon: IconBadge(
                  icon: Icons.shopping_cart,
                  number: controller.totalProductsInShoopingCard,
                ),
                label: 'Carrinho',
              ),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.exit_to_app), label: 'Sair'),
            ],
          );
        },
      ),
      body: Navigator(
        initialRoute: '/menu',
        key: Get.nestedKey(HomeController.NAVIGASTOR_KEY),
        onGenerateRoute: controller.onGeneratedRouter,
      ),
    );
  }
}
