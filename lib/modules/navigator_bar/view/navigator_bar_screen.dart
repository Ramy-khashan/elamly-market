import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/my_colors.dart';

import '../controller/navigator_bar_cubit.dart';

class NavigatorBarScreen extends StatelessWidget {
  const NavigatorBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigatorBarCubit()..getUserData(),
      child: BlocBuilder<NavigatorBarCubit, NavigatorBarState>(
        builder: (context, state) {
          final controller = NavigatorBarCubit.get(context);
          return Scaffold(
            body: controller.navigatorItem[controller.selectedTab].page,
            bottomNavigationBar: BottomNavigationBar(
                showUnselectedLabels: true,
                selectedItemColor: MyColors.orangeColor,
                unselectedItemColor: MyColors.greyColor,
                currentIndex: controller.selectedTab,
                onTap: controller.selectTab,
                items: List.generate(
                    controller.navigatorItem.length,
                    (index) => index != 2
                        ? BottomNavigationBarItem(
                            icon: Icon(controller.navigatorItem[index].icon),
                            label: controller.navigatorItem[index].title)
                        : BottomNavigationBarItem(
                            icon: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("cart")
                                    .doc(controller.userDocId)
                                    .collection("cart_products")
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return snapshot.data!.docs.length==0?  Icon(
                                          controller.navigatorItem[index].icon 
                                    ):Badge.count(
                                      count: snapshot.data!.docs.length,
                                      child: Icon(
                                          controller.navigatorItem[index].icon),
                                    );
                                  }
                                  return Icon(
                                      controller.navigatorItem[index].icon);
                                }),
                            label: controller.navigatorItem[index].title))),
          );
        },
      ),
    );
  }
}
