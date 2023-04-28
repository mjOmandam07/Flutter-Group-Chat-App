import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/controllers/auth_controller.dart';
import 'package:hive/firebase_options.dart';
import 'package:hive/screens/entry/register.dart';
import 'package:hive/screens/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthController()));
  runApp(GetMaterialApp(initialRoute: '/', routes: {
    '/': (context) => const Splash(),
    '/register': (context) => const Register(),
  }));
}
