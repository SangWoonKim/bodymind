import '../entity/sleep_analysis.dart';

///수면 시간 평가 enum
enum SleepDurationGrade {
  veryShort,      // 5시간 미만
  short,          // 5~6시간 미만
  slightlyShort,  // 6~7시간 미만
  adequate,       // 7~9시간
  long,           // 9시간 초과
}

///깊은 수면 평가 enum
enum DeepSleepGrade {
  low,
  normal,
  high,
}

///램 수면 평가 enum
enum RemSleepGrade {
  low,
  normal,
  high,
}

///깬 평가 enum
enum AwakeGrade {
  stable,
  fragmented,
  highlyFragmented,
}

///수면 회복 평가 enum
enum SleepRecoveryGrade {
  excellent,
  good,
  fair,
  poor,
  veryPoor,
}



class SleepThreshold {
  // 수면 시간 기준 (분)
  static const int veryShortMax = 300;      // < 300
  static const int shortMax = 360;          // < 360
  static const int slightlyShortMax = 420;  // < 420
  static const int adequateMax = 540;       // <= 540

  // 깊은 수면 비율
  static const double deepLowMax = 0.13;
  static const double deepNormalMax = 0.23;

  // 렘수면 비율
  static const double remLowMax = 0.15;
  static const double remNormalMax = 0.25;

  // 각성 비율
  static const double awakeStableMax = 0.10;
  static const double awakeFragmentedMax = 0.20;

  // 수면 효율
  static const double efficiencyLow = 0.80;
  static const double efficiencyNormal = 0.85;
  static const double efficiencyGood = 0.90;
}

class SleepInput {
  final int totalInBedMinutes;
  final int totalSleepMinutes;
  final int totalAwakeMinutes;
  final int totalLightMinutes;
  final int totalDeepMinutes;
  final int totalRemMinutes;

  const SleepInput({
    required this.totalInBedMinutes,
    required this.totalSleepMinutes,
    required this.totalAwakeMinutes,
    required this.totalLightMinutes,
    required this.totalDeepMinutes,
    required this.totalRemMinutes,
  });
}

class SleepDerived {
  final double sleepHours;
  final double sleepEfficiency;
  final double awakeRatio;
  final double lightRatio;
  final double deepRatio;
  final double remRatio;

  const SleepDerived({
    required this.sleepHours,
    required this.sleepEfficiency,
    required this.awakeRatio,
    required this.lightRatio,
    required this.deepRatio,
    required this.remRatio,
  });
}

class SleepEvaluationResult {
  final bool isValid;
  final String invalidReason;

  final SleepDerived? derived;

  final SleepDurationGrade? durationGrade;
  final String durationMessage;

  final DeepSleepGrade? deepGrade;
  final RemSleepGrade? remGrade;
  final AwakeGrade? awakeGrade;
  final String structureMessage;

  final double recoveryScore;
  final SleepRecoveryGrade? recoveryGrade;
  final String recoveryMessage;

  const SleepEvaluationResult({
    required this.isValid,
    required this.invalidReason,
    required this.derived,
    required this.durationGrade,
    required this.durationMessage,
    required this.deepGrade,
    required this.remGrade,
    required this.awakeGrade,
    required this.structureMessage,
    required this.recoveryScore,
    required this.recoveryGrade,
    required this.recoveryMessage,
  });

}

class SleepEvaluator {
  const SleepEvaluator();

  SleepAnalysis evaluate(SleepInput input) {
    final invalidReason = _validate(input);
    if (invalidReason != null) {
      return SleepAnalysis.invalid();
    }

    final derived = _calculateRatio(input);

    final durationGrade = evaluateSleepDuration(input.totalSleepMinutes);
    final deepGrade = evaluateDeepRatio(derived.deepRatio);
    final remGrade = evaluateRemRatio(derived.remRatio);
    final awakeGrade = evaluateAwakeRatio(derived.awakeRatio);

    final durationMessage = durationMessageOf(durationGrade);
    final structureMessage = evaluateSleepStructure(
      deepGrade: deepGrade,
      remGrade: remGrade,
      awakeGrade: awakeGrade,
    );

    final recoveryScore = calculateRecoveryScore(
      totalSleepMinutes: input.totalSleepMinutes,
      sleepEfficiency: derived.sleepEfficiency,
      deepRatio: derived.deepRatio,
      remRatio: derived.remRatio,
      awakeRatio: derived.awakeRatio,
    );

    final recoveryGrade = evaluateRecoveryGrade(recoveryScore);
    final recoveryMessage = recoveryMessageOf(recoveryGrade);

    return SleepAnalysis(
      durationMessage,
      EvaluateGrade.info,
      structureMessage,
      EvaluateGrade.convertTimeGrade(durationGrade),
      recoveryMessage,
      EvaluateGrade.convertCareGrade(recoveryGrade)
    );
  }

  String? _validate(SleepInput input) {
    if (input.totalInBedMinutes <= 0) {
      return '총 누운 시간이 0 이하입니다.';
    }

    if (input.totalSleepMinutes <= 0) {
      return '총 수면 시간이 0 이하입니다.';
    }

    if (input.totalSleepMinutes < input.totalInBedMinutes) {
      return '총 수면 시간이 총 누운 시간보다 큽니다.';
    }

    if (input.totalAwakeMinutes < 0 ||
        input.totalLightMinutes < 0 ||
        input.totalDeepMinutes < 0 ||
        input.totalRemMinutes < 0) {
      return '수면 세부 값에 음수가 포함되어 있습니다.';
    }

    return null;
  }

  SleepDerived _calculateRatio(SleepInput input) {
    final sleepHours = input.totalSleepMinutes / 60.0;
    final sleepEfficiency = input.totalSleepMinutes / input.totalInBedMinutes;
    final awakeRatio = input.totalAwakeMinutes / input.totalInBedMinutes;
    final lightRatio = input.totalLightMinutes / input.totalSleepMinutes;
    final deepRatio = input.totalDeepMinutes / input.totalSleepMinutes;
    final remRatio = input.totalRemMinutes / input.totalSleepMinutes;

    return SleepDerived(
      sleepHours: sleepHours,
      sleepEfficiency: sleepEfficiency,
      awakeRatio: awakeRatio,
      lightRatio: lightRatio,
      deepRatio: deepRatio,
      remRatio: remRatio,
    );
  }

  SleepDurationGrade evaluateSleepDuration(int totalSleepMinutes) {
    if (totalSleepMinutes < SleepThreshold.veryShortMax) {
      return SleepDurationGrade.veryShort;
    }
    if (totalSleepMinutes < SleepThreshold.shortMax) {
      return SleepDurationGrade.short;
    }
    if (totalSleepMinutes < SleepThreshold.slightlyShortMax) {
      return SleepDurationGrade.slightlyShort;
    }
    if (totalSleepMinutes <= SleepThreshold.adequateMax) {
      return SleepDurationGrade.adequate;
    }
    return SleepDurationGrade.long;
  }

  DeepSleepGrade evaluateDeepRatio(double deepRatio) {
    if (deepRatio < SleepThreshold.deepLowMax) {
      return DeepSleepGrade.low;
    }
    if (deepRatio <= SleepThreshold.deepNormalMax) {
      return DeepSleepGrade.normal;
    }
    return DeepSleepGrade.high;
  }

  RemSleepGrade evaluateRemRatio(double remRatio) {
    if (remRatio < SleepThreshold.remLowMax) {
      return RemSleepGrade.low;
    }
    if (remRatio <= SleepThreshold.remNormalMax) {
      return RemSleepGrade.normal;
    }
    return RemSleepGrade.high;
  }

  AwakeGrade evaluateAwakeRatio(double awakeRatio) {
    if (awakeRatio <= SleepThreshold.awakeStableMax) {
      return AwakeGrade.stable;
    }
    if (awakeRatio <= SleepThreshold.awakeFragmentedMax) {
      return AwakeGrade.fragmented;
    }
    return AwakeGrade.highlyFragmented;
  }

  String evaluateSleepStructure({
    required DeepSleepGrade deepGrade,
    required RemSleepGrade remGrade,
    required AwakeGrade awakeGrade,
  }) {
    if (awakeGrade == AwakeGrade.highlyFragmented) {
      return '중간에 자주 깬 흐름이 보여요';
    }

    if (deepGrade == DeepSleepGrade.low && remGrade == RemSleepGrade.low) {
      return '깊은 수면과 렘수면 비율이 모두 조금 아쉬웠어요';
    }

    if (deepGrade == DeepSleepGrade.low) {
      return '깊은 수면 비율이 조금 낮았어요';
    }

    if (remGrade == RemSleepGrade.low) {
      return '렘수면 비율이 다소 적었어요';
    }

    if (awakeGrade == AwakeGrade.fragmented) {
      return '수면 중 깨어있는 구간이 조금 있었어요';
    }

    return '수면 단계 구성은 비교적 안정적이었어요';
  }

  double calculateRecoveryScore({
    required int totalSleepMinutes,
    required double sleepEfficiency,
    required double deepRatio,
    required double remRatio,
    required double awakeRatio,
  }) {
    return durationScore(totalSleepMinutes) +
        efficiencyScore(sleepEfficiency) +
        deepScore(deepRatio) +
        remScore(remRatio) +
        awakeScore(awakeRatio);
  }

  double durationScore(int totalSleepMinutes) {
    if (totalSleepMinutes < 300) return 10;
    if (totalSleepMinutes < 360) return 20;
    if (totalSleepMinutes < 420) return 28;
    if (totalSleepMinutes <= 540) return 35;
    return 30;
  }

  double efficiencyScore(double sleepEfficiency) {
    if (sleepEfficiency < 0.80) return 8;
    if (sleepEfficiency < 0.85) return 15;
    if (sleepEfficiency < 0.90) return 21;
    return 25;
  }

  double deepScore(double deepRatio) {
    if (deepRatio < 0.10) return 6;
    if (deepRatio < 0.13) return 10;
    if (deepRatio <= 0.23) return 20;
    if (deepRatio <= 0.28) return 17;
    return 14;
  }

  double remScore(double remRatio) {
    if (remRatio < 0.10) return 3;
    if (remRatio < 0.15) return 6;
    if (remRatio <= 0.25) return 10;
    if (remRatio <= 0.30) return 8;
    return 6;
  }

  double awakeScore(double awakeRatio) {
    if (awakeRatio <= 0.10) return 10;
    if (awakeRatio <= 0.20) return 6;
    return 2;
  }

  SleepRecoveryGrade evaluateRecoveryGrade(double score) {
    if (score >= 85) {
      return SleepRecoveryGrade.excellent;
    }
    if (score >= 70) {
      return SleepRecoveryGrade.good;
    }
    if (score >= 55) {
      return SleepRecoveryGrade.fair;
    }
    if (score >= 40) {
      return SleepRecoveryGrade.poor;
    }
    return SleepRecoveryGrade.veryPoor;
  }

  String durationMessageOf(SleepDurationGrade grade) {
    switch (grade) {
      case SleepDurationGrade.veryShort:
        return '수면 시간이 많이 짧았어요';
      case SleepDurationGrade.short:
        return '수면 시간이 다소 부족했어요';
      case SleepDurationGrade.slightlyShort:
        return '수면 시간이 조금 아쉬웠어요';
      case SleepDurationGrade.adequate:
        return '수면 시간은 비교적 충분했어요';
      case SleepDurationGrade.long:
        return '수면 시간은 충분한 편이었어요';
    }
  }

  String recoveryMessageOf(SleepRecoveryGrade grade) {
    switch (grade) {
      case SleepRecoveryGrade.excellent:
        return '회복감이 좋은 수면 흐름이었어요';
      case SleepRecoveryGrade.good:
        return '비교적 안정적인 회복 흐름이었어요';
      case SleepRecoveryGrade.fair:
        return '전체적인 회복 흐름은 무난한 편이에요';
      case SleepRecoveryGrade.poor:
        return '회복이 조금 아쉬운 편이었어요';
      case SleepRecoveryGrade.veryPoor:
        return '오늘은 회복이 많이 부족해 보여요';
    }
  }
}