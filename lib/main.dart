import 'package:flutter/material.dart';
import 'app/my_app.dart';
import 'app/services/dio_helper/dio_helper.dart';
import 'app/services/shared_prefrences/cache_helper.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();

  runApp(
    MyApp(),
  );
}
