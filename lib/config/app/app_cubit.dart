import 'dart:async';

import 'package:elamlymarket/core/utils/storage_key.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/utils/my_string.dart';
import '../../core/utils/shared_prefrance_utils.dart';
import '../../market.dart';
import '../../modules/login/view/login_screen.dart';
import '../../modules/navigator_bar/view/navigator_bar_screen.dart';
import '../../modules/on_boarding/view/on_boarding_screen.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of(context);
  String? onBoarding;
  String? email;
  String? isActive;
  getInitial() async {
    emit(AppInitial());

    FlutterSecureStorage storage = const FlutterSecureStorage();
    onBoarding = await storage.read(
      key: MyStrings.onBoarding,
    );
    isActive = await storage.read(
      key: StorageKey.isActive,
    );
    email = await storage.read(
      key: StorageKey.email,
    );

    emit(GetSavedDataState());
  }

  initNotification() async {
    // String? token = await FirebaseMessaging.instance.getToken();
    // print(token);
    // NotificationService().initNotification();

    // FirebaseMessaging.onMessage.listen((event) async {
    //   String? title = event.notification?.title;
    //   String? body = event.notification?.body;

    //   await NotificationService().showNotification(
    //       Random().nextInt(10000) * Random().nextInt(10000),
    //       title ?? "",
    //       body ?? "");
    // });

    // FirebaseMessaging.onMessageOpenedApp.listen((event) {});
  }

  bool? isDarkTheme;
  getSavedThemeMode() {
    emit(StartFetchSavedThemeState());
    isDarkTheme = PreferenceUtils.getString(MyStrings.themeMode) == "true"
        ? true
        : PreferenceUtils.getString(MyStrings.themeMode) == "false"
            ? false
            : (ThemeMode.system == ThemeMode.dark ? true : false);

    emit(GetSavedThemeState());
  }

  toggelBritness({required bool isDark}) {
    emit(StartChangeBrightnessState());

    isDarkTheme = isDark;
    saveThemeMode();
    emit(ChangeBrightnessState());
  }

  saveThemeMode() {
    PreferenceUtils.setString(MyStrings.themeMode, isDarkTheme.toString());
  }

  setSplashTimer( ) async{
 await   Timer(
        Duration(milliseconds: 2400),
        () => Navigator.pushAndRemoveUntil(
            Market.navigatorKet.currentContext!,
            MaterialPageRoute(
                builder: (context) => onBoarding == "true"
                    ? ((isActive == "true" || isActive == null
                        ? NavigatorBarScreen()
                        : LoginScreen()))
                    : OnBoardingScreen()),
            (route) => false));
  }
}
