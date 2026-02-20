import 'package:bodymind/core/storage/database/query/bodymind_database.dart';
import 'package:drift/drift.dart';

import '../../feature_model/feature_data/sleep/detail/feature_sleep_dtl.dart';

extension BodymindExtension on BodymindDatabase{
  Future<int> insertFeatureExercise({
    required TbFeatureExerciseInfoCompanion info,
    required TbFeatureExerciseHrCompanion hrList,
  }) async {
    // 전체 과정을 하나의 트랜잭션으로 묶습니다.
    return await transaction(() async {
      // 1. 운동 세션 insert 후 자동 생성된 ID(row_sn)를 받아옵니다.
      final exSn = await into(tbFeatureExerciseInfo).insert(info);

      // 2. 심박수 데이터를 반복문으로 insert 합니다.

      // 받아온 exSn을 자식 데이터에 주입
      await into(tbFeatureExerciseHr).insert(
        hrList.copyWith(exSn: Value(exSn)),
      );
      return exSn;
    });
  }



  Future<int> insertFeatureSleep({
    required String baseDate, // 'YYYY-MM-DD'
    String? startAt,
    String? endAt,
    required int totalInbedM,
    required int totalSlpM,
    required int totalAwakeM,
    required int totalLightM,
    required int totalDeepM,
    required int totalRemM,
    required List<FeatureSleepDtl> segments,
  }) async {
    return transaction(() async {
      // 1) base_date로 기존 row 확인
      final existing = await (select(tbFeatureSleepInfo)
        ..where((t) => t.baseDate.equals(baseDate)))
          .getSingleOrNull();

      late final int slpSn;

      if (existing == null) {
        // 2-A) 없으면 insert -> 생성된 PK(slp_sn) 반환
        slpSn = await into(tbFeatureSleepInfo).insert(
          TbFeatureSleepInfoCompanion.insert(
            baseDate: baseDate,
            startAt: Value(startAt),
            endAt: Value(endAt),
            totalInbedM: totalInbedM,
            totalSlpM: totalSlpM,
            totalAwakeM: totalAwakeM,
            totalLightM: totalLightM,
            totalDeepM: totalDeepM,
            totalRemM: totalRemM,
          ),
        );
      } else {
        // 2-B) 있으면 update (PK 유지)
        slpSn = existing.slpSn;

        await (update(tbFeatureSleepInfo)..where((t) => t.slpSn.equals(slpSn)))
            .write(
          TbFeatureSleepInfoCompanion(
            startAt: Value(startAt),
            endAt: Value(endAt),
            totalInbedM: Value(totalInbedM),
            totalSlpM: Value(totalSlpM),
            totalAwakeM: Value(totalAwakeM),
            totalLightM: Value(totalLightM),
            totalDeepM: Value(totalDeepM),
            totalRemM: Value(totalRemM),
          ),
        );
      }

      // 3) detail 전체 교체(가장 단순/안전)
      await (delete(tbFeatureSleepDetail)
        ..where((d) => d.slpSn.equals(slpSn)))
          .go();

      if (segments.isNotEmpty) {
        await batch((b) {
          b.insertAll(
            tbFeatureSleepDetail,
            segments.map((s) {
              return TbFeatureSleepDetailCompanion.insert(
                slpSn: slpSn,
                stage: s.stage,
                startAt: s.strtDt,
                endAt: s.endDt,
                durationM: s.duration,
              );
            }).toList(),
          );
        });
      }

      return slpSn;
    });
  }

}