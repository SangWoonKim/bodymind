import 'dart:math' as math;

import 'package:bodymind/features/main_feature/home/domain/entity/feature_entity.dart';
import 'package:common_mutiple_health/entity/const/exercise_classfiy.dart';

import '../../../../../../core/storage/feature_model/feature_data/exercise/feature_exercise.dart';
import '../../../../../../core/util/fourth.dart';
import '../../../../../user/domain/entity/user_info.dart';
import '../home_viewmodel.dart';

//모든 유형의 카테고리를 챙길수 없기에 큰분류로 나눔 (유산소, 자전거, 근력, 수영)
enum ExerciseType {
  walkRun('runner.svg'),
  cycle('cycle.svg'),
  strength('strength.svg'),
  swim('swim.svg'),
  cadio('cadio.svg');

  final String svgIconPath;
  const ExerciseType(this.svgIconPath);
  static ExerciseType convertClassify(ExerciseClassify classify){
    return switch(classify){

      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeOtherWorkout => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeBadminton => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeBaseball => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeBasketball => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeBiking => .cycle,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeBikingStationary => .cycle,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeBootCamp => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeBoxing => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeCalisthenics => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeCricket => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeDancing => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeElliptical => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeExerciseClass => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeFencing => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeFootballAmerican => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeFootballAustralian => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeFrisbeeDisc => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeGolf => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeGuidedBreathing => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeGymnastics => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeHandball => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeHighIntensityIntervalTraining => .strength,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeHiking => .walkRun,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeIceHockey => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeIceSkating => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeMartialArts => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypePaddling => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeParagliding => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypePilates => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeRacquetball => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeRockClimbing => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeRollerHockey => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeRowing => .strength,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeRowingMachine => .strength,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeRugby => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeRunning => .walkRun,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeRunningTreadmill => .walkRun,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeSailing => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeScubaDiving => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeSkating => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeSkiing => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeSnowboarding => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeSnowshoeing => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeSoccer => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeSoftball => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeSquash => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeStairClimbing => .walkRun,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeStairClimbingMachine => .walkRun,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeStrengthTraining => .strength,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeStretching => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeSurfing => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeSwimmingOpenWater => .swim,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeSwimmingPool => .swim,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeTableTennis => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeTennis => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeVolleyball => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeWalking => .walkRun,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeWaterPolo => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeWeightlifting => .strength,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeWheelchair => .cadio,
      // TODO: Handle this case.
      ExerciseClassify.exerciseTypeYoga => .cadio,
    };
  }
}

class ExerciseSession {
  final ExerciseType type;
  final double activeKcal;
  final double distanceKm;
  final int minutes;
  final int strokes; // 수영용
  ExerciseSession({
    required this.type,
    required this.activeKcal,
    required this.distanceKm,
    required this.minutes,
    required this.strokes,
  });
}

class HomeExerciseInjector {
  double clamp01(double x) => x < 0 ? 0 : (x > 1 ? 1 : x);
  double p(double r) => math.sqrt(clamp01(r));

  //bmr의 22% 정도를 소모하는 것을 목표하기 위한 메소드
  double exerciseKcalGoalDay(double bmr, {double afEx = 1.22}) {
    final raw = bmr * (afEx - 1.0);
    return raw.clamp(150.0, 600.0);
  }

  double calculateBmr(UserInfo userInfo) {
    //required param - height, weight, age, gender
    //male (10 X 체중 kg) + (6.25 X 키 cm) - (5 X 나이) + 5
    //female (10 X 체중 kg) + (6.25 X 키 cm) - (5 X 나이) - 161

    return userInfo.gender.toUpperCase() == 'M'
        ? (10 * userInfo.weight) + (6.25 * userInfo.height) - (5 * userInfo.age) + 5
        : (10 * userInfo.weight) + (6.25 * userInfo.height) - (5 * userInfo.age) - 161;
  }

  double sessionScore(ExerciseSession s, double kcalGoal) {
  // 간단 목표치들(원하면 kcalGoal 기반으로 파생 가능)
  final distGoal = (kcalGoal / 60.0).clamp(2.0, 10.0); // 임시: 60kcal/km 근사
  final minGoal = 40.0;
  final strokeGoal = 800.0;

  switch (s.type) {
    case ExerciseType.walkRun:
    final rDist = s.distanceKm / distGoal;
    final rCal  = s.activeKcal / kcalGoal;
    return 100 * (0.55*p(rDist) + 0.45*p(rCal));

    case ExerciseType.cycle:
    final rDist = s.distanceKm / (distGoal * 1.8); // 사이클은 거리 목표 더 큼
    final rCal  = s.activeKcal / kcalGoal;
    return 100 * (0.30*p(rDist) + 0.70*p(rCal));

    case ExerciseType.strength:
    final rMin = s.minutes / minGoal;
    final rCal = s.activeKcal / kcalGoal;
    return 100 * (0.55*p(rMin) + 0.45*p(rCal));

    case ExerciseType.swim:
    final rStroke = s.strokes / strokeGoal;
    final rDist   = s.distanceKm / distGoal;
    final rCal    = s.activeKcal / kcalGoal;
    return 100 * (0.45*p(rStroke) + 0.35*p(rDist) + 0.20*p(rCal));

    case ExerciseType.cadio:
      final rDist = s.distanceKm / distGoal;
      final rCal  = s.activeKcal / kcalGoal;
      return 100 * (0.55*p(rDist) + 0.45*p(rCal));
    }
  }

  int _dailyExerciseScore({
    required List<ExerciseSession?> sessions,
    required double bmr,
  }) {
    if (sessions.isEmpty) return 0;

    final kcalGoal = exerciseKcalGoalDay(bmr);

    // 타입별 누적(가중평균)
    final sums = <ExerciseType, double>{};
    final weights = <ExerciseType, double>{};

    for (final s in sessions) {
      final sc = sessionScore(s!, kcalGoal);
      final w = math.max(s.activeKcal, 20.0); // 작은 세션 영향 제한
      sums[s.type] = (sums[s.type] ?? 0) + sc * w;
      weights[s.type] = (weights[s.type] ?? 0) + w;
    }

    final typeScores = <ExerciseType, double>{};
    for (final t in sums.keys) {
      typeScores[t] = sums[t]! / weights[t]!;
    }

    // 오늘 한 운동 유형만 대상으로 평균(또는 원하는 typeWeight 적용 가능)
    final avg = typeScores.values.reduce((a, b) => a + b) / typeScores.length;
    return avg.round().clamp(0, 100);
  }

  Fourth processingEx(FeatureEntity receive, DateTime now, DateTime previousDay, HomeViewState state){
    int currentScore = 0;
    int previousScore = 0;
    int weeklyScore = 0;
    int weeklyCnt = 1;

    receive.featureLst?.map((e) {
      if(e.featureData != null){
        final daysExModel = e.featureData;
        String day = daysExModel!.instDt.substring(6,8);

        final exModel = daysExModel?.feature as FeatureExercise?;
        if(exModel != null){
          final dailySessions = exModel.featureData.map((element){
            if(element != null) {
              return ExerciseSession(
                // type: element.exerciseType,
                  type: ExerciseType.cycle,
                  activeKcal: element.calorie,
                  distanceKm: element.distance,
                  minutes: element.duration,
                  strokes: element.metricVal);
            }
          }).toList();
          if(dailySessions.isNotEmpty){
            final exScore = _dailyExerciseScore(sessions: dailySessions, bmr: 12.0);
            weeklyCnt += 1;
            if(int.parse(day) == now.day){
              currentScore = exScore;
            }else if(int.parse(day) == previousDay.day){
              currentScore = exScore;
            }
            weeklyScore += exScore;
          }

        }
      }
    });

    FeatureInfo feature = state.featureInfo['exercise']!.copyWith(
        score: currentScore.round()
    );

    return Fourth(
        currentScore.round(),
        previousScore.round(),
        (weeklyScore / weeklyCnt).round(),
        feature
    );
  }
}