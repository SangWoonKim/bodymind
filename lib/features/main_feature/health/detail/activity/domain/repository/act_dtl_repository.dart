import '../../../../../../../core/storage/feature_model/feature_model.dart';

abstract class ActDtlRepository {
  Future<List<FeatureModel>?> loadActDataForDate(String yyyyMMdd);
}