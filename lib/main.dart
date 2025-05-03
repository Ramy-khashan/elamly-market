import 'dart:math';

import 'package:elamlymarket/core/components/toast_app.dart';
import 'package:elamlymarket/market.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'core/utils/notification_services.dart';
import 'core/utils/service_locator.dart';
import 'core/utils/shared_prefrance_utils.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Market.navigatorKet = GlobalKey<NavigatorState>();
  await Future.wait([
    PreferenceUtils.init(),
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ),
    notification(),
    init(),
  ]);
  runApp(const Market());
}

Future notification() async {
  NotificationService().initNotification();

  FirebaseMessaging.onMessage.listen((event) async {
    String? title = event.notification?.title;
    String? body = event.notification?.body;
    print(event.notification?.body);
    toastApp(message: event.notification!.body.toString());

    await NotificationService().showNotification(
        Random().nextInt(10000) * Random().nextInt(10000),
        title ?? "",
        body ?? "");
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) async {
    String? title = event.notification?.title;
    String? body = event.notification?.body;
    print("onMessageOpenedApp : " + event.notification!.body.toString());
    toastApp(message: event.notification!.body.toString());
    await NotificationService().showNotification(
        Random().nextInt(10000) * Random().nextInt(10000),
        title ?? "",
        body ?? "");
  });
}
