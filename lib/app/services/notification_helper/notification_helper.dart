// ignore_for_file: deprecated_member_use, depend_on_referenced_packages

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  initializeNotification() async {
    configureLocalTimezone();
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings("ic_launcher");

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  scheduledNotification({
    required int hours,
    required int minutes,
    required Map task,
  }) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      task["id"],
      task["title"],
      task["description"],
      converTime(
        hours: hours,
        minutes: minutes,
      ),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'your channel id',
          'your channel name',
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  tz.TZDateTime converTime({required int hours, required int minutes}) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime schedualeDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hours, minutes);
    if (schedualeDate.isBefore(now)) {
      schedualeDate = schedualeDate.add(const Duration(days: 1));
    }
    return schedualeDate;
  }

  Future<void> configureLocalTimezone() async {
    tz.initializeTimeZones();
    final String timezone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timezone));
  }
}
