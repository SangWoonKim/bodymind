import 'act_daily_dto.dart';

class ActWeekDto {
  final List<ActDailyDto> actDailyData;
  final int weeklyAvgStepCnt;
  final int weeklyTotStepCnt;
  final DateTime weeklyMondayDate;
  final DateTime? weeklyMostActDay;
  final int weeklyContinuousCnt;

  ActWeekDto(
      this.actDailyData,
      this.weeklyAvgStepCnt,
      this.weeklyTotStepCnt,
      this.weeklyMondayDate,
      this.weeklyMostActDay,
      this.weeklyContinuousCnt
      );

}