import 'act_week_dto.dart';

class ActMonthDto {
  final List<ActWeekDto> weeklyData;
  final int montlyAvgStepCnt;
  final int montlyTotStepCnt;
  final DateTime montlyMondayDate;
  final DateTime? montlyMostActDay;
  final int montlyContinuousCnt;

  ActMonthDto(this.weeklyData, this.montlyAvgStepCnt, this.montlyTotStepCnt,
      this.montlyMondayDate, this.montlyMostActDay, this.montlyContinuousCnt);
}