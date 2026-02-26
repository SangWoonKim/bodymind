import 'package:bodymind/core/storage/feature_model/feature_data/act/feature_act.dart';
import 'package:bodymind/core/storage/feature_model/feature_model.dart';
import 'package:bodymind/core/util/bodymind_core_util.dart';
import 'package:bodymind/features/main_feature/health/detail/activity/domain/entity/act_daily_dto.dart';
import 'package:bodymind/features/main_feature/health/detail/activity/domain/entity/act_graph_dto.dart';
import 'package:bodymind/features/main_feature/health/detail/activity/domain/entity/act_month_dto.dart';
import 'package:bodymind/features/main_feature/health/detail/activity/domain/entity/act_week_dto.dart';
import 'package:bodymind/features/main_feature/health/detail/activity/domain/repository/act_dtl_repository.dart';
import 'package:bodymind/features/main_feature/health/detail/util/feature_util.dart';

class ActDtlUsecase {
  final ActDtlRepository repository;

  ActDtlUsecase(this.repository);

  Future<ActGraphDto?> loadDbActData(String yyyyMM) async{
    List<FeatureModel>? actModels = await repository.loadActDataForDate(yyyyMM);
    if(actModels == null) return null;

  }


  ActMonthDto makeActDatas(List<FeatureModel> actModels){
    final existFirstDate = TimeUtil.yyyyMMddToDateTime(actModels.first.instDt);
    final montlyDate = TimeUtil().buildMonthWeekRanges(existFirstDate.year, existFirstDate.month);

    List<ActDailyDto> dailyData = List.empty(growable: true);

    //List<FeatureModel> => List<ActDailyDto>
    actModels.forEach((e){
      //day
      DateTime actTime = TimeUtil.yyyyMMddToDateTime(e.instDt);
      final data = e.feature as FeatureAct;
      dailyData.add(ActDailyDto(data.stepCount, data.calorie, data.distance, actTime));
    });


    //주별 데이터 group객체 생성
    List<ActWeekDto> monthlyData = List.empty(growable: true);

    montlyDate.weeks.forEach((e){
      List<ActDailyDto> weeklyData = List.empty(growable: true);
      int totalStep = 0;
      double totalDistance = 0;
      double totalCalorie = 0;
      ActDailyDto? mostDay;


      // 주차별 일자 데이터 삽입(반복중 총거리, 총칼로리, 총걸음수, 최대 걸은 날 산출)
      dailyData.forEach((act){
        final diffDay = e.start.difference(act.measrueDt).inDays;
        if(diffDay < 7 && diffDay >= 0) {
          weeklyData.add(act);
          totalStep += act.stepCnt;
          totalDistance += act.distance;
          totalCalorie += act.calorie;
          if(mostDay == null){
            mostDay = act;
          }else{
            if(mostDay!.stepCnt < act.stepCnt){
              mostDay = act;
            }
          }
        }
      });

      final zeroFilterLst = weeklyData.where((e) => e.stepCnt != 0).toList();

      //연속 기록 산출
      int continuousDays = 0;
      int acceptWeeklyContinuousDays = 0;

      if(zeroFilterLst.isNotEmpty){
        zeroFilterLst.reduce((a,b) {
          final diffDate = a.measrueDt.difference(b.measrueDt).inDays;
          if(diffDate > 0 && diffDate < 2){
            continuousDays += 1;
          }else{
            continuousDays = 0;
          }

          if(acceptWeeklyContinuousDays < continuousDays){
            acceptWeeklyContinuousDays = continuousDays;
          }
          return b;
        });
      }


      monthlyData.add(ActWeekDto(weeklyData, (totalStep/zeroFilterLst.length).round(), totalStep, e.start, mostDay?.measrueDt, continuousDays));
      weeklyData = List.empty(growable: true);
    });

    final emptyListFilterLst = monthlyData.where((e) => e.weeklyMostActDay != null).toList();
    int montlyTotStepCnt = 0;
    int montlyContinuousDays = 0;
    int acceptContinuousDays = 0;
    emptyListFilterLst.forEach((e) {
      montlyTotStepCnt += e.weeklyTotStepCnt;
    });

    final maxActiveDate = dailyData.reduce((a,b){
      final diffDate = a.measrueDt.difference(b.measrueDt).inDays;
      if(diffDate > 0 && diffDate < 2){
        montlyContinuousDays += 1;
      }else{
        montlyContinuousDays = 0;
      }

      if(acceptContinuousDays < montlyContinuousDays){
        acceptContinuousDays = montlyContinuousDays;
      }
      return a.stepCnt > b.stepCnt ? a : b;
    });

    return ActMonthDto(
        monthlyData,
        (montlyTotStepCnt/ emptyListFilterLst.length).round(),
        montlyTotStepCnt,
        montlyDate.monthStart,
        maxActiveDate.measrueDt,
        acceptContinuousDays
    );

  }


}