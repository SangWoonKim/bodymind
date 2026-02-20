import 'package:bodymind/core/util/fourth.dart';

import '../../../../../../core/storage/feature_model/feature_data/sleep/feature_sleep.dart';
import '../../../domain/entity/feature_entity.dart';
import '../home_viewmodel.dart';

class HomeSleepInjector {
  double clamp(double x, double lo, double hi) =>
      x < lo ? lo : (x > hi ? hi : x);
  double clamp01(double x) => clamp(x, 0, 1);

  int _sleepScore({
    required int lightMin,
    required int remMin,
    required int deepMin,
    required int awakeMin,

    // 튜닝 파라미터
    double deepAbsTargetMin = 90,   // Deep 90분이면 만점
    double deepRatioTarget = 0.18,  // Deep 18%면 만점
    double remRatioTarget  = 0.20,  // REM 20%면 만점
    double awakeRatioBad   = 0.10,  // 깸 비율 10%면 0점
    double totalTargetMin  = 480,   // 총 수면 7.5h 만점
  }) {
    final totalSleepMin = lightMin + remMin + deepMin;
    final totalInBed = totalSleepMin + awakeMin;

    if (totalInBed <= 0) return 0;

    // 1) duration 권장 수면시간 8시간을 기준으로 작성함(성인, 청소년, 노인 모두 포함)
    final sDur = clamp01(totalSleepMin / totalTargetMin);

    // 2) 전체 수면 퀄리티 비율 산출(중간에 깬시간이 많으면 더 적어짐)
    final awakeRatio = awakeMin / totalInBed;
    final sQual = 1.0 - clamp01(awakeRatio / awakeRatioBad);

    // 3) 수면 유형별 비율 산출
    final deepRatio = deepMin / totalSleepMin;
    final remRatio = remMin / totalSleepMin;

    //deep 수면 비율에 점수 가중치 주입
    final sDeepAbs = clamp01(deepMin / deepAbsTargetMin);
    final sDeepRat = clamp01(deepRatio / deepRatioTarget);
    final sRemRat  = clamp01(remRatio / remRatioTarget);
    final deepCore = 0.6 * sDeepAbs + 0.4 * sDeepRat;

    final sStage = 0.70 * deepCore + 0.30 * sRemRat;


    //수면 유형별 비율 + 권장 수면 시간 비율 + 전체 수면 퀄리티 비율 +
    //점수 0.55:0.15:0.3
    final raw = 0.55 * sStage + 0.15 * sDur + 0.30 * sQual;
    return (raw * 100).round().clamp(0, 100);
  }

  Fourth processingSlp(FeatureEntity receive, DateTime now, DateTime previousDay, HomeViewState state){
    int currentScore = 0;
    int previousScore = 0;
    int weeklyScore = 0;
    int weeklyCnt = 1;

    receive.featureLst?.forEach((featureData){

      final sleepModel = featureData.featureData;
      final sleepData = sleepModel?.feature as FeatureSleep?;

      if(sleepData != null){

        String day = sleepModel!.instDt.substring(6,8);
        final sleepScore = _sleepScore(
            lightMin: sleepData.totalLightM,
            remMin: sleepData.totalRemM,
            deepMin: sleepData.totalDeepM,
            awakeMin: sleepData.totalAwakeM);

        weeklyCnt += 1;

        if(int.parse(day) == now.day){
          currentScore = sleepScore;
        }else if(int.parse(day) == previousDay.day){
          currentScore = sleepScore;
        }
        weeklyScore += sleepScore;
      }

    });

    FeatureInfo feature = state.featureInfo['sleep']!.copyWith(
        score: currentScore
    );

    return Fourth(
        currentScore.round(),
        previousScore.round(),
        (weeklyScore /weeklyCnt).round(),
        state.featureInfo['sleep']!.copyWith(
            score: currentScore)
    );
  }
}
