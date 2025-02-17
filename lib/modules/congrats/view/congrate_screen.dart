import 'package:elamlymarket/modules/login/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    super.key,
    this.onPressed,
  });
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(
                height: 16.0,
              ),
              //Image

              Lottie.asset("assets/images/verification_done.json"),
              const SizedBox(
                height: 16.0,
              ),
              //Title and subtitle
              Text(
                "Your account successfully created!",
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                  "Welcome to Elamly Market: Prepare Exlosive Offers and Discover Unlimited Sales!",
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center),
              const SizedBox(
                height: 16.0,
              ),
              //Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: onPressed == null
                        ? () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                                (route) => false);
                          }
                        : onPressed,
                    child: Text(
                      "Continue",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .apply(color: Colors.white),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
