// ignore_for_file: unused_element, prefer_const_constructors, avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NotificationService extends GetxController {
  late final FirebaseMessaging _messaging;
  static NotificationService instance = Get.find();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();
    registerNotification();
    checkForInitialMessage();
    super.onInit();
  }

  void registerNotification() async {
    _messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();

      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@drawable/ic_stat_download');

      // final IOSInitializationSettings initializationSettingsIOS =
      //     IOSInitializationSettings(
      //         requestAlertPermission: true,
      //         requestBadgePermission: true,
      //         requestSoundPermission: true,
      //         onDidReceiveLocalNotification: onDidReceiveLocalNotification);

      // final MacOSInitializationSettings initializationSettingsMacOS =
      //     const MacOSInitializationSettings();

      final InitializationSettings initializationSettings =
          InitializationSettings(
        android: initializationSettingsAndroid,
        // iOS: initializationSettingsIOS,
        // macOS: initializationSettingsMacOS
      );

      await flutterLocalNotificationsPlugin.initialize(initializationSettings);

      FirebaseMessaging.onMessage.listen(showFlutterNotification);
    } else {
      print('User declined or has not accepted permission');
    }
  }

  void showFlutterNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your channel id', 'your channel name',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false);
    // const IOSNotificationDetails iOSPlatformChannelSpecifics =
    //     IOSNotificationDetails(
    //         presentAlert: true, presentBadge: true, presentSound: true);
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      // iOS: iOSPlatformChannelSpecifics
    );
    if (notification != null && android != null && !kIsWeb) {
      flutterLocalNotificationsPlugin.show(
          0, notification.title, notification.body, platformChannelSpecifics,
          payload: message.data.toString());
    }
  }

  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {}

  Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    FirebaseMessaging.onMessageOpenedApp.listen(showFlutterNotification);
  }

  // // For handling notification when the app is in terminated state
  checkForInitialMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      showFlutterNotification(initialMessage);
    }
  }

  Future postNotification(
      {required String title,
      required String body,
      required String receiverToken}) async {
    String url = 'https://fcm.googleapis.com/fcm/send';
    Map<String, String> headers = {
      "Content-type": "application/json",
      ///// Put Your Fcm Server key  Here ////////
      "Authorization":
          "key=AAAAwGhMcBY:APA91bGH-e933HMsLhFOiINyBx1tzDR3MWoVeu2D7Jn2XDyqsn2PF6ASQO115sNqi0M-pFEL3aLXy9U2kAOhHG7J6kRGlKcD-_THAg26hpMwF6IHpxF1v2PEymIfZywy79Rltrax6ufl"
    };
    var json = jsonEncode({
      "notification": {
        "body": body,
        "title": title,
        "sound": "default",
        "color": "#990000",
      },
      "priority": "high",
      // "data": {
      //   "clickaction": "FLUTTERNOTIFICATIONCLICK",
      //   "forRole": forRole,
      //   "userID": userID,
      //   "orderId": orderID,
      //   "status": "done"
      // },
      "to": receiverToken,
    });
    var response =
        await http.post(Uri.parse(url), headers: headers, body: json);
    print(response);
    return true;
  }
}
