import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elamlymarket/modules/navigator_bar/view/navigator_bar_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/components/toast_app.dart';
import '../../../core/utils/notification_services.dart';
import '../../../core/utils/storage_key.dart';
import '../../verification/view/verification_screen.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);
  bool isHidePassword = true;
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  togglePassword() {
    emit(StartViewPasswordState());

    isHidePassword = !isHidePassword;
    emit(ChangeViewPasswordState());
  }

  bool isLoading = false;
  loginEmailAndPassword(context) async {
    isLoading = true;
    emit(LoadingLoginState());

    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim())
        .then((value) async {
      await FirebaseFirestore.instance
          .collection("users")
          .where("authId", isEqualTo: value.user!.uid)
          .get()
          .then((value) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(value.docs.first.id)
            .update({"token": registerToken});
        setLocalData(loginData: {
          "auth_id": value.docs.first.data()['authId'],
          "doc_id": value.docs.first.id,
          "email": value.docs.first.data()['email'],
          "phone": value.docs.first.data()['phone'],
          "name": value.docs.first.data()['fullname'],
          "is_active": value.docs.first.data()['isActive'].toString(),
          "is_verified": value.docs.first.data()['isVerified'].toString(),
          "token": registerToken,
          "image": value.docs.first.data()['image'],
        });
        isLoading = false;
        emit(LoginSuccessState());
        if (value.docs.first.data()['isVerified']) {
          if (value.docs.first.data()['isActive']) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => NavigatorBarScreen()),
                (route) => false);
          } else {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Account Inactive'),
                content:
                    Text('Your account is inactive, please contact support.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Ok'),
                  )
                ],
              ),
            );
          }
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VerificationScreen(
                        email: value.docs.first.data()['email'],
                        code: value.docs.first.data()['verificactionCode'],
                        userDocId: value.docs.first.id,
                      )));
        }
      });
    }).onError((FirebaseException error, stackTrace) {
      isLoading = false;
      toastApp(message: error.message.toString());
      emit(LoginFailedState());
    });
  }

  loginFacebook() async {}
  loginGoogle() async {}
  setLocalData({required Map loginData}) {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    storage.write(key: StorageKey.email, value: loginData['email']);
    storage.write(key: StorageKey.phone, value: loginData['phone']);
    storage.write(key: StorageKey.name, value: loginData['name']);
    storage.write(key: StorageKey.UserAuthId, value: loginData['auth_id']);
    storage.write(key: StorageKey.userDocId, value: loginData['doc_id']);
    storage.write(key: StorageKey.isActive, value: loginData['is_active']);
    storage.write(key: StorageKey.isVerified, value: loginData['is_verified']);
    storage.write(key: StorageKey.token, value: loginData['token']);
    storage.write(key: StorageKey.image, value: loginData['image']);
  }

  String? registerToken = "";

  getToken() async {
    WidgetsFlutterBinding.ensureInitialized();
    await [Permission.notification].request();
    try {

      registerToken = await FirebaseMessaging.instance.getToken();
      FirebaseMessaging.instance.subscribeToTopic("market");
      NotificationService().initNotification();

      FirebaseMessaging.onMessage.listen((event) async {
        String? title = event.notification?.title;
        String? body = event.notification?.body;

        await NotificationService().showNotification(
            Random().nextInt(10000) * Random().nextInt(10000),
            title ?? "",
            body ?? "");
      });

      FirebaseMessaging.onMessageOpenedApp.listen((event) {});
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
