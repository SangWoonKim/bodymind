import 'package:bodymind/core/storage/database/query/bodymind_database.dart';
import 'package:bodymind/core/storage/feature_model/feature_data/exercise/detail/feature_exercise_dtl.dart';
import 'package:bodymind/core/storage/feature_model/feature_data/exercise/feature_exercise.dart';
import 'package:bodymind/core/storage/feature_model/feature_model.dart';
import 'package:bodymind/core/util/bodymind_core_util.dart';
import 'package:bodymind/features/main_feature/health/detail/exercise/domain/entity/ex_month_dto.dart';
import 'package:bodymind/features/main_feature/health/detail/exercise/domain/repository/ex_dtl_repository.dart';
import 'package:collection/collection.dart';
import 'package:common_mutiple_health/entity/const/exercise_classfiy.dart';

class ExDtlRepositoryImpl extends ExDtlRepository{
  final BodymindDatabase db;


  ExDtlRepositoryImpl(this.db);

  @override
  Future<List<FeatureModel>?> loadDbExDataForDate(String stYmd, String endYmd) async{
    List<SelectFeatureExerciseResult> result = await db.selectFeatureExercise().get();

    if(result.isEmpty) return null;
    Map<String, List<SelectFeatureExerciseResult>> groupedData = groupBy(result, (e) =>e.baseDate);
    List<FeatureModel> returnResult = List.empty(growable: true);

    groupedData.forEach((baseDate, dailyData) {
      int totalDuration = 0;
      double totalCalorie = 0;
      double totalDistance = 0;

      final dtlLst = dailyData.map((e) {
        final duration = TimeUtil.yyyyMMddHHmmToDateTime(e.endHhmm)
            .difference(TimeUtil.yyyyMMddHHmmToDateTime(e.startHhmm)).inMinutes;
        totalDistance += e.distance;
        totalCalorie += e.calorie;
        totalDuration += duration;
        return FeatureExerciseDtl(e.startHhmm, e.endHhmm, e.hrLst.split(','), ExerciseClassify.fromValue(e.exSn),
        e.metricKind, e.metricVal.toInt(), e.distance, e.calorie, duration);
      }).toList();

      returnResult.add(
          FeatureModel(
              baseDate, FeatureExercise(
              TimeUtil.yyyyMMddToDateTime(baseDate),
              totalDuration,
              totalCalorie,
              totalDistance,
              dtlLst)
          )
      );
    });
  }



}