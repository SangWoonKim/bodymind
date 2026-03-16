import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../const/theme/global_theme.dart';

class FeatureTheme {
  static TextStyle get hrScoreText => CustomTextStyle(fontWeight: FontWeight.w500, fontSize: 24.sp, lineHeight: 24.sp, letterSpacing: -0.5.sp);
  static TextStyle get hrMdText => CustomTextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp, lineHeight: 28.sp, letterSpacing: -0.5.sp);
  static TextStyle get actMainScoreText => CustomTextStyle(fontWeight: FontWeight.w700, fontSize: 48.sp, lineHeight: 48.sp, letterSpacing: -0.5.sp);
  static TextStyle get exExplainText => CustomTextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, lineHeight: 20.sp, letterSpacing: -0.5.sp);
  static TextStyle get exExplainDetail => CustomTextStyle(fontWeight: FontWeight.w700, fontSize: 14.sp, lineHeight: 20.sp, letterSpacing: -0.5.sp);
  static TextStyle get exSummaryText => CustomTextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, lineHeight: 17.sp, letterSpacing: -0.5.sp);
}