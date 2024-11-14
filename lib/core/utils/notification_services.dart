import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> initNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/launch_background');
    DarwinInitializationSettings? initializationSettingsIOS;
    if (Platform.isIOS) {
      initializationSettingsIOS = const DarwinInitializationSettings();
    }

    InitializationSettings initializationSettings = Platform.isAndroid
        ? const InitializationSettings(android: initializationSettingsAndroid)
        : InitializationSettings(iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  AndroidNotificationDetails androidNotificationDetails =
      const AndroidNotificationDetails(
    'default_notification_channel_id',
    'Default',
    importance: Importance.max,
    priority: Priority.max,
  );

  Future<void> showNotification(
      int id, String title, String body ) async {
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,

      Platform.isAndroid
          ? NotificationDetails(
              android: androidNotificationDetails,
            )
          : const NotificationDetails(
              iOS: DarwinNotificationDetails(
                presentAlert: true,
                presentBadge: true,
                presentSound: true,
              ),
            ),
      // uiLocalNotificationDateInterpretation:
      //     UILocalNotificationDateInterpretation.absoluteTime,
      // androidAllowWhileIdle: true,
    );
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
