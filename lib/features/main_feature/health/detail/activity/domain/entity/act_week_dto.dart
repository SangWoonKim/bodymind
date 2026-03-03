import 'act_daily_dto.dart';

class ActWeekDto {
  final List<ActDailyDto> actDailyData;
  final int weeklyAvgStepCnt;
  final int weeklyTotStepCnt;
  final DateTime weeklyMondayDate;
  final DateTime? weeklyMostActDay;
  final int weeklyContinuousCnt;
  final double weeklyTotDistance;
  final double weeklyTotCalorie;

  ActWeekDto(
      this.actDailyData,
      this.weeklyAvgStepCnt,
      this.weeklyTotStepCnt,
      this.weeklyMondayDate,
      this.weeklyMostActDay,
      this.weeklyContinuousCnt,
      this.weeklyTotDistance,
      this.weeklyTotCalorie
      );

}