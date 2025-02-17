import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elamlymarket/market.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/components/toast_app.dart';
import '../../congrats/view/congrate_screen.dart';

part 'verification_state.dart';

class VerificationCubit extends Cubit<VerificationState> {
  VerificationCubit() : super(VerificationInitial());
  static VerificationCubit get(context) => BlocProvider.of(context);
  final codeController = TextEditingController();
  Future<void> sendEmailVerification() async {
    try {
      print(FirebaseAuth.instance.currentUser!.email);
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      toastApp(message: e.message.toString());
    } on FirebaseException catch (e) {
      toastApp(message: e.message.toString());
    } on PlatformException catch (e) {
      toastApp(message: e.message.toString());
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  setTimerForAutoRedirect(String userDocId) {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userDocId)
            .update({"isVerified": true});
        Navigator.push(
            Market.navigatorKet.currentContext!,
            MaterialPageRoute(
              builder: (context) => const SuccessScreen(),
            ));
      }
    });
  }

  checkEmailVerificationStatus(String userDocId) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userDocId)
          .update({"isVerified": true});
      Navigator.push(
          Market.navigatorKet.currentContext!,
          MaterialPageRoute(
            builder: (context) => const SuccessScreen(),
          ));
      // Get.off(SuccessScreen(
      //   isLottie: true,
      //   image: TImages.successfullyRegisterAnimation,
      //   title: TTexts.yourAccountCreatedTitle,
      //   subTitle: TTexts.yourAccountCreatedSubTitle,
      //   onPressed: () => AuthenticationRepository.instance.screenRedirect(),
      // ));
    } else {
      toastApp(message: "Please verify your email to continue.");
    }
  }
}
