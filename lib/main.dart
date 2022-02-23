import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:sabzishop/Settings/color_palates.dart';
import 'package:sabzishop/controller/cart_controller.dart';
import 'package:sabzishop/controller/time_slots_controller.dart';
import 'package:sabzishop/services/http_service.dart';
import 'package:sabzishop/view/about_us.dart';
import 'package:sabzishop/view/contact_us_screen.dart';
import 'package:sabzishop/view/splash_screen.dart';
import 'package:sabzishop/services/http_service.dart';

import 'controller/bottom_bar.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  print(message.data);
  final routeFor = message.data['route'];
  print("Routedashfgbliujfdn"+routeFor);
  Get.toNamed(routeFor);
  flutterLocalNotificationsPlugin.show(
    message.data.hashCode,
    message.data['title'],
    message.data['body'],

    NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription:channel.description,
        ),
        iOS: const IOSNotificationDetails(
          presentBadge: true,
          presentAlert: true,
          presentSound: true,
        )
    ),
  );
}




const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.', // description
  importance: Importance.high,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

///----------------------------------main----------------------------------------///

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HttpService.getSlides();
  FirebaseMessaging.instance.requestPermission();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  runApp(MyApp());
  


}

class MyApp extends StatelessWidget {
  final bottomController = Get.put(BottomBarController());
  CartController cartController = Get.put(CartController());
  TimeSlotsController slotsController = Get.put(TimeSlotsController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("en", "US"),
        Locale("fa", "IR"),
        Locale("ur", "PK"),// OR Locale('ar', 'AE') OR Other RTL locales
      ],
      debugShowCheckedModeBanner: false,
      title: 'Sabzi Shop',
      theme: ThemeData(
        primarySwatch: ColorPalette.green,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          brightness: Brightness.dark,
        )
      ),
      home: SplashScreen(),
      routes: {
        "": (_) => ContactUs(),
        "": (_) => AboutUs()
      },
    );
  }
}






