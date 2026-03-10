import 'package:bodymind/core/storage/feature_model/feature_data/exercise/detail/feature_exercise_dtl.dart';
import 'package:bodymind/core/storage/feature_model/feature_data/feature_data.dart';

class FeatureExercise extends FeatureData{
  final DateTime strtYmd;
  final int totalDuration;
  final double totalCalorie;
  final double totalDistance;
  final List<FeatureExerciseDtl?> featureData;

  FeatureExercise(this.strtYmd, this.totalDuration,this.totalCalorie, this.totalDistance, this.featureData);
}