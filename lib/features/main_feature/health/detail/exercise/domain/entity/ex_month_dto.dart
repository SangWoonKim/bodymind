import 'package:bodymind/features/main_feature/health/detail/exercise/domain/entity/ex_daily_dto.dart';

class ExMonthDto {
  final DateTime montlyMondayDate;
  List<ExDailyDto> dailyData;

  ExMonthDto(this.montlyMondayDate, this.dailyData);
}