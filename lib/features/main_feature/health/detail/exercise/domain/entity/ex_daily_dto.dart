import 'package:bodymind/features/main_feature/health/detail/exercise/domain/entity/ex_element_dto.dart';

class ExDailyDto {
  final int day;
  final DateTime strtYmd;
  final double dailyCalories;
  final double dailyDistance;
  final int dailyDuration;
  final List<ExElementDto> element;

  ExDailyDto(this.day, this.strtYmd, this.dailyCalories, this.dailyDistance,
      this.dailyDuration,this.element);

}