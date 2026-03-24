import 'package:bodymind/features/main_feature/health/detail/sleep/domain/entity/sleep_type.dart';

class SleepStage {
  SleepType stage;
  int durationMin;

  SleepStage(this.stage, this.durationMin);
}