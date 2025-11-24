import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'user.dart';

class NotificationManager {
  final notifications = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  bool getInitalized() {
    return _isInitialized;
  }

  //Initialize
  Future<void> initNotification() async {
    if(_isInitialized) {
      return;
    }

    const initSettings = AndroidInitializationSettings('@mipmap/app_icon');

    const init = InitializationSettings(
      android: initSettings,
    );

    _isInitialized = true;
    await notifications.initialize(init);
  }

  //Notifications Setup
  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_channel_id', 
        'Daily Notifications',
        channelDescription: 'Daily Notification Channel',
        importance: Importance.max,
        priority: Priority.high,
    ));
  }

  //Show Notifications
  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    return notifications.show(id, title, body, notificationDetails(),);
  }
}