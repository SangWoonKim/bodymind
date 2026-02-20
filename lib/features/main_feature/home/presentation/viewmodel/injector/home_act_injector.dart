import 'package:bodymind/core/storage/feature_model/feature_data/act/feature_act.dart';
import 'package:bodymind/core/util/bodymind_core_util.dart';
import 'package:bodymind/core/util/fourth.dart';
import 'package:common_mutiple_health/entity/model/element/act_model.dart';

import '../../../../../user/domain/entity/user_info.dart';
import '../../../domain/entity/home_feature_entity.dart';
import '../../../util/home_score_util.dart';
import '../home_viewmodel.dart';

class HomeActInjector {
  Fourth? processingAct(List<HomeFeatureEntity>? receivedData, UserInfo userInfo, HomeViewState state){
    if(receivedData == null) return null;
    int currentScore = 0;
    int previousScore = 0;
    int weeklyScore = 0;
    int weeklyExistCnt = 1;

    HomeFeatureEntity? totalSelectedData;
    try {
      totalSelectedData = receivedData.firstWhere((currentData) {
        final startDate = currentData.featureData?.instDt;
        if (startDate == null) return false;

        final d = TimeUtil.yyyyMMddToDateTime(startDate);
        final now = DateTime.now();

        return d.year == now.year && d.month == now.month && d.day == now.day;
      });
    } catch (_) {
      totalSelectedData = null;
    }

    ///오늘 활동 데이터 추출 및 점수 산출 start
    DateTime now = DateTime.now();


    FeatureAct? currentData = totalSelectedData?.featureData?.feature as FeatureAct?;

    currentScore = HomeScoreUtil().activityScoreUpToNow(
        hour: now.hour,
        min: now.minute, steps: currentData?.stepCount ?? 0, distance: currentData?.distance ?? 0, weight: userInfo.weight, height: userInfo.height, age: userInfo.age, isMale: userInfo.gender =='M' ? true : false);
    weeklyScore += currentScore;
    if(currentScore != 0){
      weeklyExistCnt += 1;
    }
    ///오늘 활동 데이터 추출 및 점수 산출 end

    /// 전일 및 한주간 점수 산출 start
    DateTime previous = now.add(Duration(days: -1));


    receivedData.map((e) => e.featureData).where((nullableData) => nullableData != null).forEach((element){
        FeatureAct? actData = element?.feature as FeatureAct?;

        if(actData != null){
          if(element?.instDt != null){
            //전일
            if (previous.day == TimeUtil.yyyyMMddHHmmToDateTime(element!.instDt)
                .day) {
              previousScore = HomeScoreUtil().activityScoreUpToNow(
                  hour: 23,
                  min: 59,
                  steps: actData.stepCount,
                  distance: actData.distance,
                  weight: userInfo.weight,
                  height: userInfo.height,
                  age: userInfo.age,
                  isMale: userInfo.gender =='M' ? true : false);
              weeklyScore += previousScore;
            }
          }

          //나머지
          int otherScore = HomeScoreUtil().activityScoreUpToNow(
              hour: 23,
              min: 59,
              steps: actData.stepCount,
              distance: actData.distance,
              weight: userInfo.weight,
              height: userInfo.height,
              age: userInfo.age,
              isMale: userInfo.gender =='M' ? true : false);

          if (otherScore != 0) {
            weeklyScore += otherScore;
            weeklyExistCnt += 1;
          }
        }
    });
    weeklyScore = (weeklyScore / weeklyExistCnt).round();
    /// 전일 및 한주간 점수 산출 end


    /// viewModel 주입 및 갱신
    FeatureInfo actInfo = FeatureInfo(
        score: currentScore,
        featureEvaluationStr: HomeScoreUtil().actEvaluationStr(currentScore),
        route: 'feature/act');


    return Fourth(
        actInfo.score,
        previousScore,
        weeklyScore,
        state.featureInfo['act']!.copyWith(
        score: currentScore)
        );
  }
}