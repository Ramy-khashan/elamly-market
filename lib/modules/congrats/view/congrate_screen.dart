import 'package:elamlymarket/modules/login/view/login_screen.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/my_colors.dart';
import '../../../core/components/app_button.dart';
import '../../../core/components/text_gradient.dart';

import '../../../core/utils/my_images.dart';

class CongrateScreen extends StatelessWidget {
  const CongrateScreen({super.key, required this.content});
  final String content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      MyImages.congrate,
                      width: (180),
                      height: (170),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 40, bottom: 10),
                      child: GradientText(
                        gradient: LinearGradient(
                            colors: [MyColors.greenColor, MyColors.greyColor]),
                        text: "Congrats!",
                        style: TextStyle(fontSize: 28, fontFamily: "mainFont"),
                      ),
                    ),
                    Text(
                      content,
                      style:
                          const TextStyle(fontSize: 23, fontFamily: "mainFont"),
                    ),
                  ],
                ),
              ),
              Center(
                child: AppButton(
                  width: 200,
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (route) => false);
                  },
                  buttonText: "Back To Login",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
