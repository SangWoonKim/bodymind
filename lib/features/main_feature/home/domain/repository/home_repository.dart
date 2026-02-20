import 'package:common_mutiple_health/entity/model/base/base_dynamic_model.dart';

import '../../../../../core/storage/feature_model/feature_model.dart';


abstract class HomeRepository {
  Future<List<FeatureModel>?> loadActData(int previousDays);
  Future<List<FeatureModel>?> loadHeartData(int previousDays);
  Future<List<FeatureModel>?> loadExerciseData(int previousDays);
  Future<List<FeatureModel>?> loadSleepData(int previousDays);
  Future<void> requestPermission();
}