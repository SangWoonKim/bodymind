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
      required this.selectedOption,
        required this.evaluationPrev
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
      ), DateTime.now(), selectedOption: ActGraphSelection.COUNT, evaluationPrev: '데이터 없음');

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
        selectedDate ?? this.selectedDate, selectedOption: selectedOption ?? this.selectedOption, evaluationPrev: evaluationPrev ?? this.evaluationPrev);
  }
}

class HealthActViewModel extends Notifier<ActDtlState> {
  late final ActDtlUsecase _actUsecase;

  @override
  ActDtlState build() {
    _actUsecase = ref.read(actDtlUsecase);
    Future.microtask(() => initialize(DateTime.now()));
    return ActDtlState.initial();
  }

  Future<void> initialize(DateTime initDate) async{
    await _loadActData(initDate);
    final weekInt = TimeUtil().monthWeekByFirstMondayRuleToUi(initDate).week;
    _calculatedWeekScore(state.actDatas.weeklyData[weekInt], state.actDatas.weeklyData[weekInt -1]);
  }

  Future<void> _loadActData(DateTime requestDate) async{
    final loadMonthRange = TimeUtil().buildMonthWeekRanges(requestDate.year, requestDate.month);
    final stDate = TimeUtil.dateTimeToyymmdd(loadMonthRange.monthStart.add(Duration(days: -7)));
    final enDate = TimeUtil.dateTimeToyymmdd(loadMonthRange.monthEnd);

    final loadPrevMonthRange = TimeUtil().buildMonthWeekRanges(requestDate.year, requestDate.month -1);
    final prevStDate = TimeUtil.dateTimeToyymmdd(loadPrevMonthRange.monthStart);
    final prevEndDate = TimeUtil.dateTimeToyymmdd(loadPrevMonthRange.monthEnd);

    final currentMonth = await _actUsecase.loadDbActData(stDate, enDate, loadMonthRange.weeks[1].start);
    final prevMonth = await _actUsecase.loadDbActData(prevStDate, prevEndDate, loadPrevMonthRange.weeks[1].start);

    state = state.copyWith(actDatas: currentMonth, prevActDatas: prevMonth);
  }

  Future<void> changeMonth({int? moveWeek, int? moveMonth}) async{
    if(moveWeek != null && moveMonth == null){
      //1주 전 또는 1주 후 DateTime
      final week = state.selectedDate.add(Duration(days: moveWeek * 7));
      final loadMonthRange = TimeUtil().buildMonthWeekRanges(week.year, week.month).monthStart;
      //몇주차인지
      final weekInt = TimeUtil().monthWeekByFirstMondayRuleToUi(week).week;


      if(loadMonthRange.month != state.selectedDate.month){
        await _loadActData(loadMonthRange);
      }
      state = state.copyWith(isWeekly: true, selectedDate: week);
      _calculatedWeekScore(state.actDatas.weeklyData[weekInt], state.actDatas.weeklyData[weekInt -1]);

      print('changeMonth = ${state.selectedDate}');
    }else if(moveWeek == null && moveMonth != null){
      final month = DateTime(state.selectedDate.year, state.selectedDate.month + moveMonth, state.selectedDate.day);
      final loadMonthRange = TimeUtil().buildMonthWeekRanges(month.year, month.month).monthStart;
      await _loadActData(loadMonthRange);
      state = state.copyWith(isWeekly : false, selectedDate: month);
    }



  }

  void _calculatedWeekScore(ActWeekDto targetWeek, ActWeekDto prevWeek) {
    final targetWeekScore = _createScore(targetWeek);
    final prevWeekScore = _createScore(prevWeek);
    final different = targetWeekScore - prevWeekScore;

    print('targetWeekScore = ${targetWeekScore}');
    print('prevWeekScore = ${prevWeekScore}');
    print('different = ${different}');
    final evaluationPrev = '전주 대비 ${different}% ${different > 0 ? '증가' : '감소'}' ;
    state = state.copyWith(mainScoreEvaluation: '안정적인 편이에요', mainScore: targetWeekScore, evaluationPrev: ' $evaluationPrev');
  }

  int _createScore(ActWeekDto data){
    final now = DateTime.now();

    if(data.actDailyData.isEmpty){
      return 0;
    }
    int nonZeroCnt = 0;
    int sumScore = data.actDailyData.where((e) => e.stepCnt != 0).toList().map((e) {
      final dataYmd = e.measrueDt;
      int score = 0;
      nonZeroCnt++;
      if(TimeUtil.dateTimeToyymmdd(now) == TimeUtil.dateTimeToyymmdd(dataYmd)){
        score = HomeScoreUtil().activityScoreUpToNow(hour: now.hour, min: now.minute, steps: e.stepCnt, distance: e.distance, weight: 70, height: 170, age: 32, isMale: true);
      }else{
        score = HomeScoreUtil().activityScoreUpToNow(hour: dataYmd.hour, min: dataYmd.minute, steps: e.stepCnt, distance: e.distance, weight: 70, height: 170, age: 32, isMale: true);
      }
      return score;
    }).reduce((a,b) => a+b);

    if(nonZeroCnt == 0 || sumScore == 0) return 0;
    return (sumScore / nonZeroCnt).round();
  }

  void selectGraphView(ActGraphSelection selected){
    state = state.copyWith(selectedOption: selected);
  }



}
