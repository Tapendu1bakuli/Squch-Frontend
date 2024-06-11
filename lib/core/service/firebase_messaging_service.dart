import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../shared_pref/shared_pref.dart';
import '../shared_pref/shared_pref_impl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FireBaseMessagingService extends GetxService {
  Future<FireBaseMessagingService> init() async {

    FirebaseMessaging.instance
        .requestPermission(sound: true, badge: true, alert: true);
    await setDeviceToken();
    await fcmOnLaunchListeners();
    await fcmOnResumeListeners();
    await fcmOnMessageListeners();
    return this;
  }
  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async{
    print("Handling a background message: ${message.messageId}");
  }

  Future fcmOnMessageListeners() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("Messege Received ===> "+message.data.toString());
      if (message.data.isEmpty) {
        _newMessageNotification(message);
      }
    });
  }
  Future fcmOnLaunchListeners() async {
    RemoteMessage? message =
    await FirebaseMessaging.instance.getInitialMessage();
    debugPrint("Messege Received Background ===> "+message.toString());
    if (message != null) _notificationsBackground(message);
  }

  Future fcmOnResumeListeners() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _notificationsBackground(message);
    });
  }

  void _notificationsBackground(RemoteMessage message) {
    if (message.data.isEmpty) {
      _newMessageNotification(message);
    }
  }


  Future<void> setDeviceToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    debugPrint("FCM Token ====>>> $token");
    SharedPref sharedPref =  Get.put(SharedPrefImpl());
    await sharedPref.setFCMToken(token??"");
    /*Get.find<AuthService>().user.value.deviceToken =
        await FirebaseMessaging.instance.getToken();*/
  }


  void _newMessageNotification(RemoteMessage message) {
    RemoteNotification notification = message.notification!;
    createNotification(notificationType: "Generic",title: message.notification?.title??"",message: message.notification?.body??"");

    /*if (Get.find<MessagesController>().initialized) {
      Get.find<MessagesController>().refreshMessages();
    }
    if (Get.currentRoute != Routes.CHAT) {
      Get.showSnackbar(Ui.notificationSnackBar(
        title: notification.title!,
        message: notification.body,
        mainButton: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          width: 42,
          height: 42,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(42)),
            child: AdvanceCacheImage(
              width: double.infinity,
              fit: BoxFit.cover,
              imageUrl: message.data != null && message.data['icon'] != null
                  ? message.data['icon']
                  : "",
              placeholder: (context, url) => Image.asset(
                'assets/img/loading.gif',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              errorWidget: (context, url, error) => Icon(Icons.error_outline),
            ),
          ),
        ),
        onTap: (getBar) async {
          if (message.data['messageId'] != null) {
            Get.back();
            Get.find<RootController>().changePage(2);
          }
        },
      ));
    }*/
  }


  static createNotification({required String notificationType,required String title, required String message}) async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: true,
      sound: true,
    );
    /*Creating channel for notifications*/
    const AndroidNotificationChannel channel =
    AndroidNotificationChannel('squch_driver', 'squch_driver_channel',
      description: 'quch_driver_notification_channel',
      importance: Importance.high,
      showBadge: true,
      enableVibration: true,
      playSound: true,
    );


    /*Creating notifications details for local notifications*/


    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'squch_driver',
      'squch_driver_channel',
      channelDescription: 'squch_driver_notification_channel',
      importance: Importance.max, // set the importance of the notification
      priority: Priority.high,
      enableVibration: true,
      icon: "@mipmap/ic_launcher",
      // set prority
    );
    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    if(Platform.isAndroid) {
      var platform = NotificationDetails(android: androidPlatformChannelSpecifics,iOS: iOSPlatformChannelSpecifics);

      flutterLocalNotificationsPlugin.show(
          1,
          title,
          message,
          platform);
    }


  }
}
