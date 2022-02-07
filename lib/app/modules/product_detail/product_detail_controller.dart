import 'package:get/get.dart';
import 'package:vaquinha_burger_mobile/app/core/services/shooping_card_service.dart';
import 'package:vaquinha_burger_mobile/app/models/product_model.dart';

class ProductDetailController extends GetxController {
  final _product = Rx<ProductModel>(Get.arguments);
  final _totalPrice = 0.0.obs;
  final _quantity = 1.obs;
  final ShoopingCardService _shoopingCardService;
  final _alreadyAdded = false.obs;

  ProductDetailController({required ShoopingCardService shoopingCardService})
      : _shoopingCardService = shoopingCardService;

  ProductModel get product => _product.value;
  double get totalPrice => _totalPrice.value;
  int get quantity => _quantity.value;
  bool get alreadyAdded => _alreadyAdded.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _totalPrice(product.price);

    ever<int>(_quantity, (quantity) {
      _totalPrice(product.price * quantity);
    });

    final productShoopingCard = _shoopingCardService.getById(product.id);

    if (productShoopingCard != null) {
      _quantity(productShoopingCard.quantity);
      _alreadyAdded(true);
    }
  }

  void addProduct() {
    _quantity.value += 1;
  }

  void removeProduct() {
    if (_quantity > 1) {
      _quantity.value -= 1;
    }
  }

  void addProductInShoopingCard() {
    _shoopingCardService.addAndRemoveProductsInShoopingCard(product,
        quantity: quantity);
    Get.back();
  }
}
