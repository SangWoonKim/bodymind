import 'package:bodymind/core/storage/feature_model/feature_data/exercise/detail/feature_exercise_dtl.dart';
import 'package:bodymind/core/storage/feature_model/feature_data/feature_data.dart';

class FeatureExercise extends FeatureData{
  final int totalDuration;
  final double totalCalorie;
  final List<FeatureExerciseDtl?> featureData;

  FeatureExercise(this.totalDuration,this.totalCalorie, this.featureData);
}