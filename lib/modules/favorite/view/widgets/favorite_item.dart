import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/camil_case.dart';
import '../../../../core/utils/my_colors.dart';
import '../../model/favorite_product_model.dart';

class FavoriteItem extends StatelessWidget {
  const FavoriteItem(
      {super.key, required this.product, required this.onDelete});
  final FavoriteProductModel product;
  final Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: GridTile(
        header: Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).cardColor,
              child: IconButton(
                icon: Icon(
                  CupertinoIcons.trash,
                  color: Colors.red.shade600,
                ),
                onPressed: onDelete,
              ),
            ),
          ),
        ),
        child: FancyShimmerImage(imageUrl: product.productImageUrl ?? ""),
        footer: GridTileBar(
          backgroundColor: MyColors.orangeColor.withOpacity(.43),
          title: Center(
            child: Text(camilCaseMethod(product.productName ?? ""),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22)),
          ),
        ),
      ),
    );
  }
}
