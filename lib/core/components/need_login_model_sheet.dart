import 'package:elamlymarket/modules/login/view/login_screen.dart';
import 'package:elamlymarket/modules/register/view/register_screen.dart';
import 'package:flutter/material.dart';

import '../utils/my_colors.dart';
import '../utils/size_config.dart';
import 'app_button.dart';

needLogin({required BuildContext context}) {
  SizeConfig().init(context);
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.transparent,
    elevation: 0,
    builder: (context) => Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: getHeight(50)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: getWidth(100),
            height: getHeight(9),
            decoration: const BoxDecoration(
                color: MyColors.whiteColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
          ),
          SizedBox(
            height: getHeight(20),
          ),
          Padding(
            padding: EdgeInsets.all(getWidth(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (route) => false);
                  },
                  buttonText: "Go to sign in",
                ),
                SizedBox(
                  height: getHeight(getHeight(15)),
                ),
                AppButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()),
                        (route) => false);
                  },
                  textColor: Colors.white,
                  buttonText: "Go to sign up",
                ),
                SizedBox(
                  height: getHeight(20),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
