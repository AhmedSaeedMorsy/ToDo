import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:to_do/app/resources/color_manager.dart';
import 'package:to_do/app/resources/values_manager.dart';

import '../resources/font_manager.dart';

class SharedWidget {
  static Widget defualtTextFormField(
      {required TextEditingController controller,
      required TextInputType keyboardType,
      required String hintText,
      required BuildContext context,
      required String? Function(String?)? validator}) {
    return TextFormField(
      validator: validator,
      controller: controller,
      style: Theme.of(context).textTheme.headlineSmall,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppSize.s16,
          ),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppSize.s16,
          ),
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodySmall,
        filled: true,
        fillColor: ColorManager.grey,
      ),
    );
  }

  static Widget defualtButton({
    required String label,
    required void Function() onPressed,
    required BuildContext context,
  }) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(
          AppSize.s26,
        ),
        gradient: LinearGradient(
          colors: [
            ColorManager.blue.withOpacity(
              .7,
            ),
            ColorManager.mintGreen.withOpacity(
              .7,
            )
          ],
        ),
      ),
      child: MaterialButton(
        height: AppSize.s60.h,
        onPressed: onPressed,
        child: Text(
          label,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }

  static toast({required String message, required Color backgroundColor}) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: ColorManager.white,
      fontSize: FontSizeManager.s14.sp,
    );
  }
}
