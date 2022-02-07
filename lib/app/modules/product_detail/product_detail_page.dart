import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:vaquinha_burger_mobile/app/core/ui/formatter_helper.dart';
import 'package:vaquinha_burger_mobile/app/core/ui/vakinha_ui.dart';
import 'package:vaquinha_burger_mobile/app/core/ui/widgets/plus_minus_box.dart';
import 'package:vaquinha_burger_mobile/app/core/ui/widgets/vakinha_appbar.dart';
import 'package:vaquinha_burger_mobile/app/core/ui/widgets/vakinha_button.dart';
import 'package:vaquinha_burger_mobile/main.dart';
import './product_detail_controller.dart';

class ProductDetailPage extends GetView<ProductDetailController> {
  const ProductDetailPage({Key? key}) : super(key: key);

  final String _img = 'http://dartWeek.academiadoflutter.com.br/images';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VakinhaAppBar(),
      body: LayoutBuilder(
        builder: (_, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: Column(
                // ajuste adicional
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: context.width,
                    height: context.heightTransformer(reducedBy: 60),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(_img + controller.product.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  //
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      controller.product.name,
                      style: context.textTheme.headline4!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      controller.product.description,
                      style: context.textTheme.bodyText2!.copyWith(
                        color: Colors.black,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Criar novo componente
                  Obx(() {
                    return PlusMinusBox(
                      plusCallback: controller.addProduct,
                      minusCallback: controller.removeProduct,
                      price: controller.product.price,
                      quantity: controller.quantity,
                      // backgroundColor: Colors.red,
                    );
                  }),
                  const Divider(),
                  ListTile(
                    title: Text(
                      'Total',
                      style: VakinhaUI.textBold,
                    ),
                    trailing: Obx(() {
                      return Text(
                        FormatterHelper.formatCurrency(controller.totalPrice),
                        style: VakinhaUI.textBold,
                      );
                    }),
                  ),
                  //
                  const SizedBox(
                    height: 20,
                  ),
                  //
                  Center(
                    child: SizedBox(
                      width: context.widthTransformer(reducedBy: 10),
                      child: VakinhaButton(
                        label:
                            controller.alreadyAdded ? 'ATUALIZAR' : 'ADICIONAR',
                        onPressed: controller.addProductInShoopingCard,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
