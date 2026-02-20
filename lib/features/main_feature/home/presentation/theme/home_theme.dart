

import 'package:bodymind/const/theme/global_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTheme {
  static TextStyle get titleTextStyle => CustomTextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp, lineHeight: 24.sp, letterSpacing: -0.5.sp);

  static TextStyle get evaluationTextStyle => CustomTextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp, lineHeight: 28.sp, letterSpacing: -0.5.sp);

  static TextStyle get leadingTextStyle => CustomTextStyle(fontWeight: FontWeight.w500, fontSize: 12.sp, lineHeight: 12.sp, letterSpacing: -0.5.sp);

  static TextStyle get infoTextStyle => CustomTextStyle(fontWeight: FontWeight.w500, fontSize: 12.sp, lineHeight: 16.sp, letterSpacing: -0.5.sp);

  static TextStyle get featureScoreTextStyle => CustomTextStyle(fontWeight: FontWeight.w500, fontSize: 24.sp, lineHeight: 32.sp, letterSpacing: -0.5.sp);

  static TextStyle get mainScoreTextStyle => CustomTextStyle(fontWeight: FontWeight.w700, fontSize: 36.sp, lineHeight: 40.sp, letterSpacing: -0.5.sp);

  static TextStyle get suggestTextStyle => CustomTextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, lineHeight: 14.sp, letterSpacing: -0.5.sp);
}