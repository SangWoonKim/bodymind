import 'package:common_mutiple_health/entity/model/base/base_dynamic_model.dart';

import '../../../../../core/storage/feature_model/feature_model.dart';

abstract class HomeDbRepository {
  Future<List<FeatureModel>?>  loadSavedActData(int previousDays);
  Future<List<FeatureModel>?> loadSavedHeartData(int previousDays);
  Future<List<FeatureModel>?> loadSavedExerciseData(int previousDays);
  Future<List<FeatureModel>?> loadSavedSleepData(int previousDays);
  Future<void> savedActData(String isrtDt, int stepCount, double distance, double calorie);
  Future<void> savedHeartData(String isrtDt, List<int> hrLst, double restBase, double varBase, double highBase);
  Future<void> savedExerciseData(List<FeatureModel> exModels);
  Future<void> savedSleepData(List<FeatureModel> slpModels);
}