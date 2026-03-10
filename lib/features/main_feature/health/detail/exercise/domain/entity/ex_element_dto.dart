import 'package:bodymind/features/main_feature/home/presentation/viewmodel/injector/home_exercise_injector.dart';

class ExElementDto {
  final DateTime strtDt;
  final int duration;
  final ExerciseType exType;
  final int count;
  final double activeCalorie;
  final double distance;
  final int hrInterval;
  final List<int> hrLst;
  final int maxHr;
  final int minHr;

  ExElementDto(this.strtDt, this.duration, this.exType, this.count,
      this.activeCalorie, this.distance, this.hrInterval, this.hrLst,
      this.maxHr, this.minHr);
}