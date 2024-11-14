import 'package:elamlymarket/core/components/toast_app.dart';
import 'package:elamlymarket/market.dart';
import 'package:elamlymarket/modules/login/view/login_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());
  static ForgetPasswordCubit get(context) => BlocProvider.of(context);
  bool isHidePassword = true;
  bool isHideConfirmPassword = true;
  bool isChangePassword = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  togglePassword() {
    emit(StartViewPasswordState());

    isHidePassword = !isHidePassword;
    emit(ChangeViewPasswordState());
  }

  toggleConfirmPassword() {
    emit(StartViewPasswordState());

    isHideConfirmPassword = !isHideConfirmPassword;
    emit(ChangeViewPasswordState());
  }

  changePassword() {
    emit(StartChangePasswordState());

    isChangePassword = !isChangePassword;
    emit(ChangePasswordState());
  }

  forgetPassword() async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailController.text.trim())
        .then((value) {
      toastApp(message: "check your E-mail to reset your password");
      Navigator.pushAndRemoveUntil(
          Market.navigatorKet.currentContext!,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false);
    }).onError((error, stackTrace) {
      toastApp(message: "Failed to reset your password");
    });
  }
}
