
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phone_contact_app/shared/models/contact_info.dart';

class BodyProvider extends ChangeNotifier {



  final List<ContactInfo> _contactList = [
    ContactInfo(
        name: 'Saddam',
        number: '01732-237185'
    ),
    ContactInfo(
      name: 'Mishu',
      number: '0184163069',
    ),
    ContactInfo(),
    ContactInfo(),
    ContactInfo(),
    ContactInfo(),
    ContactInfo(),
    ContactInfo(),
    ContactInfo(),
    ContactInfo(),
    ContactInfo(),
    ContactInfo(),
    ContactInfo(),
    ContactInfo(),
    ContactInfo(),
    ContactInfo(),
    ContactInfo(),
    ContactInfo(),
    ContactInfo(),
    ContactInfo(),
    ContactInfo(),
  ];

  List<ContactInfo> get contactList => _contactList;

  void getIsTrue(int index) {
    contactList[index].isSelected = !contactList[index].isSelected;
    notifyListeners();
    print(contactList[index].isSelected);
  }



}


// class Notification {
//
//   final FirebaseMessaging _firebaseMessaging =  FirebaseMessaging.instance;
//   FlutterLocalNotificationsPlugin? _notificationsPlugin;
//   int _notificationId = 0;
//
//   Future<void> getPushNotification()async {
//     await _firebaseMessaging!.setForegroundNotificationPresentationOptions(
//       alert: true, // Required to display a heads up notification
//       badge: true,
//       sound: true,
//     );
//
//     _firebaseMessaging!.getInitialMessage();
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       if (message.notification != null) {
//         print(message);
//         _showNotification(message);
//       }
//     });
//
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       _firebaseMessaging?.unsubscribeFromTopic('100');
//       if (message.notification != null) {
//         print("${message.notification!.title}\n${message.notification!.body}");
//       }
//     });
//
//     FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
//       if(message.notification != null){
//         print(message);
//       }
//     });
//   }
//
//   Future<void> _showNotification(RemoteMessage payload) async {
//     const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
//       'your channel id', 'your channel name',
//       channelDescription: 'your channel description',
//       importance: Importance.max,
//       playSound: true,
//       priority: Priority.high,
//       ticker: 'ticker',
//     );
//     const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
//     await _notificationsPlugin!.show(
//         _notificationId++, payload.notification!.title, payload.notification!.body, notificationDetails,
//         payload: jsonEncode(payload.data));
//     _notificationsPlugin!.show(_notificationId++,payload.notification!.title, payload.notification!.body, notificationDetails);
//
//     _notificationId++;
//   }
//   void initNotification(){
//     _notificationsPlugin = FlutterLocalNotificationsPlugin();
//     const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const iosInit = DarwinInitializationSettings();
//     const initSetting = InitializationSettings(android: androidInit,iOS: iosInit,);
//     _notificationsPlugin!.initialize(initSetting,);
//
//   }
// }