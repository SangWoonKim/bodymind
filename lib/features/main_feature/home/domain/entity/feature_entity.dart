import 'package:bodymind/features/main_feature/home/domain/entity/home_feature_entity.dart';
import 'package:common_mutiple_health/entity/const/data_catalog.dart';

class FeatureEntity{
  final DataCatalog category;
  final List<HomeFeatureEntity>? featureLst;

  FeatureEntity({
    required this.category,
    this.featureLst
  });
}