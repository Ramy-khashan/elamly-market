import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/components/loading_item.dart';
import '../../controller/home_cubit.dart';

import '../../../../core/components/product_widget.dart';
import '../../../../core/utils/service_locator.dart';

class OfferSection extends StatelessWidget {
  const OfferSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final controller = sl<HomeCubit>();
        return  SizedBox(
                    height: 230.h,
                    child: Center(
                      child: controller.isLoadingonSaleProduct
                                ? LoadingItem()
                                : controller.offers.isEmpty
                                    ? Text(
                      "No Products Exists",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic),
                                      )
                                    : ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => ProductWidget(
                                isWithSpace: true,
                                product: controller.offers[index],
                              ),
                              itemCount: controller.offers.length,
                            ),
                    ));
      },
    );
  }
}
