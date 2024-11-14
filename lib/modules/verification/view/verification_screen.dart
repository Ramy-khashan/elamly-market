import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elamlymarket/core/components/toast_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/my_colors.dart';
import 'package:pinput/pinput.dart';

import '../../../core/components/app_button.dart';
import '../../congrats/view/congrate_screen.dart';
import '../controller/verification_cubit.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen(
      {super.key,
      required this.email,
      required this.code,
      required this.userDocId});
  final String email;
  final String userDocId;
  final int code;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerificationCubit(),
      child: Scaffold(
        appBar: AppBar(),
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            // Image.asset(
            //   AppImage.bgImage,
            //   color: AppColors.primaryColor.withOpacity(.8),
            // ),
            BlocBuilder<VerificationCubit, VerificationState>(
              builder: (context, state) {
                final controller = VerificationCubit.get(context);
                return SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Enter 4-digit\nVerification code",
                          style:
                              TextStyle(fontSize: 28, fontFamily: "mainFont"),
                        ),
                        Text("Code send to $email"),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Pinput(
                              defaultPinTheme: PinTheme(
                                width: 60,
                                height: 70,
                                margin: const EdgeInsets.only(left: 5),
                                textStyle: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w600),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 202, 201, 201),
                                      width: 1.5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              focusedPinTheme: PinTheme(
                                width: 60,
                                height: 70,
                                margin: const EdgeInsets.only(left: 5),
                                textStyle: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w600),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: MyColors.greenColor, width: 1.5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (s) {
                                return null;
                              },
                              pinputAutovalidateMode:
                                  PinputAutovalidateMode.onSubmit,
                              showCursor: true,
                              length: 4,
                              controller: controller.codeController,
                              onCompleted: (pin) {
                                debugPrint(pin);
                              },
                            ),
                          ),
                        ),
                        const Spacer(),
                        Center(
                          child: AppButton(
                            width: 160,
                            onPressed: () async {
                              print(code.toString());
                              print(userDocId.toString());
                              if (code.toString() ==
                                  controller.codeController.text.trim()) {
                                await FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(userDocId)
                                    .update({"isVerified": true});
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const CongrateScreen(
                                          content:
                                              "Your Account Is Ready To Use"),
                                    ));
                              } else {
                                toastApp(message: "Wrong Code");
                              }
                            },
                            buttonText: "Verify",
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
