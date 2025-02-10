import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

 import '../../../core/components/app_text_field.dart';
import '../../../core/components/loading_item.dart';
import '../../../core/components/text_gradient.dart';
import '../../../core/utils/my_colors.dart';
import '../../../core/utils/my_constants.dart';
import '../../../core/utils/my_images.dart';
import '../../../core/utils/validate.dart';
import '../controller/regisiter_cubit.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisiterCubit>(
      create: (context) => RegisiterCubit(),
      child: Scaffold(
        body: Stack(
          children: [
            // Image.asset(
            //   AppImage.bgImage,
            //   color: MyColors.greenColor.withOpacity(.8),
            // ),
            SafeArea(
              child: BlocBuilder<RegisiterCubit, RegisiterState>(
                builder: (context, state) {
                  RegisiterCubit controller = RegisiterCubit.get(context);
                  return Form(
                    key: controller.formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Image.asset(
                              MyImages.logo,
                              width: (120),
                              height: (90),
                              fit: BoxFit.contain,
                            ),
                          ),
                          const GradientText(
                            text: "Elamly's Market",
                            gradient: LinearGradient(colors: [
                              MyColors.greenColor,
                              MyColors.greyColor
                            ]),
                            style: TextStyle(
                              fontSize: 40,
                              fontFamily: "mainFont",
                            ),
                          ),
                          const Text(
                            "Deliever Favorite Food",
                            style: TextStyle(fontSize: 13),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: (30), bottom: (15)),
                            child: const Text(
                              "Sign Up For Free",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          AppTextField(
                            prefexIcon: Padding(
                                padding: const EdgeInsets.all(9),
                                child: GradientText(
                                    gradient: linearGradient,
                                    child: Icon(CupertinoIcons.person_fill))),
                            onValidate: (val) => Validate.notEmpty(val),
                            controller: controller.nameController,
                            label: "Full name",
                          ),
                          AppTextField(
                            prefexIcon: Padding(
                                padding: const EdgeInsets.all(9),
                                child: GradientText(
                                    gradient: linearGradient,
                                    child: Icon(CupertinoIcons.mail))),
                            onValidate: (val) => Validate.validateEmail(val),
                            controller: controller.emailController,
                            label: "Email",
                          ),
                          AppTextField(
                            keyboardType: TextInputType.phone,
                            prefexIcon: Padding(
                              padding: const EdgeInsets.all(13),
                              child: GradientText(
                                  gradient: linearGradient,
                                  child: Icon(CupertinoIcons.phone)),
                            ),
                            onValidate: (val) =>
                                Validate.validateEgyptPhoneNumber(val),
                            controller: controller.phoneController,
                            label: "Phone number",
                          ),
                          AppTextField(
                            prefexIcon: Padding(
                              padding: const EdgeInsets.all(9),
                              child: GradientText(
                                  gradient: linearGradient,
                                  child: Icon(CupertinoIcons.lock)),
                            ),
                            onValidate: (val) {
                              if (val.toString().length < 8) {
                                return "Password too short";
                              }
                              if (!val.toString().contains(RegExp(r'[a-z]'))) {
                                return "Password must containe lower-case";
                              }
                              if (!val.toString().contains(RegExp(r'[A-Z]'))) {
                                return "Password must containe upper-case";
                              }
                              if (!val
                                  .toString()
                                  .contains(RegExp(r'[\@\#\$\%\^\&\*\^\!]'))) {
                                return "Password must containe special character";
                              }
                              if (!val.toString().contains(RegExp(r'[0-9]'))) {
                                return "Password must containe numbers";
                              }
                              return null;
                            },
                            controller: controller.passwordController,
                            label: "Password",
                            isHidePassword: controller.isHidePassword,
                            isPassword: true,
                            onPressShow: () => controller.togglePassword(),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 15, bottom: 20),
                          //   child: ListTile(
                          //     onTap: () {
                          //       controller.togglePriceReminder();
                          //     },
                          //     dense: true,
                          //     title: const Text(
                          //       "Email Me About Special Pricing",
                          //       style: TextStyle(fontFamily: "mainFont"),
                          //     ),
                          //     leading: AnimatedContainer(
                          //       duration: const Duration(milliseconds: 200),
                          //       padding: const EdgeInsets.all(3),
                          //       decoration: BoxDecoration(
                          //           border: Border.all(
                          //               color: MyColors.greenColor, width: 1),
                          //           shape: BoxShape.circle,
                          //           gradient: LinearGradient(
                          //               colors: controller.isPriceReminder
                          //                   ? [
                          //                       MyColors.greenColor,
                          //                       MyColors.greyColor
                          //                     ]
                          //                   : [
                          //                       Colors.transparent,
                          //                       Colors.transparent
                          //                     ],
                          //               begin: Alignment.centerLeft,
                          //               end: Alignment.centerRight)),
                          //       child: Icon(
                          //         Icons.done,
                          //         size: 25,
                          //         color: controller.isPriceReminder
                          //             ? Colors.white
                          //             : Colors.transparent,
                          //       ),
                          //     ),
                          //   ),
                          // ),

                          Padding(
                            padding: const EdgeInsets.only(
                                top: 40, left: 20, right: 20),
                            child: controller.isLoadingRegistered
                                ? LoadingItem()
                                : ElevatedButton(
                                    onPressed: () {
                                      if (controller.formKey.currentState!
                                          .validate()) {
                                        controller.register(context);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 13.h),
                                    ),
                                    child: Center(
                                        child: Text(
                                      "Create Account",
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
                              Navigator.pop(
                                context,
                              );
                            },
                            child: const GradientText(
                              text: "Already have an account?",
                              gradient: LinearGradient(colors: [
                                MyColors.greenColor,
                                MyColors.greyColor
                              ]),
                              style: TextStyle(
                                  fontSize: 13,
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
