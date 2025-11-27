import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

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

    tz.initializeTimeZones();
    final TimezoneInfo currentTimeZone = await FlutterTimezone.getLocalTimezone();
    final String location = currentTimeZone.identifier;
    tz.setLocalLocation(tz.getLocation(location));

    const initSettings = AndroidInitializationSettings('notification_icon');

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

  //Schedule Notifications
  Future<void> scheduleNotifications({
    int id = 1,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    final now = tz.TZDateTime.now(tz.local);

    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    await notifications.zonedSchedule(
      id, 
      title, 
      body, 
      scheduledDate, 
      notificationDetails(), 
      uiLocalNotificationDateInterpretation: 
        UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  //Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await notifications.cancelAll();
  }
}