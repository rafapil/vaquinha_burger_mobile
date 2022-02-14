import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';
import 'package:vaquinha_burger_mobile/app/core/ui/formatter_helper.dart';
import 'package:vaquinha_burger_mobile/app/core/ui/widgets/plus_minus_box.dart';
import 'package:vaquinha_burger_mobile/app/core/ui/widgets/vakinha_button.dart';
import './shooping_card_controller.dart';

class ShoopingCardPage extends GetView<ShoopingCardController> {
  final formKey = GlobalKey<FormState>();

  ShoopingCardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (_, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: IntrinsicHeight(
                child: Form(
                  key: formKey,
                  child: Visibility(
                    visible: controller.products.isNotEmpty,
                    replacement: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Carrinho',
                            style: context.textTheme.headline6?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: context.theme.primaryColorDark,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('Nenhum item adicionado no carrinho'),
                        ],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Carrinho',
                              style: context.textTheme.headline6?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: context.theme.primaryColorDark,
                              ),
                            ),
                            //
                            IconButton(
                              onPressed: () {
                                controller.clear;
                              },
                              icon: Icon(
                                Icons.delete_outline_outlined,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        //
                        Obx(() {
                          return Column(
                            children: controller.products
                                .map((p) => Container(
                                      margin: EdgeInsets.all(10),
                                      child: PlusMinusBox(
                                        elevated: true,
                                        backgroundColor: Colors.white,
                                        label: p.product.name,
                                        calculateTotal: true,
                                        quantity: p.quantity,
                                        price: p.product.price,
                                        plusCallback: () {
                                          controller.addQuantityInProduct(p);
                                        },
                                        minusCallback: () {
                                          controller
                                              .subtractQuantityInProduct(p);
                                        },
                                      ),
                                    ))
                                .toList(),
                          );
                        }),
                        // TODO continuar deste ponto 29:16
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total do pedido',
                              style: context.textTheme.bodyText1?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Obx(() {
                              return Text(
                                FormatterHelper.formatCurrency(
                                    controller.totalValue),
                                style: context.textTheme.bodyText1?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }),
                          ],
                        ),
                        Divider(),
                        _AddressField(),
                        Divider(),
                        _CpfField(),
                        Divider(),
                        Spacer(),
                        Center(
                          child: SizedBox(
                            width: context.widthTransformer(reducedBy: 10),
                            child: VakinhaButton(
                              label: 'FINALIZAR',
                              onPressed: () {
                                // Get.toNamed('/orders/finished');
                                final formValid =
                                    formKey.currentState?.validate() ?? false;
                                if (formValid) {
                                  controller.createOrder();
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// componentes privado
class _AddressField extends GetView<ShoopingCardController> {
  const _AddressField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 35,
            child: Expanded(
              child: Text(
                'Endereço de entrega',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (value) {
              controller.address = value;
            },
            validator: Validatorless.required('Endereço obrigatório'),
            decoration: InputDecoration(
              hintText: 'Digite o endereço',
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class _CpfField extends GetView<ShoopingCardController> {
  const _CpfField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 35,
            child: Expanded(
              child: Text(
                'CPF',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (value) {
              controller.cpf = value;
            },
            validator: Validatorless.multiple([
              Validatorless.required('CPF obrigatório'),
              Validatorless.cpf('CPF Invalido'),
            ]),
            decoration: InputDecoration(
              hintText: 'Digite o CPF',
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
