import 'package:bodymind/core/util/bodymind_core_util.dart';
import 'package:bodymind/features/main_feature/health/detail/activity/domain/entity/act_graph_dto.dart';
import 'package:bodymind/features/main_feature/health/detail/activity/domain/entity/act_month_dto.dart';
import 'package:bodymind/features/main_feature/health/detail/activity/domain/entity/act_week_dto.dart';
import 'package:bodymind/features/main_feature/health/detail/activity/domain/usecase/act_dtl_usecase.dart';
import 'package:bodymind/features/main_feature/health/detail/activity/presentation/view/enum/act_graph_option.dart';
import 'package:bodymind/features/main_feature/home/domain/usecase/home_usecase.dart';
import 'package:bodymind/features/main_feature/home/presentation/viewmodel/injector/home_act_injector.dart';
import 'package:bodymind/features/main_feature/home/util/home_score_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/health_act_dtl_provider.dart';

class ActDtlState {
  final int mainScore;
  final ActGraphSelection selectedOption;
  final bool isWeekly;
  final String mainScoreEvaluation;
  final ActMonthDto actDatas;
  final ActMonthDto prevActDatas;
  final DateTime selectedDate;
  final String evaluationPrev;


  ActDtlState(
    this.mainScore,
    this.isWeekly,
    this.mainScoreEvaluation,
    this.actDatas,
    this.prevActDatas,
    this.selectedDate, {
    this.selectedOption = ActGraphSelection.COUNT,
        this.evaluationPrev =' 데이터 없음'
  });

  factory ActDtlState.initial() =>
      ActDtlState(0, true, '데이터 없음', ActMonthDto(
          [],
          0,
          0,
          DateTime.now(),
          DateTime.now(),
          0
      ), ActMonthDto(
          [],
          0,
          0,
          DateTime.now(),
          DateTime.now(),
          0
      ), DateTime.now());

  ActDtlState copyWith({
    int? mainScore,
    ActGraphSelection? selectedOption,
    bool? isWeekly,
    String? mainScoreEvaluation,
    ActMonthDto? actDatas,
    ActMonthDto? prevActDatas,
    DateTime? selectedDate,
    String? evaluationPrev,
  }){
    return ActDtlState(
        mainScore ?? this.mainScore,
        isWeekly ?? this.isWeekly,
        mainScoreEvaluation ?? this.mainScoreEvaluation,
        actDatas ?? this.actDatas,
        prevActDatas ?? this.prevActDatas,
        selectedDate ?? this.selectedDate);
  }
}

class HealthActViewModel extends Notifier<ActDtlState> {
  late final ActDtlUsecase _actUsecase;

  @override
  ActDtlState build() {
    _actUsecase = ref.read(actDtlUsecase);
    Future.microtask(() => _loadActData(DateTime.now()));
    return ActDtlState.initial();
  }


  Future<void> _loadActData(DateTime requestDate) async{
    final loadMonthRange = TimeUtil().buildMonthWeekRanges(requestDate.year, requestDate.month);
    final stDate = TimeUtil.dateTimeToyymmdd(loadMonthRange.monthStart.add(Duration(days: -7)));
    final enDate = TimeUtil.dateTimeToyymmdd(loadMonthRange.monthEnd);

    final prevStDate = TimeUtil.dateTimeToyymmdd(loadMonthRange.monthStart);
    final prevEndDate = TimeUtil.dateTimeToyymmdd(loadMonthRange.monthEnd);

    final currentMonth = await _actUsecase.loadDbActData(stDate, enDate);
    final prevMonth = await _actUsecase.loadDbActData(prevStDate, prevEndDate);

    state = state.copyWith(actDatas: currentMonth, prevActDatas: prevMonth);
  }

  Future<void> _changeMonth({int? moveWeek, int? moveMonth}) async{
    if(moveWeek != null && moveMonth == null){
      //1주 전 또는 1주 후 DateTime
      final week = state.selectedDate.add(Duration(days: moveWeek * 7));
      final loadMonthRange = TimeUtil().buildMonthWeekRanges(week.year, week.month).monthStart;
      //몇주차인지
      final weekInt = TimeUtil().monthWeekByFirstMondayRuleToUi(week).week;

      if(loadMonthRange.month != state.selectedDate.month){
        await _loadActData(loadMonthRange);
        state = state.copyWith(isWeekly: true, selectedDate: week);
      }
      _calculatedWeekScore(state.actDatas.weeklyData[weekInt], state.actDatas.weeklyData[weekInt -1]);


    }else if(moveWeek == null && moveMonth != null){
      final month = DateTime(state.selectedDate.year, state.selectedDate.month + moveMonth, state.selectedDate.day);
      final loadMonthRange = TimeUtil().buildMonthWeekRanges(month.year, month.month).monthStart;
      await _loadActData(loadMonthRange);
      state = state.copyWith(isWeekly : false, selectedDate: month);
    }
  }

  void _calculatedWeekScore(ActWeekDto targetWeek, ActWeekDto prevWeek) {
    final targetWeekScore = _createScore(targetWeek);
    final prevWeekScore = _createScore(targetWeek);
    final different = (targetWeekScore - prevWeekScore) / prevWeekScore;

    final mainScoreEvaluation = '전주 대비 $different ${different > 0 ? '증가' : '감소'}' ;
    state = state.copyWith(mainScoreEvaluation: mainScoreEvaluation, mainScore: targetWeekScore, evaluationPrev: ' $different%');
  }

  int _createScore(ActWeekDto data){
    final now = DateTime.now();

    return data.actDailyData.where((e) => e.stepCnt != 0).toList().map((e) {
      final dataYmd = e.measrueDt;
      int score = 0;
      if(TimeUtil.dateTimeToyymmdd(now) == TimeUtil.dateTimeToyymmdd(dataYmd)){
        score = HomeScoreUtil().activityScoreUpToNow(hour: now.hour, min: now.minute, steps: e.stepCnt, distance: e.distance, weight: 70, height: 170, age: 32, isMale: true);
      }else{
        score = HomeScoreUtil().activityScoreUpToNow(hour: dataYmd.hour, min: dataYmd.minute, steps: e.stepCnt, distance: e.distance, weight: 70, height: 170, age: 32, isMale: true);
      }
      return score;
    }).reduce((a,b) => a+b);
  }

}
