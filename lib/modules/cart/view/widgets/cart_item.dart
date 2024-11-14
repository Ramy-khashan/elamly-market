import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/my_colors.dart';
import '../../../../core/utils/my_string.dart';
import '../../controller/cart_cubit.dart';
import '../../model/cart_model.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.cartItem, required this.index});
  final CartModel cartItem;
  final int index;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: SizedBox(
        height: 160,
        child: Card(
          margin: EdgeInsets.all(8),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 3,
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child:
                      FancyShimmerImage(imageUrl: cartItem.productImage ?? "")),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(cartItem.productName ?? "",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: MyStrings.fontFamily,
                                    fontWeight: FontWeight.bold)),
                          ),
                          BlocBuilder<CartCubit, CartState>(
                            builder: (context, state) {
                              final controller = CartCubit.get(context);
                              return IconButton(
                                  onPressed: () {
                                    controller.deleteItem(index: index);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ));
                            },
                          )
                        ],
                      ),
                      BlocBuilder<CartCubit, CartState>(
                        builder: (context, state) {
                          final controller = CartCubit.get(context);
                          return Row(
                            children: [
                              FloatingActionButton(
                                backgroundColor: Colors.white,
                                mini: true,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                        color: MyColors.greyColor, width: 1)),
                                heroTag: "${cartItem.id}+minus" ,
                                onPressed: () {
                                  controller.decrement(index);
                                },
                                child: Icon(
                                  Icons.remove,
                                  color: MyColors.greyColor,
                                  size: 22,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(cartItem.quantity.toString(),
                                    style: TextStyle(
                                        fontFamily: MyStrings.fontFamily,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                              ),
                              FloatingActionButton(
                                  backgroundColor: Colors.white,
                                  mini: true,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                          color: MyColors.greenColor,
                                          width: 1)),
                                  heroTag: "${cartItem.id}+add",
                                  onPressed: () {
                                    controller.increment(index);
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: MyColors.greenColor,
                                    size: 22,
                                  )),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                    '${controller.getTotalForProduct(index)} L.E',
                                    style: TextStyle(
                                        fontFamily: MyStrings.fontFamily,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          );
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
