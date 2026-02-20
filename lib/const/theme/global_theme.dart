import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final initTheme = ThemeData(
  fontFamily: 'Pretendard',
  useMaterial3: true,
  //정의중 아직 버튼, 앱바, 텍스트, 결정안함
);


class GlobalTheme{
  //앱 배경 공통 색상
  static const Color customWhite2 = Color(0xFFF8F9FB);
  //버튼 공통 배경 색상
  static const Color customBlue = Color(0xFF6B7FD7);
  //버튼 공통 외곽 색상
  static const Color customWhite = Color(0xFFE5E7EB);
  //leading 글씨 공통 스타일
  static TextStyle get leadCustomText => CustomTextStyle(
    fontWeight: FontWeight.w500,
    letterSpacing: -0.5.sp,
    fontSize: 14.sp,
    lineHeight: 20.sp
  );

  static TextStyle get leadCustomText2 => CustomTextStyle(
      fontWeight: FontWeight.w500,
      letterSpacing: -0.5.sp,
      fontSize: 14.sp,
      lineHeight: 23.sp
  );

  //버튼 공통 글씨
  static TextStyle get customText => CustomTextStyle(
    fontWeight: FontWeight.w500,
    letterSpacing: -0.5.sp,
    fontSize: 15.sp,
    lineHeight: 20.sp
  );

  //주제 문구
  static TextStyle get titleCustomText => CustomTextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 20.sp,
      lineHeight: 28.sp,
      letterSpacing: -0.5.sp
  );





}

class CustomTextStyle extends TextStyle{
  const CustomTextStyle({
    required final FontWeight fontWeight,
    required final double fontSize,
    required final double lineHeight,
    required final double letterSpacing,
  }) : super(
      fontFamily: 'Pretendard',
      fontWeight: fontWeight,
      fontSize: fontSize,
      leadingDistribution: TextLeadingDistribution.even,
      height: lineHeight / fontSize,
      letterSpacing: letterSpacing);
}