import 'package:elamlymarket/market.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'core/utils/service_locator.dart';
import 'core/utils/shared_prefrance_utils.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  Market.navigatorKet = GlobalKey<NavigatorState>();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.wait([
    PreferenceUtils.init(),
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ),
    init(),
  ]);
  runApp(const Market());

  FlutterNativeSplash.remove();
}
