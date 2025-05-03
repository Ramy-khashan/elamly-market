import 'dart:io';

import 'package:elamlymarket/core/components/toast_app.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact {
  static contactUsWhatsApp() async {
    var contact = "+201141501542";

    var androidUrl = "whatsapp://send?phone=$contact";
    var iosUrl = "https://wa.me/$contact";

    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception {
      toastApp(message: 'WhatsApp is not installed.', isError: true);
    }
  }

  static callUs() async {
    var contact = "+201141501542";

    try {
      await launchUrl(Uri.parse("tel:$contact"));
    } catch (e) {
      toastApp(message: e.toString());
    }
  }

  static launchSite(String url) async {
    await launchUrl(Uri.parse(url));
  }
}
