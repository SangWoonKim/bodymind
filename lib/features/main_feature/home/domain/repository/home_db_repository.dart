import 'package:common_mutiple_health/entity/model/base/base_dynamic_model.dart';

import '../../../../../core/storage/feature_model/feature_model.dart';

abstract class HomeDbRepository {
  Future<List<FeatureModel>?>  loadSavedActData(int previousDays);
  Future<List<FeatureModel>?> loadSavedHeartData(int previousDays);
  Future<List<FeatureModel>?> loadSavedExerciseData(int previousDays);
  Future<List<FeatureModel>?> loadSavedSleepData(int previousDays);

}