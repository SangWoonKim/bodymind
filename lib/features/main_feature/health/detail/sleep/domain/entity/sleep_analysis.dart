import 'dart:ui';

import 'package:bodymind/features/main_feature/health/detail/sleep/domain/util/sleep_analyze_util.dart';

class SleepAnalysis {
  final String sleepTimeAnalysis;
  final EvaluateGrade sleepTimeGrade;
  final String sleepRatioAnalysis;
  final EvaluateGrade sleepRatioGrade;
  final String sleepCareAnalysis;
  final EvaluateGrade sleepCareGrade;

  SleepAnalysis(
      this.sleepTimeAnalysis,
      this.sleepTimeGrade,
      this.sleepRatioAnalysis,
      this.sleepRatioGrade,
      this.sleepCareAnalysis,
      this.sleepCareGrade
      );


  factory SleepAnalysis.invalid() {
    return SleepAnalysis(
      '수면 데이터를 충분히 확인하지 못했어요',
      EvaluateGrade.info,
      '기록이 일부 부족해 정확한 해석이 어려워요',
      EvaluateGrade.warning,
      '수면 기록이 존재하지 않아요',
      EvaluateGrade.warning,
    );
  }
}

enum EvaluateGrade{
  good(Color(0xff22c55e),'assets/images/icon/sleep_good.svg',Color(0xfff0fdf4)),
  caution(Color(0xfff97316),'assets/images/icon/sleep_caution.svg',Color(0xfffff7ed)),
  warning(Color(0xffC53822),'assets/images/icon/sleep_warning.svg',Color(0xffFFEDEA)),
  info(Color(0xff3b82f6),'assets/images/icon/sleep_info.svg',Color(0xffeff6ff));

  final Color iconColor;
  final String iconPath;
  final Color backGroundColor;


  const EvaluateGrade(this.iconColor,this.iconPath,this.backGroundColor);

  static EvaluateGrade convertTimeGrade(SleepDurationGrade grade){
    return switch(grade){
      SleepDurationGrade.veryShort => .warning,
      SleepDurationGrade.short => .caution,
      SleepDurationGrade.slightlyShort => .caution,
      SleepDurationGrade.adequate => .good,
      SleepDurationGrade.long => .good,
    };
  }

  static EvaluateGrade convertCareGrade(SleepRecoveryGrade grade){
    return switch(grade){
      SleepRecoveryGrade.excellent => .good,
      SleepRecoveryGrade.good => .good,
      SleepRecoveryGrade.fair => .caution,
      SleepRecoveryGrade.poor => .caution,
      SleepRecoveryGrade.veryPoor => .warning,
    };
  }

}