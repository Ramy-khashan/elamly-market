import 'package:elamlymarket/core/components/need_login_model_sheet.dart';
import 'package:elamlymarket/core/utils/storage_key.dart';
import 'package:elamlymarket/market.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../home/view/home_screen.dart';

import '../../account/view/account_screen.dart';
import '../../cart/view/cart_screen.dart';
import '../../explore/view/explore_screen.dart';
import '../../favorite/view/favorite_screen.dart';
import '../model/navigator_bar_model.dart';

part 'navigator_bar_state.dart';

class NavigatorBarCubit extends Cubit<NavigatorBarState> {
  NavigatorBarCubit() : super(NavigatorBarInitial()) {}
  static NavigatorBarCubit get(context) => BlocProvider.of(context);
  List<NavigatorBarModel> navigatorItem = [
    NavigatorBarModel(page: HomeScreen(), title: "Shop", icon: Icons.shop),
    NavigatorBarModel(
        page: ExploreScreen(), title: "Explore", icon: Icons.search),
    NavigatorBarModel(
        page: CartScreen(), title: "Cart", icon: Icons.shopping_cart),
    NavigatorBarModel(
        page: FavoriteScreen(), title: "Favorite", icon: Icons.favorite_border),
    NavigatorBarModel(
        page: AccountScreen(), title: "Account", icon: CupertinoIcons.person),
  ];
  int selectedTab = 0;
  selectTab(int? index) async {
    String? userId =
        await const FlutterSecureStorage().read(key: StorageKey.userDocId);

    emit(NavigatorBarInitial());
    print(userId);
    if (userId == null) {
      if (index == 0 || index == 1) {
        selectedTab = index!;
      } else {
        needLogin(context: Market.navigatorKet.currentContext!);
      }
    } else {
      selectedTab = index!;
    }
    emit(NavigatorBarTabSelectedState());
  }

  String? userDocId;
  getUserData() async {
    emit(NavigatorBarInitial());

    userDocId =
        await const FlutterSecureStorage().read(key: StorageKey.userDocId);

    emit(GetUserDataState());
  }
}
