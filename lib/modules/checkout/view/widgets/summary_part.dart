import 'package:elamlymarket/core/utils/my_colors.dart';
import 'package:elamlymarket/core/utils/my_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/checkout_cubit.dart';
import '../../model/summary_product_model.dart';

class SummaryPart extends StatelessWidget {
  const SummaryPart({super.key, required this.product});
  final List<SummaryProductModel> product;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (context, state) {
        final controller = CheckoutCubit.get(context);
        return Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: MyColors.orangeColor),
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  children: [
                    Text(
                      'Order Summary',
                      style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          fontFamily: MyStrings.fontFamily),
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          controller.toggleSummary();
                        },
                        icon: Icon(controller.isToggledSummary
                            ? Icons.arrow_drop_up_rounded
                            : Icons.arrow_drop_down_rounded,color: MyColors.orangeColor,))
                  ],
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
              
                height: controller.isToggledSummary
                    ? 0
                    : (product.length + 2) * 50 + 10,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: List.generate(
                            product.length,
                            (index) => ListTile(
                                  dense: true,
                                  leading: Text("x${product[index].quantity}"),
                                  title: Text(product[index].title),
                                  trailing: Text("${product[index].price} L.E"),
                                )),
                      ),
                      ListTile(
                        dense: true,
                        title: Text('Delivery Fees'),
                        trailing: Text("${controller.deliveryAddressFees} L.E"),
                      ),
                      Divider(color: MyColors.orangeColor),
                      ListTile(
                        dense: true,
                        title: Text('Total Price'),
                        trailing: Text(
                            "${controller.getTotalPrice(product).toString()} L.E"),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
