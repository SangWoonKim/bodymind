import '../../../../../../../core/storage/feature_model/feature_model.dart';

abstract class ExDtlRepository {
  Future<List<FeatureModel>?> loadDbExDataForDate(String stYmd, String endYmd);
}