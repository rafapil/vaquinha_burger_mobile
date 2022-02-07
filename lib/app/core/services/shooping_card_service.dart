import 'package:get/get.dart';
import 'package:vaquinha_burger_mobile/app/models/product_model.dart';

// import 'package:vaquinha_burger_mobile/app/models/product_model.dart';
import 'package:vaquinha_burger_mobile/app/models/shooping_card_model.dart';

class ShoopingCardService extends GetxService {
  final _shoopingCard = <int, ShoopingCardModel>{}.obs;

  List<ShoopingCardModel> get products => _shoopingCard.values.toList();

  int get totalProducts => _shoopingCard.values.length;

  ShoopingCardModel? getById(int id) => _shoopingCard[id];

  //
  void addAndRemoveProductsInShoopingCard(
    ProductModel product, {
    required int quantity,
  }) {
    if (quantity == 0) {
      _shoopingCard.remove(product.id);
    } else {
      _shoopingCard.update(product.id, (product) {
        product.quantity = quantity;
        return product;
      }, ifAbsent: () {
        return ShoopingCardModel(quantity: quantity, product: product);
      });
    }
  }
}
