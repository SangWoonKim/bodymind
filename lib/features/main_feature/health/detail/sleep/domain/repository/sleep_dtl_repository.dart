import '../../../../../../../core/storage/feature_model/feature_model.dart';

abstract class SleepDtlRepository{
  Future<List<FeatureModel>?> loadSleepDbForDate(String stYmd, endYmd);
}