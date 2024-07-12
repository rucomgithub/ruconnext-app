import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Noti {
  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var andriodInitialize =
        new AndroidInitializationSettings('mipmap/ic_launcher');
    var iOSInitialize = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: andriodInitialize, iOS: iOSInitialize);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future showTodayNotification(
      {var id = 0,
      required String title,
      required String body,
      var payload,
      required FlutterLocalNotificationsPlugin fln}) async {
    AndroidNotificationDetails androidNotificationDetails =
        new AndroidNotificationDetails(
      'today_notification',
      'today',
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );
    var not = NotificationDetails(
        android: androidNotificationDetails, iOS: IOSNotificationDetails());
    await fln.show(0, title, body, not);
  }
}
