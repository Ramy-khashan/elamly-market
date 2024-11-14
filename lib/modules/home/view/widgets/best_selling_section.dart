import 'package:elamlymarket/core/components/loading_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/components/product_widget.dart';
import '../../../../core/utils/service_locator.dart';
import '../../controller/home_cubit.dart';

class BestSellingSection extends StatelessWidget {
  const BestSellingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final controller = sl<HomeCubit>();
        return SizedBox(
            height: 230.h,
            child: Center(
              child: controller.isLoadingProductMostSelling
                  ? LoadingItem()
                  : controller.bestSellingProducts.isEmpty
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
                            product: controller.bestSellingProducts[index],
                          ),
                          itemCount: controller.bestSellingProducts.length,
                        ),
            ));
      },
    );
  }
}
