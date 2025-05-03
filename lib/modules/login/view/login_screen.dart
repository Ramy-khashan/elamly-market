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
          backgroundColor: MyColors.orangeColor,
          onPressed: () {
            supportDialog(context);
          },
          child: Icon(
            Icons.support_agent,
            color: MyColors.whiteColor,
            size: 30,
          ),
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
                          Image.asset(
                            MyImages.logo,
                            fit: BoxFit.fill,
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
                                    color: Colors.red,
                                    fontSize: 12,
                                    decorationColor: Colors.red,
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
                                          fontSize: 18),
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
                                MyColors.orangeColor,
                                MyColors.deepOrangeColor,
                                MyColors.orangeColor,
                              ]),
                              style: TextStyle(
                                  fontSize: 15,
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
                                MyColors.orangeColor,
                                MyColors.deepOrangeColor,
                                MyColors.orangeColor,
                              ]),
                              style: TextStyle(
                                  fontSize: 15,
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
