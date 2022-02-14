import 'dart:developer';

import 'package:vaquinha_burger_mobile/app/core/rest_client/rest_client.dart';
import 'package:vaquinha_burger_mobile/app/models/order.dart';
import 'package:vaquinha_burger_mobile/app/models/order_pix.dart';

import './order_repository.dart';

class OrderRepositoryImpl extends OrderRepository {
  final RestClient _restClient;

  OrderRepositoryImpl({required RestClient restClient})
      : _restClient = restClient;

  @override
  Future<OrderPix> createOrder(Order order) async {
    final result = await _restClient.post('/order/', {
      'userId': order.userId,
      'cpf': order.cpf,
      'address': order.address,
      'items': order.items
          .map((shoopingCard) => {
                'quantity': shoopingCard.quantity,
                'productId': shoopingCard.product.id,
              })
          .toList()
    });

    if (result.hasError) {
      log(
        'Erro ao realizar pedido ${result.statusCode}',
        error: result.statusText,
        stackTrace: StackTrace.current,
      );
      throw RestClientException('Erro ao realizar pedido');
    }

    return OrderPix.fromMap(result.body);
  }
}
