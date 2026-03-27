import 'package:bodymind/core/storage/feature_model/feature_data/sleep/feature_sleep.dart';
import 'package:bodymind/core/storage/feature_model/feature_model.dart';
import 'package:bodymind/core/util/bodymind_core_util.dart';
import 'package:bodymind/features/main_feature/health/detail/sleep/domain/entity/daily_sleep_info.dart';
import 'package:bodymind/features/main_feature/health/detail/sleep/domain/entity/sleep_analysis.dart';
import 'package:bodymind/features/main_feature/health/detail/sleep/domain/entity/sleep_stage.dart';
import 'package:bodymind/features/main_feature/health/detail/sleep/domain/entity/sleep_summary.dart';
import 'package:bodymind/features/main_feature/health/detail/sleep/domain/injector/sleep_analysis_injector.dart';
import 'package:bodymind/features/main_feature/health/detail/sleep/domain/repository/sleep_dtl_repository.dart';
import 'package:bodymind/features/main_feature/home/presentation/viewmodel/injector/home_sleep_injector.dart';
import 'package:common_mutiple_health/entity/model/element/sleep_model.dart';

import '../entity/sleep_type.dart';

class SleepUsecase {

  final SleepDtlRepository repository;

  SleepUsecase(this.repository);

  Future<Map<String, DailySleepInfo>?> loadDbSleepInfo(String stYmd,
      endYmd) async {
    List<FeatureModel>? recvDatas = await repository.loadSleepDbForDate(
        stYmd, endYmd);

    return {
      for (final e in recvDatas ?? <FeatureModel>[])
        if ((e.feature as FeatureSleep).detail.isNotEmpty)
          e.instDt: (() {
            final sleepData = e.feature as FeatureSleep;

            final details = [...sleepData.detail]..sort((a,b) => TimeUtil.yyyyMMddHHmmToDateTime(a.strtDt).compareTo(TimeUtil.yyyyMMddHHmmToDateTime(b.strtDt)));
            // final details = [...sleepData.detailData]
            //   ..sort((a, b) => a.sleepStartTime.compareTo(b.sleepStartTime));

            final recognizedSleep =
                    sleepData.totalLightM+
                    sleepData.totalRemM +
                    sleepData.totalDeepM;

            final dailyData = DailySleepInfo(
              e.instDt,
              TimeUtil.yyyyMMddHHmmToDateTime(details.first.strtDt),
              TimeUtil.yyyyMMddHHmmToDateTime(details.last.endDt),
              SleepAnalysisInjector.evaluateSleep(
                totalInBedMinutes: recognizedSleep,
                totalSleepMinutes: sleepData.totalSlpM,
                totalAwakeMinutes: sleepData.totalAwakeM,
                totalLightMinutes: sleepData.totalLightM,
                totalDeepMinutes: sleepData.totalDeepM,
                totalRemMinutes: sleepData.totalRemM,
              ),
              SleepSummary(
                sleepData.totalSlpM,
                sleepData.totalDeepM,
                sleepData.totalAwakeM,
                sleepData.totalRemM,
                sleepData.totalLightM,
                HomeSleepInjector().calSleepScore(
                    lightMin: sleepData.totalLightM,
                    remMin: sleepData.totalRemM,
                    deepMin: sleepData.totalDeepM,
                    awakeMin: sleepData.totalAwakeM
                ),
                recognizedSleep,
              ),
              details
                  .map((d) => SleepStage(
                SleepType.convertStr(d.stage),
                d.duration,
              ))
                  .toList(),
            );

            return dailyData;
          })(),
    };
  }

}