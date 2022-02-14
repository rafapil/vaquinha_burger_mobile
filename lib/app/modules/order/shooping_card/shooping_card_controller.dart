import 'package:get/get.dart';
import 'package:vaquinha_burger_mobile/app/core/services/auth_service.dart';
import 'package:vaquinha_burger_mobile/app/core/services/shooping_card_service.dart';
import 'package:vaquinha_burger_mobile/app/models/order.dart';
import 'package:vaquinha_burger_mobile/app/models/shooping_card_model.dart';
import 'package:vaquinha_burger_mobile/app/modules/home/home_controller.dart';
import 'package:vaquinha_burger_mobile/app/repositories/order/order_repository.dart';

class ShoopingCardController extends GetxController {
  final AuthService _authService;
  final ShoopingCardService _shoopingCardService;
  final OrderRepository _orderRepository;

  final _address = ''.obs;
  final _cpf = ''.obs;

  ShoopingCardController({
    required AuthService authService,
    required ShoopingCardService shoopingCardService,
    required OrderRepository orderRepository,
  })  : _authService = authService,
        _shoopingCardService = shoopingCardService,
        _orderRepository = orderRepository;

  List<ShoopingCardModel> get products => _shoopingCardService.products;

  double get totalValue => _shoopingCardService.totalValue;

  set address(String address) => _address.value = address;
  set cpf(String cpf) => _cpf.value = cpf;

  void addQuantityInProduct(ShoopingCardModel shoopingCardModel) {
    _shoopingCardService.addAndRemoveProductsInShoopingCard(
        shoopingCardModel.product,
        quantity: shoopingCardModel.quantity + 1);
  }

  void subtractQuantityInProduct(ShoopingCardModel shoopingCardModel) {
    _shoopingCardService.addAndRemoveProductsInShoopingCard(
        shoopingCardModel.product,
        quantity: shoopingCardModel.quantity - 1);
  }

  void clear() => _shoopingCardService.clear();

  Future<void> createOrder() async {
    final userId = _authService.getUserId();
    final order = Order(
        userId: userId!,
        cpf: _cpf.value,
        address: _address.value,
        items: products);

    final orderPix = await _orderRepository.createOrder(order);
    orderPix.copyWith(totalValue: totalValue);
    clear();
    Get.offNamed('/order/finished', arguments: orderPix);
    Get.back(id: HomeController.NAVIGASTOR_KEY);
  }
}
