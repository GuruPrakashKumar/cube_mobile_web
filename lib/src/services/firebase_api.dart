import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
 Future<void> handleBackgroundMessage(RemoteMessage message)async
 {
  if(kDebugMode)print('Title:${message.notification?.title}' );
  if(kDebugMode)print('body: ${message.notification?.body}');
 }


class FirebaseApi
{
  final _firebaseMessaging=FirebaseMessaging.instance;

  Future<void> initNotifications()async
  {
    await _firebaseMessaging.requestPermission();
    final fCMTocken=await  _firebaseMessaging.getToken();
    if(kDebugMode)print("Tocken: $fCMTocken");
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}