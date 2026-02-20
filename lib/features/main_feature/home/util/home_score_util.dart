import 'dart:math' as math;
class HomeScoreUtil {

  double _clamp(double x, double lo, double hi) =>
      x < lo ? lo : (x > hi ? hi : x);

  double _clamp01(double x) => _clamp(x, 0, 1);

  double bmrMifflin({
    required bool isMale,
    required double weightKg,
    required double heightCm,
    required int age,
  }) {
    final base = 10 * weightKg + 6.25 * heightCm - 5 * age;
    return isMale ? base + 5 : base - 161;
  }


  /// 활동 점수 산출 알고리즘
  int activityScoreUpToNow({
    required int hour,
    required int min,
    required int steps,
    required double distance,
    required double weight,
    required double height,
    required int age,
    required bool isMale,

    double afTarget = 1.7, //활동계수(1.2, 1.375, 1.55, 1.725, 1.9)
    //점수 부여 가중치
    double wCal = 0.50,
    double wSteps = 0.35,
    double wDist = 0.15,
  }) {
    // 1) fraction (오늘 경과 비율)
    final minutes = hour * 60 + min;
    final fraction = _clamp(minutes / 1440.0, 0.0, 1.0);

    // 너무 이른 시간은(ex: 00:05) 분모가 작아 ratio 비정상일 것을 감안하여 평준화
    final safeFraction = math.max(fraction, 0.05); // 5% 미만이면 5%로 처리

    // 2) BMR, 목표(TDEE)
    final bmr = bmrMifflin(
      isMale: isMale,
      weightKg: weight,
      heightCm: height,
      age: age,
    );

    //하루 목표 총소모 칼로리 산출
    final tdeeGoalDay = bmr * afTarget;
    //호출한 시점의 시간까지의 총소모 목표 기준 값
    final tdeeGoalSoFar = tdeeGoalDay * safeFraction;

    // 3) steps/dist 목표 (활동분을 BMR*(AF-1)로 잡고 파생)

    //bmr에서 활동 칼로리만 추출
    final activityGoalDay = bmr * (afTarget - 1.0);
    //칼로리를 통한 목표 걸음으로 변환한 기준 값
    final stepsGoalDay = (_clamp(activityGoalDay / 0.04, 6000, 14000)).round();

    final heightM = height / 100.0;
    //보폭 산출 (M)
    final strideM = heightM * (isMale ? 0.415 : 0.413);
    // 걸음수와 보폭을 통한 거리 목표 기준값
    final distGoalDayKm = stepsGoalDay * strideM / 1000.0;

    //걸음수와 거리를 호출한 시점의 시간까지의 목표 값으로 산출
    final stepsGoalSoFar = stepsGoalDay * safeFraction;
    final distGoalSoFar = distGoalDayKm * safeFraction;

    // 4) TDEE_est_so_far (시간이 없으므로 거리로 시간 추정, 걷기 가정)
    final bmrSoFar = bmr * safeFraction;

    // 걷기: 5km/h, MET 3.8 (필요하면 stride로 달리기 분기 추가 가능)
    final hoursWalk = distance / 5.0;
    final activityKcalSoFar = 3.8 * weight * hoursWalk;

    final tdeeEstSoFar = bmrSoFar + activityKcalSoFar;

    // 5) ratio
    final rCal = tdeeEstSoFar / math.max(tdeeGoalSoFar, 1.0);
    final rSteps = steps / math.max(stepsGoalSoFar, 1.0);
    final rDist = distance / math.max(distGoalSoFar, 0.01);

    double p(double r) => math.sqrt(_clamp01(r)); // 0~1로 clamp 후 sqrt

    final raw = wCal * p(rCal) + wSteps * p(rSteps) + wDist * p(rDist);
    return (raw * 100).round().clamp(0, 100);
  }

  String actEvaluationStr(int score){
    switch(score){
      case 0:
        return '데이터가 없습니다.';
      case >=1 && <= 25:
        return '활동을 안하셨군요';
      case >= 26 && <= 50:
        return '활동이 필요합니다.';
      case >= 51 && <= 75:
        return '조금 더 해볼까요?';
      case >= 75 :
        return '좋은 하루를 보내셨네요';
    }
    return '데이터가 없습니다.';
  }
}
