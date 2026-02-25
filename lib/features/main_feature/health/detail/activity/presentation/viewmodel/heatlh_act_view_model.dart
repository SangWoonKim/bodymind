import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActDtlState{
  int mainScore;
  bool isStepGraph;
  bool isWeekly;
  String mainScoreEvaluation;
  List<ActGraphData> actDatas;

}

class HeatlhActViewModel extends Notifier {}