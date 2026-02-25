import 'package:bodymind/core/storage/feature_model/feature_data/feature_data.dart';

class FeatureHr implements FeatureData{
  final String strtDt;
  final String endDt;
  final List<FeatureHrDtl> originData;
  final List<int> hrData;

  FeatureHr(this.strtDt, this.endDt, this.originData,this.hrData);
}

class FeatureHrDtl {
  final DateTime time;
  final int bpm;
  FeatureHrDtl(this.time, this.bpm);
}