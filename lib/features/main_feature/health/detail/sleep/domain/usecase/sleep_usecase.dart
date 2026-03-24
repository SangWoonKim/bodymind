import 'package:bodymind/core/storage/feature_model/feature_model.dart';
import 'package:bodymind/features/main_feature/health/detail/sleep/domain/entity/daily_sleep_info.dart';
import 'package:bodymind/features/main_feature/health/detail/sleep/domain/entity/sleep_analysis.dart';
import 'package:bodymind/features/main_feature/health/detail/sleep/domain/entity/sleep_stage.dart';
import 'package:bodymind/features/main_feature/health/detail/sleep/domain/entity/sleep_summary.dart';
import 'package:bodymind/features/main_feature/health/detail/sleep/domain/injector/sleep_analysis_injector.dart';
import 'package:bodymind/features/main_feature/health/detail/sleep/domain/repository/sleep_dtl_repository.dart';
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
        if ((e.feature as SleepModel).detailData.isNotEmpty)
          e.instDt: (() {
            final sleepData = e.feature as SleepModel;

            final details = [...sleepData.detailData]
              ..sort((a, b) => a.sleepStartTime.compareTo(b.sleepStartTime));

            final recognizedSleep =
                    sleepData.totalLightDuration +
                    sleepData.totalRemDuration +
                    sleepData.totalDeepDuration;

            final dailyData = DailySleepInfo(
              e.instDt,
              DateTime.fromMillisecondsSinceEpoch(details.first.sleepStartTime),
              DateTime.fromMillisecondsSinceEpoch(details.last.sleepEndTime),
              SleepAnalysisInjector.evaluateSleep(
                totalInBedMinutes: recognizedSleep,
                totalSleepMinutes: sleepData.totalDuration,
                totalAwakeMinutes: sleepData.totalAwakeDuration,
                totalLightMinutes: sleepData.totalLightDuration,
                totalDeepMinutes: sleepData.totalDeepDuration,
                totalRemMinutes: sleepData.totalRemDuration,
              ),
              SleepSummary(
                sleepData.totalDuration,
                sleepData.totalDeepDuration,
                sleepData.sleepScore,
                recognizedSleep,
              ),
              details
                  .map((d) => SleepStage(
                SleepType.convertInt(d.sleepType),
                d.sleepDuration,
              ))
                  .toList(),
            );

            return dailyData;
          })(),
    };
  }

}