import 'package:elamlymarket/core/components/loading_item.dart';
import 'package:elamlymarket/modules/checkout/model/summary_product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/my_string.dart';
import '../../checkout/view/checkout_screen.dart';
import 'widgets/cart_item.dart';

import '../controller/cart_cubit.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Cart',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 23),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            final controller = CartCubit.get(context);
            return controller.isLoadingCart
                ? LoadingItem()
                : controller.cartItem.isEmpty
                    ? Center(
                        child: Text("No cart products exist",
                            style: TextStyle(
                                fontFamily: MyStrings.fontFamily,
                                fontSize: 27,
                                fontWeight: FontWeight.bold)),
                      )
                    : Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                itemBuilder: (context, index) => CartItem(
                                    index: index,
                                    cartItem: controller.cartItem[
                                        index]), // FavoriteItem(product: controller.favoriteProducts[index]),

                                itemCount: controller.cartItem.length),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 5),
                            child: ElevatedButton(
                              
                                style: ElevatedButton.styleFrom(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 20)),
                                onPressed: () {
                                  List<SummaryProductModel> summaryProducts =
                                      [];
                                  controller.cartItem.forEach((element) {
                                    summaryProducts.add(
                                      SummaryProductModel(
                                        isOnSale: element.productIsOnSale!,
                                        priceBefore: element.productPrice ?? "",
                                        productId: element.productId ?? "",
                                        title: element.productName ?? "",
                                        price: controller.getTotalForProduct(
                                            controller.cartItem
                                                .indexOf(element)),
                                        quantity: element.quantity.toString(),
                                      ),
                                    );
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CheckoutScreen(
                                                product: summaryProducts,
                                              )));
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 4,
                                        child: Center(
                                          child: Text(
                                            "Go to Checkout",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18),
                                          ),
                                        )),
                                    Container(
                                        padding: EdgeInsets.all(5),
                                        margin: EdgeInsetsDirectional.only(
                                          end: 20,
                                        ),
                                        color: const Color(0xff489E67),
                                        child: Text(
                                          "${controller.totalPrice.toString()} L.E",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ))
                                  ],
                                )),
                          )
                        ],
                      );
          },
        ),
      ),
    );
  }
}
