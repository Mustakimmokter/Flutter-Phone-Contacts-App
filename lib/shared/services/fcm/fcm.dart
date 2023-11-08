import 'dart:convert';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FCMNotification {

  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static int _notificationId = 0;

  // Notification permission request
  static Future<void> requestSettingPermission()async{

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print('User granted permission');
    }else if(settings.authorizationStatus == AuthorizationStatus.provisional){
      print('User granted provisional permission');
    }else{
      //AppSettings.openNotificationSettings();
      print('User denied permission');
    }
  }

  // Initialize notifications
  static Future<void> initialNotificationMessage()async{
    // Foreground Notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if(message.notification != null){
        _showLocalNotification(message);
        print(message.notification!.body);
      }
    });


    // Background Notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if(message.notification != null){
        print('Notification..............${message.data}');
        print('Notification..............${message.notification!.body}');
      }
    });

    //Terminated  Notification
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message){
      if(message != null){
        print('Notification..............${message.data}');
      }

    });
  }

 static Future<void> initLocalNotification()async {
    const androidInitializationSettings =  AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInitializationSettings =  DarwinInitializationSettings();

    const initializationSettings = InitializationSettings(android: androidInitializationSettings,iOS: iosInitializationSettings);

    await _localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {
        _onSelectedNotification(payload);
      },

    );

  }

  static Future<String> getDeviceToken()async => await _messaging.getToken(vapidKey: "BGpdLRs......") ?? '';

  static Future<void> refreshToken()async => _messaging.onTokenRefresh.listen((event) {
    print(event);
  });


  // Show Local Notification
  static Future<void> _showLocalNotification(RemoteMessage payload)async{
    final AndroidNotificationChannel notificationChannel = AndroidNotificationChannel(
        Random.secure().nextInt(1000).toString(),
        'High important notification'
    );
    final AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      notificationChannel.id,
      notificationChannel.name,
      channelDescription: 'Chanel Description',
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      autoCancel: true,
    );
    const DarwinNotificationDetails iosNotificationDetails = DarwinNotificationDetails(presentSound: false);

    final notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );

    _localNotificationsPlugin.show(
      _notificationId,
      payload.notification!.title,
      payload.notification!.body,
      notificationDetails,
      payload: jsonEncode(payload.data),
    );
    _notificationId++;


  }
  //When app running onscreen notification click call here
  static Future<void> _onSelectedNotification(NotificationResponse payload)async{
    Map<String,dynamic> data = jsonDecode(payload.payload!);
    print("____________${data['title']}______________");
    print(payload.payload);
    //Navigator.push(context, MaterialPageRoute(builder: (_)=>NotificationsScreen(notificationTitle: data['title'], notificationBody: data['body'])));
  }



  /// Configuration
/// Add this meta data in AndroidManifest.xml in application
//<!--This meta data for remote FCM-->
//         <meta-data
//             android:name="firebase_messaging_auto_init_enabled"
//             android:value="false" />
//         <!--Also this meta data for remote FCM-->
//         <meta-data
//             android:name="firebase_analytics_collection_enabled"
//             android:value="false" />
//         <!--Also this meta data for remote FCM-->
//         <meta-data
//             android:name="com.google.firebase.messaging.default_notification_channel_id"
//             android:value="high_importance_channel" />
/// Add this two line in activity
//android:showWhenLocked="true"
//android:turnScreenOn="true"


}