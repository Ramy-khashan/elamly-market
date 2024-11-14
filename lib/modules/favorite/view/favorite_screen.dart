import 'package:elamlymarket/core/components/loading_item.dart';
import 'package:elamlymarket/modules/product_details/view/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/my_string.dart';
import 'widgets/favorite_item.dart';

import '../controller/favorite_cubit.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Favorite',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 23),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<FavoriteCubit, FavoriteState>(
          builder: (context, state) {
            final controller = FavoriteCubit.get(context);
            return controller.isLoadingFavoritie
                ? LoadingItem()
                : controller.favoriteProducts.isEmpty
                    ? Center(
                        child: Text("No favorite products exist",
                            style: TextStyle(
                                fontFamily: MyStrings.fontFamily,
                                fontSize: 27,
                                fontWeight: FontWeight.bold)),
                      )
                    : GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 2,
                        ),
                        itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetailsScreen(
                                              productId: controller
                                                  .favoriteProducts[index]
                                                  .productId,
                                            )));
                              },
                              borderRadius: BorderRadius.circular(15),
                              child: FavoriteItem(
                                  onDelete: () {
                                    controller.deleteItem(index: index);
                                  },
                                  product: controller.favoriteProducts[index]),
                            ),
                        itemCount: controller.favoriteProducts.length);
          },
        ),
      ),
    );
  }
}
