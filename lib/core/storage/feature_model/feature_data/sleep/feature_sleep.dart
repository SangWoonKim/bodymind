import 'package:bodymind/core/storage/feature_model/feature_data/feature_data.dart';

import 'detail/feature_sleep_dtl.dart';

class FeatureSleep implements FeatureData{
  final String strtDt;
  final String endDt;
  final List<FeatureSleepDtl> detail;
  final int totalInbedM;
  final int totalSlpM;
  final int totalAwakeM;
  final int totalLightM;
  final int totalRemM;
  final int totalDeepM;

  FeatureSleep(this.strtDt, this.endDt, this.detail, this.totalInbedM,
      this.totalSlpM, this.totalAwakeM, this.totalLightM, this.totalRemM,
      this.totalDeepM);


}