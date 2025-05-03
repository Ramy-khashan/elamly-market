import 'package:elamlymarket/modules/splash_screen/view/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/components/app_text_field.dart';
import '../../../../core/utils/validate.dart';
import '../../controller/account_cubit.dart';

showDeleteDialog(
 BuildContext _,
) async =>
    await showDialog(
        context: _,
        builder: (context) => BlocProvider.value(

              value: _.read<AccountCubit>(),
              child: BlocBuilder<AccountCubit, AccountState>(
                builder: (context, state) {
                  final controller = AccountCubit.get(context);
                  return AlertDialog.adaptive(
                    title: Text("Delete Account"),
                    content: Material(
                      color: Colors.transparent,
                      child: Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Form(
                              key: controller.formKeyLogin,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AppTextField(
                                    prefexIcon: Icon(Icons.email_outlined),
                                    label: 'Email',
                                    controller: controller.emailController,
                                    onValidate: (value) =>
                                        Validate.validateEmail(value!),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  SizedBox(
                                    height: (20),
                                  ),
                                  AppTextField(
                                    prefexIcon: Icon(Icons.password),
                                    label: 'Password',
                                    controller: controller.passwordController,
                                    isHidePassword: true,
                                    onValidate: (value) =>
                                        Validate.notEmpty(value!),
                                    keyboardType: TextInputType.visiblePassword,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () async {
                          if (controller.formKeyLogin.currentState!
                              .validate()) {
                            try {
                              final auth = FirebaseAuth.instance;
                              UserCredential? userCredential =
                                  await auth.signInWithEmailAndPassword(
                                      email: controller.emailController.text
                                          .trim(),
                                      password: controller
                                          .passwordController.text
                                          .trim());

                              userCredential.user!.delete().then((value) async {
                                await const FlutterSecureStorage()
                                    .deleteAll()
                                    .then((value) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SplashScreen()),
                                      (route) => false);
                                });
                              });
                            } catch (e) {
                              print(e);
                            }
                          }
                        },
                        child: Text(
                          "Delete",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ));
