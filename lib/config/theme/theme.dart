import 'package:flutter/material.dart';

import '../../core/utils/my_colors.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 1,
        titleTextStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w900, fontSize: 19),
        centerTitle: true,
        scrolledUnderElevation: 1,
        iconTheme: IconThemeData(color: MyColors.blackColor)),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.greenColor,
            foregroundColor: MyColors.whiteColor,
            shadowColor: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(19),
            ),
            padding: EdgeInsets.symmetric(vertical: 10))));

ThemeData darkTheme = ThemeData.dark().copyWith(
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 19),
        centerTitle: true,),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.greenColor,
            foregroundColor: MyColors.whiteColor,
            shadowColor: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(19),
            ),
            padding: EdgeInsets.symmetric(vertical: 10))));
