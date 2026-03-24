import 'package:bodymind/features/main_feature/health/detail/sleep/domain/entity/sleep_analysis.dart';
import 'package:bodymind/features/main_feature/health/detail/sleep/domain/entity/sleep_stage.dart';
import 'package:bodymind/features/main_feature/health/detail/sleep/domain/entity/sleep_summary.dart';

class DailySleepInfo{
  final String baseDate;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final SleepAnalysis analysis;
  final SleepSummary summary;
  final List<SleepStage> stages;

  DailySleepInfo(
      this.baseDate,
      this.startDateTime,
      this.endDateTime,
      this.analysis,
      this.summary,
      this.stages);


}