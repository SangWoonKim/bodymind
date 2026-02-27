import 'package:bodymind/core/util/bodymind_core_util.dart';
import 'package:bodymind/features/main_feature/health/detail/activity/domain/entity/act_graph_dto.dart';
import 'package:bodymind/features/main_feature/health/detail/activity/domain/entity/act_month_dto.dart';
import 'package:bodymind/features/main_feature/health/detail/activity/domain/usecase/act_dtl_usecase.dart';
import 'package:bodymind/features/main_feature/health/detail/activity/presentation/view/enum/act_graph_option.dart';
import 'package:bodymind/features/main_feature/home/domain/usecase/home_usecase.dart';
import 'package:bodymind/features/main_feature/home/presentation/viewmodel/injector/home_act_injector.dart';
import 'package:bodymind/features/main_feature/home/util/home_score_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

class HeatlhActViewModel extends Notifier<ActDtlState> {
  final ActDtlUsecase _actUsecase;

  HeatlhActViewModel(this._actUsecase);

  @override
  ActDtlState build() {
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

    //이걸로 점수 산출을 해야하는데... 이게 하루 단위란 말이지....? 반복해서 계속 객체를 생성해가면서 할까...?
    // HomeScoreUtil().activityScoreUpToNow(hour: hour, min: min, steps: steps, distance: distance, weight: weight, height: height, age: age, isMale: isMale)
    // String mainScoreEvaluation  = '데이터 없음;'
    // if(state.isWeekly){
    //     mainScoreEvaluation = '전주 대비 ${}'
    // }
    state = state.copyWith(actDatas: currentMonth, prevActDatas: prevMonth);
  }

  Future<void> _changeMonth({int? moveWeek, int? moveMonth}) async{
    if(moveWeek != null && moveMonth == null){
      final week = state.selectedDate.add(Duration(days: moveWeek * 7));
      final loadMonthRange = TimeUtil().buildMonthWeekRanges(week.year, week.month).monthStart;
      if(loadMonthRange != state.selectedDate.month){
        await _loadActData(loadMonthRange);
        state = state.copyWith(selectedDate: week);
      }
    }else if(moveWeek == null && moveMonth != null){
      final month = DateTime(state.selectedDate.year, state.selectedDate.month + moveMonth, state.selectedDate.day);
      final loadMonthRange = TimeUtil().buildMonthWeekRanges(month.year, month.month).monthStart;
      await _loadActData(loadMonthRange);
      state = state.copyWith(selectedDate: month);
    }
  }
}
