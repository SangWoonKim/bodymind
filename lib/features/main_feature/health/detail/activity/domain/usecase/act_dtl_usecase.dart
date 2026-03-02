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

  Future<ActMonthDto?> loadDbActData(String stYMd, endYmd, DateTime selectMonth) async{
    print('stYmd = ${stYMd}');
    print('endYmd = ${endYmd}');
    List<FeatureModel>? actModels = await repository.loadActDataForDate(stYMd, endYmd);
    if(actModels == null) return null;
    return makeActDatas(actModels, selectMonth);
  }


  ActMonthDto makeActDatas(List<FeatureModel> actModels, DateTime selectMonth){
    print('called');
    ///여기 아예 데이터가 없을 경우 빈값 추가 로직 필요함
    // final existFirstDate = TimeUtil.yyyyMMddToDateTime(actModels.first.instDt);
    // final recDate = TimeUtil.yyyyMMddToDateTime(startYmd);
    MonthRangeResult montlyDate = TimeUtil().buildMonthWeekRanges(selectMonth.year, selectMonth.month);
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
    montlyDate.weeks.insert(0, WeekRange(0, montlyDate.weeks.first.start.add(Duration(days: -7)), montlyDate.weeks.first.end.add(Duration(days: -7))));
    montlyDate.weeks.forEach((e){
      print('montlyDate = ${e.start}');
      List<ActDailyDto> weeklyData = List.empty(growable: true);
      int totalStep = 0;
      double totalDistance = 0;
      double totalCalorie = 0;
      ActDailyDto? mostDay;
      /// 주차별 일자 데이터 삽입(반복중 총거리, 총칼로리, 총걸음수, 최대 걸은 날 산출)
      dailyData.forEach((act){

        if(TimeUtil.isInDateRangeInclusive(act.measrueDt, e.start, e.end)) {
          weeklyData.add(act);
          totalStep += act.stepCnt;
          totalDistance += act.distance;
          totalCalorie += act.calorie;
          // print(act.measrueDt);
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

      if(totalStep == 0 || zeroFilterLst.isEmpty == 0){
        monthlyData.add(ActWeekDto(weeklyData, 0, totalStep, e.start, mostDay?.measrueDt, continuousDays));
      }else{
        monthlyData.add(ActWeekDto(weeklyData, (totalStep/zeroFilterLst.length).round(), totalStep, e.start, mostDay?.measrueDt, continuousDays));
      }



      weeklyData = List.empty(growable: true);
    });

    ///월별 주차 summary 데이터 생성
    //현재 월 + 이전 마지막 주 데이터가 있음으로 이전 마지막 주데이터 skip
    final emptyListFilterLst = monthlyData.skip(1).where((e) => e.weeklyMostActDay != null).toList();
    int montlyTotStepCnt = 0;
    int montlyContinuousDays = 0;
    int acceptContinuousDays = 0;
    emptyListFilterLst.forEach((e) {
      montlyTotStepCnt += e.weeklyTotStepCnt;
    });

    //이전 마지막 7일 데이터 skip
    final lastSevenDayFilterLst = dailyData.where((e) => montlyDate.monthStart.isAfter(e.measrueDt)).toList();

    ActDailyDto? maxActiveDate = null;
    if(lastSevenDayFilterLst.isNotEmpty){
      maxActiveDate = lastSevenDayFilterLst.reduce((a,b){
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
    }


    return ActMonthDto(
        monthlyData,
        montlyTotStepCnt != 0 ? (montlyTotStepCnt/ emptyListFilterLst.length).round() : 0,
        montlyTotStepCnt,
        montlyDate.monthStart,
        maxActiveDate?.measrueDt,
        acceptContinuousDays
    );

  }


}