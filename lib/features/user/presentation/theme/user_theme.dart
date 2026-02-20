import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../const/theme/global_theme.dart';

class UserTheme{
  static TextStyle get titleCustomText => CustomTextStyle(
      fontWeight: FontWeight.w500,
      letterSpacing: -0.5.sp,
      fontSize: 14.sp,
      lineHeight: 14.sp
  );

  static TextStyle get captionCustomText => CustomTextStyle(
      fontWeight: FontWeight.w500,
      letterSpacing: -0.5.sp,
      fontSize: 12.sp,
      lineHeight: 16.sp
  );
}