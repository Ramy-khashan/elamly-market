import 'package:flutter/material.dart';
 import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../core/utils/my_colors.dart';
import '../../../core/utils/my_string.dart';

import '../../../core/utils/my_images.dart';
import '../../../generated/l10n.dart';
import '../../navigator_bar/view/navigator_bar_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill, image: AssetImage(MyImages.onBoarding))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              MyImages.logo,
             
            ),
            SizedBox(
              height: 20,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: '${S.of(context).onBoardingWelcome}\n',
                  style: TextStyle(
                      color: MyColors.whiteColor,
                      fontSize: 30,
                      fontFamily: MyStrings.fontFamily,
                      fontWeight: FontWeight.w500),
                  children: [
                    TextSpan(
                      text: S.of(context).onBoardingToOurStore,
                      style: TextStyle(
                          color: MyColors.whiteColor,
                          fontSize: 30,
                          fontFamily: MyStrings.fontFamily,
                          fontWeight: FontWeight.w500),
                    )
                  ]),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              S.of(context).onBoardingSubTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: MyColors.lightwhiteColor,
                fontSize: 14,
                fontFamily: MyStrings.fontFamily,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                  onPressed: () async {
                    await FlutterSecureStorage()
                        .write(key: MyStrings.onBoarding, value: "true");
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NavigatorBarScreen(),
                        ),
                        (route) => false);
                  },
                  child: Text(
                    S.of(context).onBoardingGetStarted,
                    style: Theme.of(context).textTheme.labelLarge,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
