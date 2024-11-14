import 'package:elamlymarket/core/utils/validate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/components/app_button.dart';
import '../../../core/components/app_text_field.dart';
import '../../../core/components/text_gradient.dart';
import '../../../core/utils/my_colors.dart';
import '../controller/forget_password_cubit.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(),
      child: BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
        builder: (context, state) {
          ForgetPasswordCubit controller = ForgetPasswordCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: controller.isChangePassword
                      ? () {
                          controller.changePassword();
                        }
                      : () {
                          Navigator.pop(context);
                        },
                  icon: Icon(Icons.arrow_back)),
            ),
            extendBodyBehindAppBar: true,
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                // Image.asset(
                //   AppImage.bgImage,
                //   color: AppColors.primaryColor.withOpacity(.8),
                // ),
                SafeArea(
                  child: Form(
                    key: controller.formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            "Forgot password?",
                            style: TextStyle(
                                fontSize: 28,
                                fontFamily: "mainFont",
                                fontWeight: FontWeight.w600),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Text(controller.isChangePassword
                                ? "Code send to ${controller.emailController.text} ."
                                : "Write your email to reset your email"),
                          ),
                          if (!controller.isChangePassword)
                            AppTextField(
                              horizontal: 0,
                              prefexIcon: Padding(
                                padding: const EdgeInsets.all(9),
                                child: GradientText(
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          MyColors.greenColor.withOpacity(.3),
                                          MyColors.greenColor.withOpacity(.5),
                                          MyColors.greenColor.withOpacity(.8),
                                          MyColors.greyColor.withOpacity(.8),
                                          MyColors.greyColor,
                                        ]),
                                    child: Icon(CupertinoIcons.mail)),
                              ),
                              onValidate: (value) =>
                                  Validate.validateEmail(value),
                              controller: controller.emailController,
                              label: "Email",
                            ),
                          const Spacer(),
                          Center(
                            child: AppButton(
                              width: double.infinity,
                              onPressed: () {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  controller.forgetPassword();
                                }
                              },
                              buttonText: controller.isChangePassword
                                  ? "Change Password"
                                  : "Continue",
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
