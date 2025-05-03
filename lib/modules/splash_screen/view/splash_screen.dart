import 'package:elamlymarket/core/utils/my_images.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          MyImages.splashScreen,
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ),
        // Column(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     Image.asset(
        //       MyImages.logo,
        //       scale: 7,
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.only(top: 20),
        //       child: Text(
        //         "Elamly Market",
        //         style: TextStyle(
        //             fontSize: 45,
        //             fontFamily: MyStrings.fontFamily,
        //             fontWeight: FontWeight.w900,
        //             color: const Color.fromARGB(255, 176, 98, 15)),
        //       ),
        //     )
        //   ],
        // ),
      ),
    );
  }
}
