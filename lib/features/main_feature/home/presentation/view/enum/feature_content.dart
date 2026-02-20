import 'package:flutter/material.dart';

enum FeatureContent {
  act('assets/images/icon/act_icon.svg', '활동',[Color(0xffDBEAFE), Color(0xffEFF6FF)], Color(0xff2563EB), Color(0xff3B82F6)),
  heart('assets/images/icon/heart_icon.svg', '심박',[Color(0xffFEE2E2), Color(0xffFEF2F2)], Color(0xffDC2626), Color(0xffEF4444)),
  sleep('assets/images/icon/sleep_icon.svg', '수면',[Color(0xffF3E8FF), Color(0xffFAF5FF)], Color(0xff9333EA), Color(0xffA855F7)),
  exercise('assets/images/icon/exercise_icon.svg', '운동',[Color(0xffDCFCE7), Color(0xffF0FDF4)], Color(0xff16A34A), Color(0xff22C55E)),;

  final String svgPath;
  final String featureName;
  final List<Color> background;
  final Color textColor;
  final Color iconColor;

  const FeatureContent(
     this.svgPath,
     this.featureName,
     this.background,
     this.textColor,
      this.iconColor
  );
}