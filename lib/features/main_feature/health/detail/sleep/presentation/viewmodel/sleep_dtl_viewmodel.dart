import 'package:bodymind/features/main_feature/health/detail/sleep/domain/entity/daily_sleep_info.dart';
import 'package:bodymind/features/main_feature/health/detail/sleep/domain/entity/sleep_analysis.dart';
import 'package:bodymind/features/main_feature/health/detail/sleep/domain/usecase/sleep_usecase.dart';
import 'package:bodymind/features/main_feature/health/detail/sleep/presentation/provider/sleep_dtl_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/util/bodymind_core_util.dart';
import '../../domain/entity/sleep_stage.dart';
import '../../domain/entity/sleep_summary.dart';

class SleepDtlState{
  final DateTime selectedDate;
  final DateTime? baseDate;
  final DateTime? startDate;
  final List<SleepStage>? stages;
  final SleepSummary? summary;
  final SleepAnalysis analysis;

  SleepDtlState(this.selectedDate, this.baseDate, this.startDate, this.stages, this.summary, this.analysis);

  SleepDtlState copyWith({
    required DateTime selectedDate,
    DateTime? baseDate,
    DateTime? startDate,
    List<SleepStage>? stages,
    SleepSummary? summary,
    SleepAnalysis? analysis}){
    return SleepDtlState(selectedDate, baseDate, startDate, stages, summary, analysis ?? SleepAnalysis.invalid());
  }
}

class SleepDtlViewmodel extends AutoDisposeNotifier<SleepDtlState>{

  late final SleepUsecase usecase;
  Map<String, DailySleepInfo>? preloadData;

  @override
  SleepDtlState build() {
    usecase = ref.read(sleepDtlUsecaseProvider);
    Future.microtask(() => _initialize(DateTime.now()));
    return SleepDtlState(DateTime.now(), null, null, null, null, SleepAnalysis.invalid());
  }

  void _initialize(DateTime selectCurrentTime) async{
    final loadMonthRange = TimeUtil().buildMonthWeekRanges(selectCurrentTime.year, selectCurrentTime.month);
    final stDate = TimeUtil.dateTimeToyymmdd(loadMonthRange.monthStart);
    final enDate = TimeUtil.dateTimeToyymmdd(loadMonthRange.monthEnd);

    preloadData = await usecase.loadDbSleepInfo(stDate, enDate);

    if(preloadData != null){
      final data = preloadData![TimeUtil.dateTimeToyymmdd(selectCurrentTime)];
      state = state.copyWith(
          selectedDate: selectCurrentTime,
          startDate: data?.startDateTime,
          baseDate: data?.endDateTime,
          stages: data?.stages,
          summary: data?.summary,
          analysis: data?.analysis ?? SleepAnalysis.invalid());
    }
  }

  void selectedDate({required bool isMoveMonth, required DateTime selectedDate}) async{
    if(isMoveMonth){
      final loadMonthRange = TimeUtil().buildMonthWeekRanges(selectedDate.year, selectedDate.month);
      final stDate = TimeUtil.dateTimeToyymmdd(loadMonthRange.monthStart);
      final enDate = TimeUtil.dateTimeToyymmdd(loadMonthRange.monthEnd);
      preloadData = await usecase.loadDbSleepInfo(stDate, enDate);

      if(preloadData != null){
        final data = preloadData![TimeUtil.dateTimeToyymmdd(selectedDate)];
        state = state.copyWith(
            selectedDate: selectedDate,
            startDate: data?.startDateTime,
            baseDate: data?.endDateTime,
            stages: data?.stages,
            summary: data?.summary,
            analysis: data?.analysis ?? SleepAnalysis.invalid());
      }
    }else{
      final data = preloadData![TimeUtil.dateTimeToyymmdd(selectedDate)];
      state = state.copyWith(
          selectedDate: selectedDate,
          startDate: data?.startDateTime,
          baseDate: data?.endDateTime,
          stages: data?.stages,
          summary: data?.summary,
          analysis: data?.analysis ?? SleepAnalysis.invalid());
    }

  }
}