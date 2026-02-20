import 'package:bodymind/const/theme/global_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardTheme {
  static TextStyle get titleText => CustomTextStyle(fontWeight: FontWeight.w700, fontSize: 24.sp, lineHeight: 30.sp, letterSpacing: -0.5.sp);
  static TextStyle get bodyText => CustomTextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp, lineHeight: 26.sp, letterSpacing: -0.5.sp);
  static TextStyle get captionText => CustomTextStyle(fontWeight: FontWeight.w400, fontSize: 12.sp, lineHeight: 16.sp, letterSpacing: -0.5.sp);
}