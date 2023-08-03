import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';

ThemeData getAppTheme() {
  return ThemeData(
    // main color

    // primarySwatch: MaterialColor(),
    primaryColor: ColorManager.darkBlue,
    scaffoldBackgroundColor: ColorManager.white,
    //text theme
    textTheme: TextTheme(
      headlineLarge: getMediumStyle(
        fontSize: FontSizeManager.s22.sp,
        color: ColorManager.darkBlue,
      ),
      headlineSmall: getRegularStyle(
        fontSize: FontSizeManager.s18.sp,
        color: ColorManager.darkGrey,
      ),
      headlineMedium: getMediumStyle(
        fontSize: FontSizeManager.s22.sp,
        color: ColorManager.white,
      ),
      bodySmall: getRegularStyle(
        fontSize: FontSizeManager.s16.sp,
        color: ColorManager.darkGrey.withOpacity(
          .5,
        ),
      ),
      bodyMedium: getMediumStyle(
        fontSize: FontSizeManager.s18.sp,
        color: ColorManager.darkBlue,
      ),
      bodyLarge: getBoldStyle(
        fontSize: FontSizeManager.s16.sp,
        color: ColorManager.darkBlue,
      ),
      displayMedium: getMediumStyle(
        fontSize: FontSizeManager.s18.sp,
        color: ColorManager.black,
      ),
    ),
  );
}
