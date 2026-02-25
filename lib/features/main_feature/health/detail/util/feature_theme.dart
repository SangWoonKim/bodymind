import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../const/theme/global_theme.dart';

class FeatureTheme {
  static TextStyle get hrScoreText => CustomTextStyle(fontWeight: FontWeight.w500, fontSize: 24.sp, lineHeight: 24.sp, letterSpacing: -0.5.sp);
  static TextStyle get hrMdText => CustomTextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp, lineHeight: 28.sp, letterSpacing: -0.5.sp);
  static TextStyle get actMainScoreText => CustomTextStyle(fontWeight: FontWeight.w700, fontSize: 48.sp, lineHeight: 48.sp, letterSpacing: -0.5.sp);
}