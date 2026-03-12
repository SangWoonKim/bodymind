import 'package:bodymind/core/storage/feature_model/feature_data/exercise/feature_exercise.dart';
import 'package:bodymind/core/util/bodymind_core_util.dart';
import 'package:bodymind/features/main_feature/health/detail/exercise/domain/entity/ex_element_dto.dart';
import 'package:bodymind/features/main_feature/health/detail/exercise/domain/entity/ex_month_dto.dart';
import 'package:bodymind/features/main_feature/health/detail/exercise/domain/repository/ex_dtl_repository.dart';
import 'package:bodymind/features/main_feature/health/detail/util/feature_util.dart';
import 'package:bodymind/features/main_feature/home/presentation/viewmodel/injector/home_exercise_injector.dart';

import '../../../../../../../core/storage/feature_model/feature_model.dart';
import '../entity/ex_daily_dto.dart';

class ExDtlUsecase {
 final ExDtlRepository repository;


 ExDtlUsecase(this.repository);

 Future<ExMonthDto?> loadDbExData(String stYmd, endYmd, DateTime selectMonth) async{
  List<FeatureModel>? exModels = await repository.loadDbExDataForDate(stYmd, endYmd);
  if(exModels == null) return null;
  return makeExDatas(exModels, selectMonth);
 }

 ExMonthDto makeExDatas(List<FeatureModel> exModels, DateTime selectMonth){

  MonthRangeResult montlyDate = TimeUtil().buildMonthWeekRanges(selectMonth.year, selectMonth.month);
  List<ExDailyDto> dailyData = List.empty(growable: true);

  dailyData = exModels.map((e){
    final data = e.feature as FeatureExercise;
    return ExDailyDto(
        data.strtYmd.day,
        data.strtYmd,
        data.totalCalorie,
        data.totalDistance,
        data.totalDuration,
        data.featureData.where((e) => e!= null).map((e) {
          final filteredHr = e!.hrLst.map((e) => int.parse(e)).where((e) => e > 50).toList();

          return ExElementDto(
              TimeUtil.yyyyMMddHHmmToDateTime(e.strtDt),
              e.duration,
              ExerciseType.walkRun,//e.metricKind
              e.metricVal,
              e.calorie,
              e.distance,
              5,
              e.hrLst.map((e) => int.parse(e)).toList(),
              filteredHr.featureMax().toInt(),
              filteredHr.featureMin().toInt(),
              HomeExerciseInjector().
          );
        }).toList()
    );
  }).toList();

  return ExMonthDto(montlyDate.monthStart, dailyData);
 }

}