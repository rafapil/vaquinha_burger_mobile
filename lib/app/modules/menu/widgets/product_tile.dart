import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:vaquinha_burger_mobile/app/core/ui/formatter_helper.dart';
import 'package:vaquinha_burger_mobile/app/core/ui/vakinha_ui.dart';
import 'package:vaquinha_burger_mobile/app/models/product_model.dart';

class ProductTile extends StatelessWidget {
  final ProductModel product;

  const ProductTile({Key? key, required this.product}) : super(key: key);

  // const ProductTile({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _img =
        'http://dartweek.academiadoflutter.com.br/images${product.image}';

    return InkWell(
        onTap: () {
          Get.toNamed('/product_detail', arguments: product);
        },
        child: Container(
            margin: const EdgeInsets.all(10),
            height: 80,
            child: Row(
              children: [
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(_img),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(product.name, style: VakinhaUI.textBold),
                          Text(
                            FormatterHelper.formatCurrency(product.price),
                          ),
                        ],
                      )),
                ),
              ],
            )));
  }
}
