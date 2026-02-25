
import '../../storage/feature_model/feature_model.dart';

abstract class HealthRepository {
  Future<List<FeatureModel>?> loadActData(int previousDays);
  Future<List<FeatureModel>?> loadHeartData(int previousDays);
  Future<List<FeatureModel>?> loadExerciseData(int previousDays);
  Future<List<FeatureModel>?> loadSleepData(int previousDays);

  Future<void> requestPermission();
}