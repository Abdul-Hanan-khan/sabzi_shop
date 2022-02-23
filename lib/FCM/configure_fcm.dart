import 'dart:io';

// import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<dynamic> _onIOSNotificationReceived(int id, String title, String body, String payload ){

  print("iOSNR");
//   print(title);
// flutterLocalNotificationsPlugin.show(id, title, body,  NotificationDetails(
//     // android: AndroidNotificationDetails(
//     //   channel.id,
//     //   channel.name,
//     //   channel.description,
//     //   // icon: android?.smallIcon,
//     // ),
//     iOS: IOSNotificationDetails(
//       presentSound: true,
//       presentAlert: true,
//       presentBadge: true,
//     )
// ));
}
class FCM{
  static configureFCM() {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.', // description
      importance: Importance.max,
    );

    ///ios setting
    var initialzationSettingsIos = IOSInitializationSettings(onDidReceiveLocalNotification: _onIOSNotificationReceived);

    ///android setting
    var initialzationSettingsAndroid = AndroidInitializationSettings('@drawable/ic_stat_61');


    ///initialization of settinggs
    var initializationSettings = InitializationSettings(android: initialzationSettingsAndroid, iOS: initialzationSettingsIos);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("on message");
      print(message.notification.title);
      // FirebaseMessaging.instance.requestPermission();
      RemoteNotification notification = message.notification;
      // AppleNotification apple = message.notification?.apple;
      AndroidNotification android = message.notification?.android;

      print("android notification: ${android}");
      // print("apple notification: ${apple.subtitle}");

      if (notification != null &&(android !=null)) {
        // if(apple != null)
        {
          await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
            alert: true, // Required to display a heads up notification
            badge: true,
            sound: true,
          );
        }

        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                // icon: android?.smallIcon,
                // icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });
  }


}