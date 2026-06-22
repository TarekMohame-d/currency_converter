import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void customSnackBar(
  BuildContext context,
  String message, [
  Duration duration = const Duration(seconds: 2),
]) {
  ScaffoldMessenger.of(context).clearSnackBars();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: duration,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
    ),
  );
}
