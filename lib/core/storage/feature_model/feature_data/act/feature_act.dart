import 'package:bodymind/core/storage/feature_model/feature_data/feature_data.dart';

class FeatureAct implements FeatureData{
  final String strtDt;
  final String endDt;
  final int stepCount;
  final double distance;
  final double calorie;

  FeatureAct(
      this.strtDt,
      this.endDt,
      this.stepCount,
      this.distance,
      this.calorie);
}