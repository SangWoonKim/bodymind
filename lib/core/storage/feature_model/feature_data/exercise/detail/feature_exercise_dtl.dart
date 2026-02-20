
import 'package:common_mutiple_health/entity/const/exercise_classfiy.dart';

class FeatureExerciseDtl {
  final String strtDt;
  final String endDt;
  final List<String> hrLst;
  final ExerciseClassify exerciseType;
  final String metricKind;
  final int metricVal;
  final double distance;
  final double calorie;
  final int duration;

  FeatureExerciseDtl(this.strtDt, this.endDt, this.hrLst, this.exerciseType,
      this.metricKind, this.metricVal, this.distance, this.calorie, this.duration);
}