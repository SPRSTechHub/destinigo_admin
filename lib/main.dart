import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:destinigo_admin/services/local_notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:destinigo_admin/home.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Destinigo',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
            splash: 'assets/images/splash.png',
            splashIconSize: double.infinity,
            duration: 3000,
            splashTransition: SplashTransition.scaleTransition,
            nextScreen: const MyHomePage(
              title: 'SPRS',
            ),
            backgroundColor: Colors.blue.shade900));
  }
}
