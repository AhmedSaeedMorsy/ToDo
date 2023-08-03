// ignore_for_file: prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do/app/services/shared_prefrences/cache_helper.dart';

import 'resources/routes_manager.dart';
import 'resources/theme_manager.dart';

class MyApp extends StatefulWidget {
  MyApp._internal();

  static final MyApp _instance = MyApp._internal();

  factory MyApp() => _instance;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: "To Do List",
          debugShowCheckedModeBanner: false,
          theme: getAppTheme(),
          initialRoute: CacheHelper.getData(key: SharedKey.token) == null
              ? Routes.loginRoute
              : Routes.homeRoute,
          onGenerateRoute: RouteGenerator.getRoute,
        );
      },
    );
  }
}
