import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  LocalNotificationService._();

  static final FlutterLocalNotificationsPlugin
  _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  // notification tap
  @pragma('vm:entry-point')
  static void onTap(NotificationResponse response) {
    print('Notification tapped: ${response.payload}');
  }

  static Future<void> init() async {
    // 🔔 Android 13+ permission
    if (Platform.isAndroid) {
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
    }

    //  iOS permission
    if (Platform.isIOS) {
      await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    InitializationSettings settings = const InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(),
    );

    await _flutterLocalNotificationsPlugin.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: onTap, // (details) {},
      onDidReceiveBackgroundNotificationResponse: onTap, //(details) {},
    );

    // FOREGROUND Firebase listener
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final title =
          message.data['title'] ??
          message.notification?.title ??
          'Notification';

      final body = message.data['body'] ?? message.notification?.body ?? '';

      showNotification(title: title, body: body);
    });
  }

  // show notification
  static Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    const NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        'default_channel',
        'Default Notifications',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    await _flutterLocalNotificationsPlugin.show(
      id: 1,
      title: title,
      body: body,
      notificationDetails: details,
    );
  }
}


// import 'dart:io';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import 'di.dart';

// class LocalNotificationService {
//   LocalNotificationService._();

//   static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//         static final FirebaseMessaging _firebaseMessaging =
//       locator<FirebaseMessaging>();

//   static onTap(NotificationResponse notificationResponse) {}

//   static Future init() async {

//     if(Platform.isAndroid) {
//         await    flutterLocalNotificationsPlugin
//                 .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()!
//              .requestNotificationsPermission();
//     }


//     InitializationSettings settings = const InitializationSettings(
//       android: AndroidInitializationSettings("@mipmap/ic_launcher"),
//       iOS: DarwinInitializationSettings(),
//     );


//         if (Platform.isIOS) {
//           _firebaseMessaging.requestPermission();
//           _firebaseMessaging.getNotificationSettings();
//         }
//     flutterLocalNotificationsPlugin.initialize(
//       settings: settings,
//       onDidReceiveNotificationResponse: onTap, // (details) {},
//       onDidReceiveBackgroundNotificationResponse: onTap, //(details) {},
//     );
//   }



  

//   // Basic Notification
//   static void showBasicNotification() async {
//     NotificationDetails details = const NotificationDetails(
//       android: AndroidNotificationDetails(
//         "id 1",
//         "Basic Notification",
//         importance: Importance.max,
//         priority: Priority.high,
//       ),
//     );
//     await flutterLocalNotificationsPlugin.show(
//       id: 0,
//       title: 'basic notification',
//       body: 'body notification',
//       notificationDetails: details,
//       payload: "",
//     );
//   }

//   // Repeat Notification
//   static void showRepeatNotification() async {
//     NotificationDetails details = const NotificationDetails(
//       android: AndroidNotificationDetails(
//         "id 1",
//         "repeated Notification",
//         importance: Importance.max,
//         priority: Priority.high,
//       ),
//     );
//     await flutterLocalNotificationsPlugin.periodicallyShow(
//       id: 0,
//       title: 'repeat notification',
//       body: 'body',
//       androidScheduleMode: AndroidScheduleMode.exact,

//       repeatInterval: RepeatInterval.everyMinute,
//       notificationDetails: details,
//       payload: "",
//     );
//   }
// }









//============================================================================================

// /* import 'dart:async';
// import 'dart:developer';
// import 'dart:io';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_app_badger/flutter_app_badger.dart';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import 'di.dart';

// final class LocalNotificationService {
//   LocalNotificationService._();
//   static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
//   static final FirebaseMessaging _firebaseMessaging = locator<FirebaseMessaging>();

//   static void initialize() {
//     // initializationSettings  for Android
//     if (Platform.isAndroid) {
//       _notificationsPlugin
//           .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()!
//           .requestNotificationsPermission();
//     }

//     const InitializationSettings initializationSettings = InitializationSettings(
//       android: AndroidInitializationSettings("@mipmap/ic_launcher"),
//       iOS: DarwinInitializationSettings(),
//     );

//     if (Platform.isIOS) {
//       _firebaseMessaging.requestPermission();
//       _firebaseMessaging.getNotificationSettings();
//     }
//     // 1. This method only call when App is terminated(closed)
//     // FirebaseMessaging.instance.getInitialMessage().then(
//     //   (message) {
//     //     if (message != null) {
//     //       FlutterAppBadger.updateBadgeCount(1);
//     //     }
//     //   },
//     // );

//     // 2. This method only call when App in forground it mean app must be opened
//     FirebaseMessaging.onMessage.listen(
//       (message) {
//         if (message.notification != null) {
//           FlutterAppBadger.removeBadge();
//           LocalNotificationService.createanddisplaynotification(message);
//         }
//       },
//     );

//     // 3. This method only call when App in background and not terminated(not closed)
//     FirebaseMessaging.onMessageOpenedApp.listen(
//       (message) {},
//     );

//     _notificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: ((details) {
//       {}
//     }));
//   }

//   static void createanddisplaynotification(RemoteMessage message) async {
//     try {
//       final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
//       const NotificationDetails notificationDetails = NotificationDetails(
//         android: AndroidNotificationDetails(
//           "plix",
//           "plixpushnotificationappchannel",
//           importance: Importance.max,
//           priority: Priority.high,
//           color: Colors.black,
//         ),
//       );

//       await _notificationsPlugin.show(
//         id,
//         message.notification!.title,
//         message.notification!.body,
//         notificationDetails,
//         payload: message.data['url'],
//       );
//     } on Exception catch (e) {
//       log(e.toString());
//     }
//   }

//   static Future<void> getToken() async {
//     _firebaseMessaging.getToken().then((token) async {
//       log('[FCM]--> token: [ $token ]');
//       await sendToken(token!);
//     });

//     _firebaseMessaging.onTokenRefresh.listen((token) async {
//       log('[FCM]--> token: [ $token ]');
//       await sendToken(token);
//     });
//   }

//   static Future<void> sendToken(String token) async {
//     try {
//       // postDeviceTokenRXobj.postDeviceToken(token: token);
//     } catch (error) {
//       rethrow;
//     }
//   }

//   static Future<void> removeToken() async {
//     try {
//       _firebaseMessaging.deleteToken();
//     } catch (error) {
//       rethrow;
//     }
//   }
// }
//  */