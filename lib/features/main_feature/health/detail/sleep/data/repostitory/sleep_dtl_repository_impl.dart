import 'package:bodymind/core/storage/database/query/bodymind_database.dart';
import 'package:bodymind/features/main_feature/health/detail/sleep/domain/repository/sleep_dtl_repository.dart';
import 'package:collection/collection.dart';

import '../../../../../../../core/storage/feature_model/feature_data/sleep/detail/feature_sleep_dtl.dart';
import '../../../../../../../core/storage/feature_model/feature_data/sleep/feature_sleep.dart';
import '../../../../../../../core/storage/feature_model/feature_model.dart';

class SleepDtlRepositoryImpl extends SleepDtlRepository{
  final BodymindDatabase db;

  SleepDtlRepositoryImpl(this.db);

  @override
  Future<List<FeatureModel>?> loadSleepDbForDate(String stYmd, endYmd) async {
    List<SelectFeatureSleepInfoForDateResult> sleepInfo = await db.selectFeatureSleepInfoForDate(stYmd, endYmd).get();
    List<SelectFeatureSleepSegmentaionForDateResult> sleepDtl = await db.selectFeatureSleepSegmentaionForDate(stYmd, endYmd).get();
    Map<String, List<SelectFeatureSleepSegmentaionForDateResult>> groupedSleepDtl = groupBy(sleepDtl, (SelectFeatureSleepSegmentaionForDateResult sleep) => sleep.baseDate);

    List<FeatureModel>? retunedData = sleepInfo.where((e) => e != null).map(
            (e) {
          final stages = groupedSleepDtl[e!.baseDate];
          return FeatureModel(e.baseDate,
              FeatureSleep(
                  stages!.first.segStart,
                  stages.first.segEnd,
                  stages.map((dtl) => FeatureSleepDtl(dtl.stage, dtl.segStart, dtl.segEnd, dtl.durationM)).toList(),
                  e.deepM! + e.remM! + e.lightM!,
                  e.totalM!,
                  e.awakeM!,
                  e.lightM!,
                  e.remM!,
                  e.deepM!
              )
          );
        }
    ).toList();

    return retunedData.isEmpty ? null : retunedData;
  }

}