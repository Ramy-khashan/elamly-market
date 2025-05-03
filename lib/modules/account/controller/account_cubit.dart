import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elamlymarket/core/utils/storage_key.dart';
import 'package:elamlymarket/market.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../about/view/about_screen.dart';
import '../../help/view/help_screen.dart';
import '../../login/view/login_screen.dart';
import '../../navigator_bar/model/navigator_bar_model.dart';
import '../../notifications/view/notification_screen.dart';
import '../../delivery_address/view/delivery_address_screen.dart';
import '../../orders/view/orders_screen.dart';
import '../../reports/view/reports_screen.dart';
import '../view/widgets/show_delete_dialog.dart';
part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountInitial());
  static AccountCubit get(context) => BlocProvider.of(context);
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
  final GlobalKey<FormState>formKeyLogin=GlobalKey<FormState>();
  List<NavigatorBarModel> accountItems = [
    NavigatorBarModel(
      icon: CupertinoIcons.app_badge_fill,
      title: 'Orders',
      page: OrdersScreen(),
    ),
    NavigatorBarModel(
      icon: Icons.location_on,
      title: 'Delivery Address',
      page: DeliveryAddressScreen(),
    ),
    NavigatorBarModel(
      icon: Icons.notifications,
      title: 'Notifications',
      page: NotificationScreen(),
    ),
    NavigatorBarModel(
      icon: Icons.help,
      title: 'Help',
      page: HelpScreen(),
    ),
    NavigatorBarModel(
      icon: Icons.info_outline,
      title: 'About',
      page: AboutScreen(),
    ),
    NavigatorBarModel(
      icon: Icons.info_outline,
      title: 'Reports',
      page: ReportsScreen(),
    ),
  ];
    bool hideDeleteAccount = true;
  getShowHideDeleteAccount() async {
    await FirebaseFirestore.instance
        .collection("configration")
        .doc("hideDeleteAccount")
        .get()
        .then((value) => hideDeleteAccount = value.get("hide"));
    emit(GetDeleteAccountState());
  }
 bool isLoadingDelete = false;
  deleteAccount(context) async {
    try {
      isLoadingDelete = true;
      emit(LoadingDeleteState());

      await showDeleteDialog(context,);
      print("User account deleted successfully.");

      isLoadingDelete = false;
      emit(DeletedState());
    } on FirebaseAuthException catch (e) {
      print(e.message);
      isLoadingDelete = false;
      emit(FailedDeleteState());
    }
  }
  String? name;
  String? image;
  String? email;
  getUserData() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    name = await storage.read(key: StorageKey.name);
    email = await storage.read(key: StorageKey.email);
    image = await storage.read(key: StorageKey.image);
    emit(GetUserDataState());
  }

  logOut() async {
    await FlutterSecureStorage().delete(key: StorageKey.email);
    await FlutterSecureStorage().delete(key: StorageKey.name);
    await FlutterSecureStorage().delete(key: StorageKey.phone);
    await FlutterSecureStorage().delete(key: StorageKey.UserAuthId);
    await FlutterSecureStorage().delete(key: StorageKey.userDocId);
    await FlutterSecureStorage().delete(key: StorageKey.token);
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
        Market.navigatorKet.currentContext!,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false);
  }
  
}
