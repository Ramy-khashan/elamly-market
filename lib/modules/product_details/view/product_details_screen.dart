import 'package:card_swiper/card_swiper.dart';
import 'package:elamlymarket/core/components/loading_item.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../core/components/need_login_model_sheet.dart';
import '../../../core/utils/service_locator.dart';
import '../../../core/utils/storage_key.dart';
import '../../home/controller/home_cubit.dart';
import '../../home/model/product.dart';
import '../controller/product_details_cubit.dart';

import '../../../core/utils/my_colors.dart';
import '../../../generated/l10n.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel? product;
  final String? productId;
  const ProductDetailsScreen({super.key, this.product, this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductDetailsCubit(productModel: product, productId: productId),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(4),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              borderRadius: BorderRadius.circular(35),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.arrow_back,
                  size: 26,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            final controller = ProductDetailsCubit.get(context);
            return controller.isLoading
                ? LoadingItem()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                  color: MyColors.grey2Color.withOpacity(.2),
                                  width: MediaQuery.of(context).size.width,
                                  height: 320.h,
                                  child: Swiper(
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return FancyShimmerImage(
                                        imageUrl: controller
                                            .productDetails!.images![index],
                                        boxFit: BoxFit.fill,
                                      );
                                    },
                                    autoplay: controller.productDetails!.images!
                                                .length ==
                                            1
                                        ? false
                                        : true,
                                    itemCount: controller
                                        .productDetails!.images!.length,
                                    pagination: SwiperPagination(
                                        alignment: Alignment.bottomCenter,
                                        builder: DotSwiperPaginationBuilder(
                                          color: Colors.white,
                                          activeColor:
                                              Theme.of(context).primaryColor,
                                        )),
                                  )),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(
                                        controller.productDetails!.title ?? "",
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      trailing: IconButton(
                                          onPressed: () async {
                                            String? userID =
                                                await const FlutterSecureStorage()
                                                    .read(
                                                        key: StorageKey
                                                            .userDocId);
                                            if (userID == null) {
                                              needLogin(context: context);
                                            } else {
                                              sl.get<HomeCubit>().addToFavorite(
                                                    controller.productDetails!,
                                                  );
                                            }
                                          },
                                          icon: Icon(
                                            Icons.favorite_outline,
                                            color: MyColors.grey2Color,
                                          )),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    controller.decrement();
                                                  },
                                                  icon: Icon(
                                                    Icons.remove,
                                                  )),
                                              Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: MyColors
                                                            .grey2Color
                                                            .withOpacity(.2),
                                                        width: .5)),
                                                child: Text(
                                                  controller.quantity
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    controller.increment();
                                                  },
                                                  icon: Icon(
                                                    Icons.add,
                                                    color: MyColors.greenColor,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        if (controller
                                            .productDetails!.isOnSale!)
                                          Text(
                                            "${controller.productDetails!.onSalePrice} LE",
                                            style: TextStyle(
                                              color: MyColors.darkRedColor,
                                              decorationThickness: 2,
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Text(
                                          '${controller.productDetails!.price} LE',
                                          style: TextStyle(
                                            color: controller
                                                    .productDetails!.isOnSale!
                                                ? MyColors.grey2Color
                                                : Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .color,
                                            decoration: controller
                                                    .productDetails!.isOnSale!
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none,
                                            decorationColor:
                                                MyColors.darkRedColor,
                                            decorationThickness: 2,
                                            fontSize: controller
                                                    .productDetails!.isOnSale!
                                                ? 12.sp
                                                : 13.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                S.of(context).productDetails,
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              GestureDetector(
                                                  onTap: controller
                                                      .toggleDescription,
                                                  child: Icon(controller
                                                          .visibleDescription
                                                      ? Icons.arrow_drop_up
                                                      : Icons.arrow_drop_down)),
                                            ],
                                          ),
                                          AnimatedContainer(
                                            duration:
                                                Duration(milliseconds: 500),
                                            height:
                                                controller.visibleDescription
                                                    ? 150
                                                    : 0,
                                            child: SingleChildScrollView(
                                              physics: BouncingScrollPhysics(),
                                              child: Text(
                                                controller.productDetails!
                                                        .description ??
                                                    "",
                                                style: TextStyle(
                                                    color: MyColors.grey2Color,
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 50.h,
                        child: ElevatedButton(
                            onPressed: () async {
                              String? userID =
                                  await const FlutterSecureStorage()
                                      .read(key: StorageKey.userDocId);
                              if (userID == null) {
                                needLogin(context: context);
                              } else {
                                sl.get<HomeCubit>().addToCart(
                                    controller.productDetails!,
                                    controller.quantity);
                              }
                            },
                            child: Text(S.of(context).addToBasket)),
                      )
                    ],
                  );
          },
        ),
      ),
    );
  }
}
