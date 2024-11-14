import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

sendMultiNotificaction({
  required String token,
  required String title,
  required String body,
}) async {
  final data = {
    "to": token,
    // "registration_ids":[tokens]
    "notification": {"title": title, "body": body},
  };

  await Dio().post("https://fcm.googleapis.com/fcm/send",
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader:
            "Bearer  AAAAZ_uqIK8:APA91bFxieQJzeNSbeVHOUkXBH-52eoGAYSgY_NgP67psfYWBQRBRjIETMGEG7--faekB_0Rh-gPhczKBIJhE_Kp8hBAPeYVyyZhpP-gohO75HA9jMyvvXWTtXFrVkf3JxWiz2V_l1Bv "
      }),
      data: jsonEncode(data));
}
