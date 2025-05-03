import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/components/search_bar.dart';
import '../../../generated/l10n.dart';
import '../../search/view/search_screen.dart';
import '../controller/explore_cubit.dart';
import 'widgets/category_item.dart';

import '../../../core/utils/service_locator.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).findProduct,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(50.h),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child:  SearchBarWidget(
                    readOnly: true,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder:(context)=>SearchScreen()));
                    },
                  ),
            )),
      ),
      body: BlocBuilder<ExploreCubit, ExploreState>(
        builder: (context, state) {
          final controller = sl<ExploreCubit>();
          return RefreshIndicator(
            onRefresh: () async {
              await controller.getCategories();
            },
            child: controller.categoriesItems.isEmpty
                ? Center(
                    child: Text(
                      "No Categories Exists",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic),
                    ),
                  )
                : GridView.builder(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.all(8),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        mainAxisExtent:
                            MediaQuery.of(context).size.height * .25),
                    itemBuilder: (context, index) {
                      Color color =
                          Color((Random().nextDouble() * 0xFFFFFF).toInt())
                              .withOpacity(1.0);
                      return CategoryItem(
                        category: controller.categoriesItems[index],
                        color: color,
                      );
                    },
                    itemCount: controller.categoriesItems.length,
                  ),
          );
        },
      ),
    );
  }
}
