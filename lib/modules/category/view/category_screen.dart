import 'package:elamlymarket/core/components/loading_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/components/product_widget.dart';
import '../../home/model/category.dart';
import '../controller/category_cubit.dart';

class CategoryScreen extends StatelessWidget {
  final CategoryModel category;
  const CategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CategoryCubit()..getCategoryProducts(categoryId: category.id ?? ""),
      child: Scaffold(
        appBar: AppBar(
          // actions: [
          //   IconButton(
          //     onPressed: () {},
          //     icon: Image.asset(
          //       MyImages.filterIcon,
          //     ),
          //   )
          // ],
          title: Text(
            category.title ?? "",
            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            final controller = CategoryCubit.get(context);
            return controller.isLoadingProduct
                ? LoadingItem()
                : GridView.builder(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 0,
                        mainAxisExtent:
                            MediaQuery.of(context).size.height * .33),
                    itemBuilder: (context, index) => ProductWidget(
                        product: controller.categoryProducts[index],
                        isWithSpace: false),
                    itemCount: controller.categoryProducts.length,
                  );
          },
        ),
      ),
    );
  }
}
