import '../../../../../../../core/storage/feature_model/feature_model.dart';

abstract class HeartDtlRepository {
  Future<FeatureModel?> loadHrDataForDate(String yyyyMMdd);
}