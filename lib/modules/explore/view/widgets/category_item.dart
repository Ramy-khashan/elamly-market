import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../category/view/category_screen.dart';
import '../../../home/model/category.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel category;
  final Color color;
  const CategoryItem({super.key, required this.category, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryScreen(category: category),
          ),
        );
      },
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        width: 150.w,
        height: 160.h,
        decoration: BoxDecoration(
            color: color.withOpacity(.3),
            border: Border.all(width: 1, color: color.withOpacity(.8)),
            borderRadius: BorderRadius.circular(19)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FancyShimmerImage(
                imageUrl: category.image!,
                boxFit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Text(
                category.title ?? "",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
