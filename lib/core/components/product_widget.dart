import 'dart:math';

import 'package:elamlymarket/core/components/need_login_model_sheet.dart';
import 'package:elamlymarket/core/utils/service_locator.dart';
import 'package:elamlymarket/core/utils/storage_key.dart';
import 'package:elamlymarket/modules/home/controller/home_cubit.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../modules/home/model/product.dart';
import '../../modules/product_details/view/product_details_screen.dart';

import '../utils/my_colors.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel product;
  final bool isWithSpace;

  const ProductWidget(
      {super.key, required this.product, this.isWithSpace = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsScreen(product: product),
              ),
            );
          },
          child: Center(
            child: Container(
              margin: EdgeInsetsDirectional.only(end: isWithSpace ? 12 : 0),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              width: 155.w,
              decoration: BoxDecoration(
                border: Border.all(
                    color: MyColors.greyColor.withOpacity(.4), width: 1),
                borderRadius: BorderRadius.circular(19),
                color: Theme.of(context).cardColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: FancyShimmerImage(
                      imageUrl: product.images!.first,
                      boxFit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          product.title ?? "",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color:
                                Theme.of(context).textTheme.titleMedium!.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        // Text(
                        //   product.subTitle,
                        //   style: TextStyle(
                        //     color: MyColors.grey2Color,
                        //     fontSize: 11.sp,
                        //     fontWeight: FontWeight.w400,
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 10.h,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (product.isOnSale!)
                                  Text(
                                    "${product.onSalePrice} LE",
                                    style: TextStyle(
                                      color: MyColors.darkRedColor,
                                      decorationThickness: 2,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                SizedBox(
                                  height: 5.w,
                                ),
                                Text(
                                  '${product.price} LE',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .color,
                                    decoration: product.isOnSale!
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                    decorationColor: MyColors.darkRedColor,
                                    decorationThickness: 2,
                                    fontSize: product.isOnSale! ? 12.sp : 13.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            FloatingActionButton(
                              heroTag: Random().nextInt(10000),
                              onPressed: () async {
                                String? userID =
                                    await const FlutterSecureStorage()
                                        .read(key: StorageKey.userDocId);
                                if (userID == null) {
                                  needLogin(context: context);
                                } else {
                                  sl.get<HomeCubit>().addToCart(product, 1);
                                }
                              },
                              child: Icon(
                                Icons.shopping_cart_outlined,
                                color: MyColors.whiteColor,
                              ),
                              isExtended: false,
                              mini: true,
                              backgroundColor: MyColors.greenColor,
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        PositionedDirectional(
            end: 20,
            child: IconButton(
                onPressed: () async {
                  String? userID = await const FlutterSecureStorage()
                      .read(key: StorageKey.userDocId);
                  if (userID == null) {
                    needLogin(context: context);
                  } else {
                    sl.get<HomeCubit>().addToFavorite(product);
                  }
                },
                icon: Icon(
                  Icons.favorite_border_rounded,
                  size: 35,
                  color: MyColors.orangeColor,
                )))
      ],
    );
  }
}
