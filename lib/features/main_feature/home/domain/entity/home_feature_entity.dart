import 'package:bodymind/core/storage/feature_model/feature_data/feature_data.dart';
import 'package:common_mutiple_health/entity/const/data_catalog.dart';
import 'package:common_mutiple_health/entity/model/base/base_model.dart';
import 'package:common_mutiple_health/entity/model/base/base_time_model.dart';

import '../../../../../core/storage/feature_model/feature_model.dart';

class HomeFeatureEntity {
  final DataCatalog feature;
  final FeatureModel? featureData;

  const HomeFeatureEntity({
    required this.feature,
    this.featureData,
  });
}