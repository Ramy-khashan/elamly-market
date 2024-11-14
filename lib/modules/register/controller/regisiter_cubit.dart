import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emailjs/emailjs.dart' as emailjs;
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../verification/view/verification_screen.dart';
part 'regisiter_state.dart';

class RegisiterCubit extends Cubit<RegisiterState> {
  RegisiterCubit() : super(RegisiterInitial()) {
    getToken();
  }
  static RegisiterCubit get(context) => BlocProvider.of(context);
  final formKey = GlobalKey<FormState>();
  bool isHidePassword = true;
  bool isPriceReminder = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  togglePassword() {
    emit(StartViewPasswordState());

    isHidePassword = !isHidePassword;
    emit(ChangeViewPasswordState());
  }

  togglePriceReminder() {
    emit(StartSetPriceState());

    isPriceReminder = !isPriceReminder;
    emit(SetPriceState());
  }

  int generateRandomInt() {
    Random random = Random();
    int randomString =
        int.parse((List.generate(4, (_) => random.nextInt(9))).join());
    return randomString;
  }

  bool isLoadingRegistered = false;
  register(context) async {
    try {
      isLoadingRegistered = true;
      emit(LoadingCreateAccount());
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim())
          .then((value) async {
        int verificationCode = generateRandomInt();
        await sendEmail(templateParams: {
          "subject": "Verify Account",
          "name": nameController.text.trim(),
          "email": emailController.text.trim(),
          "message": verificationCode,
        });
        FirebaseFirestore.instance.collection("users").add({
          "email": emailController.text.trim(),
          // "password": passwordController.text.trim(),
          "phone": phoneController.text.trim(),
          "fullname": nameController.text.trim(),
          "authId": value.user!.uid.toString(),
          "registerTime": DateTime.now().toString(),
          "verificactionCode": verificationCode,
          "isActive": true,
          "isVerified": false,
          "token": registerToken,
          "image":
              "https://firebasestorage.googleapis.com/v0/b/have-fun-a5c87.appspot.com/o/userImg.png?alt=media&token=4f962df4-7c2d-4dd2-8950-f64e1ed9863d"
        }).then((value) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VerificationScreen(
                  email: emailController.text.trim(),
                  code: verificationCode,
                  userDocId: value.id,
                ),
              ));
        });
      });
      isLoadingRegistered = false;
      emit(AccountCreatedState());
    } catch (e) {
      isLoadingRegistered = false;
      emit(AccountCreatedFailedState());

      debugPrint(e.toString());
    }
  }

  sendEmail({Map<String, dynamic>? templateParams}) async {
    try {
      await emailjs.send(
        'service_wics0vk',
        'template_qxk68gy',
        templateParams,
        const emailjs.Options(
            publicKey: 'WSKPELKgoonIipEI9',
            privateKey: "1hsnmaI-qFd4IcqZZM6s_"),
      );
      debugPrint('SUCCESS!');
      return true;
    } catch (error) {
      if (error is emailjs.EmailJSResponseStatus) {
        debugPrint('ERROR... ${error.status}: ${error.text}');
      }
      debugPrint(error.toString());
      return false;
    }
  }

  String? registerToken = "";
  getToken() async {
    registerToken = await FirebaseMessaging.instance.getToken();
    print(registerToken);
  }
}
