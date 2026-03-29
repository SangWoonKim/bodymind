import 'package:bodymind/features/main_feature/health/detail/sleep/domain/entity/sleep_analysis.dart';

import '../util/sleep_analyze_util.dart';
class SleepAnalysisInjector {
  static SleepAnalysis evaluateSleep({
    required int totalInBedMinutes,
    required int totalSleepMinutes,
    required int totalAwakeMinutes,
    required int totalLightMinutes,
    required int totalDeepMinutes,
    required int totalRemMinutes,
  }) {
    final evaluator = SleepEvaluator();

    return evaluator.evaluate(
      SleepInput(
        totalInBedMinutes: totalInBedMinutes,
        totalSleepMinutes: totalSleepMinutes,
        totalAwakeMinutes: totalAwakeMinutes,
        totalLightMinutes: totalLightMinutes,
        totalDeepMinutes: totalDeepMinutes,
        totalRemMinutes: totalRemMinutes,
      ),
    );
  }
}
