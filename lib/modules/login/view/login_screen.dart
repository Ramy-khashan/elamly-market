import 'package:elamlymarket/core/components/loading_item.dart';
import 'package:elamlymarket/modules/navigator_bar/view/navigator_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/my_images.dart';

import '../../../core/components/app_text_field.dart';
import '../../../core/components/text_gradient.dart';
import '../../../core/utils/my_colors.dart';
import '../../../core/utils/validate.dart';
import '../../forget_password/view/forget_password_screen.dart';
import '../../register/view/register_screen.dart';
import '../controller/login_cubit.dart';
import 'widgets/support_dialog.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit()..getToken(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          backgroundColor: MyColors.greenColor,
          onPressed: () {
            supportDialog(context);
          },
          child: Icon(Icons.support_agent),
        ),
        body: Stack(
          children: [
            SafeArea(
              child: BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  LoginCubit controller = LoginCubit.get(context);
                  return Form(
                    key: controller.formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: Image.asset(
                              MyImages.logo,
                              width: (130),
                              height: (100),
                              fit: BoxFit.contain,
                            ),
                          ),
                          const GradientText(
                            text: "Elamly Market",
                            gradient: LinearGradient(colors: [
                              MyColors.greenColor,
                              MyColors.greyColor
                            ]),
                            style: TextStyle(
                              fontSize: 40,
                              fontFamily: "mainFont",
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Deliever Favorite Food",
                            style: TextStyle(fontSize: 15),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: (38), bottom: (22)),
                            child: const Text(
                              "Login To Your Account",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          AppTextField(
                            onValidate: (value) => Validate.notEmpty(value),
                            controller: controller.emailController,
                            label: "Email",
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          AppTextField(
                            onValidate: (value) => Validate.notEmpty(value),
                            controller: controller.passwordController,
                            label: "Password",
                            isHidePassword: controller.isHidePassword,
                            isPassword: true,
                            onPressShow: () => controller.togglePassword(),
                          ),
                          Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  padding: const EdgeInsets.all(20)),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgetPasswordScreen(),
                                    ));
                              },
                              child: Text(
                                "Forgot Your Password?",
                                style: TextStyle(
                                    color: Colors.red.shade600,
                                    fontSize: 12,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 20),
                            child: controller.isLoading
                                ? LoadingItem()
                                : ElevatedButton(
                                    onPressed: () {
                                      if (controller.formKey.currentState!
                                          .validate()) {
                                        controller
                                            .loginEmailAndPassword(context);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 13.h),
                                    ),
                                    child: Center(
                                        child: Text(
                                      "Login",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18.sp),
                                    ))),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen(),
                                  ));
                            },
                            child: const GradientText(
                              text: "Don't have an accout?",
                              gradient: LinearGradient(colors: [
                                MyColors.greenColor,
                                MyColors.greyColor
                              ]),
                              style: TextStyle(
                                  fontSize: 12,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const NavigatorBarScreen(),
                                  ));
                            },
                            child: const GradientText(
                              text: "Continue as a Guest",
                              gradient: LinearGradient(colors: [
                                MyColors.greenColor,
                                MyColors.greyColor
                              ]),
                              style: TextStyle(
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
