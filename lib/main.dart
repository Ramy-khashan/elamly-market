import 'package:elamlymarket/market.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
    init(),
  ]);
  runApp(const Market());

 }
