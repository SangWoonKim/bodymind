import 'package:bodymind/features/main_feature/health/detail/sleep/domain/entity/daily_sleep_info.dart';
import 'package:bodymind/features/main_feature/health/detail/sleep/domain/entity/sleep_analysis.dart';
import 'package:bodymind/features/main_feature/health/detail/sleep/domain/usecase/sleep_usecase.dart';
import 'package:bodymind/features/main_feature/health/detail/sleep/presentation/provider/sleep_dtl_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/util/bodymind_core_util.dart';
import '../../domain/entity/sleep_stage.dart';
import '../../domain/entity/sleep_summary.dart';

class SleepDtlState{
  final DateTime? selectedDate;
  final DateTime? baseDate;
  final List<SleepStage>? stages;
  final SleepSummary? summary;
  final SleepAnalysis? analysis;

  SleepDtlState(this.selectedDate,this.baseDate, this.stages, this.summary, this.analysis);

  SleepDtlState copyWith({
    DateTime? selectedDate,
    DateTime? baseDate,
    List<SleepStage>? stages,
    SleepSummary? summary,
    SleepAnalysis? analysis}){
    return SleepDtlState(selectedDate, baseDate, stages, summary, analysis);
  }
}

class SleepDtlViewmodel extends AutoDisposeNotifier<SleepDtlState>{

  late final SleepUsecase usecase;
  Map<String, DailySleepInfo>? preloadData;

  @override
  SleepDtlState build() {
    usecase = ref.read(sleepDtlUsecaseProvider);
    Future.microtask(() => _initialize(DateTime.now()));
    return SleepDtlState(null,null, null, null,null);
  }

  void _initialize(DateTime selectCurrentTime) async{
    String stYmd = TimeUtil.dateTimeToyymmdd(selectCurrentTime.add(Duration(days: -7)));
    String endYmd = TimeUtil.dateTimeToyymmdd(selectCurrentTime);
    preloadData = await usecase.loadDbSleepInfo(stYmd, endYmd);

    if(preloadData != null){
      final data = preloadData![endYmd];
      state = state.copyWith(
          baseDate: data?.endDateTime,
          stages: data?.stages,
          summary: data?.summary,
          analysis: data?.analysis);
    }
  }
}