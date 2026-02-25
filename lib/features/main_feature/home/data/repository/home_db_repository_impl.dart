import 'dart:convert';

import 'package:bodymind/core/storage/database/query/bodymind_database.dart';
import 'package:bodymind/core/storage/database/query/bodymind_extension.dart';
import 'package:bodymind/core/storage/feature_model/feature_data/act/feature_act.dart';
import 'package:bodymind/core/storage/feature_model/feature_data/exercise/detail/feature_exercise_dtl.dart';
import 'package:bodymind/core/storage/feature_model/feature_data/exercise/feature_exercise.dart';
import 'package:bodymind/core/storage/feature_model/feature_data/hr/feature_hr.dart';
import 'package:bodymind/core/storage/feature_model/feature_data/sleep/detail/feature_sleep_dtl.dart';
import 'package:bodymind/core/storage/feature_model/feature_data/sleep/feature_sleep.dart';
import 'package:bodymind/core/util/bodymind_core_util.dart';
import 'package:bodymind/features/main_feature/home/domain/repository/home_db_repository.dart';
import 'package:common_mutiple_health/entity/const/exercise_classfiy.dart';
import 'package:collection/collection.dart';
import 'package:drift/drift.dart';

import '../../../../../core/storage/feature_model/feature_model.dart';

class HomeDbRepositoryImpl extends HomeDbRepository{
  final BodymindDatabase db;

  HomeDbRepositoryImpl(this.db);

  @override
  Future<List<FeatureModel>?> loadSavedActData(int previousDays) async{
    List<TbFeatureActInfoData> actInfo = await db.selectFeatureAct().get();
    List<FeatureModel> returnedData = actInfo.where(
            (e) => e.isrtDt != null)
        .map(
            (e) => FeatureModel(e.isrtDt!, FeatureAct('000000', '235959', e.stepCount, e.distance, e.calorie)
            )
    ).toList();
    return returnedData.isEmpty ? null : returnedData;
  }

  @override
  Future<List<FeatureModel>?> loadSavedExerciseData(int previousDays) async{
    List<SelectFeatureExerciseResult> exInfo = await db.selectFeatureExercise().get();
    Map<String,List<SelectFeatureExerciseResult>> groupedExBaseDate = groupBy(exInfo, (e) => e.baseDate);


    List<FeatureModel> returnedData = List.empty(growable: true);

    for(final exBaseDate in groupedExBaseDate.entries){
      Map<int,List<SelectFeatureExerciseResult>> groupedExSn = groupBy(exBaseDate.value, (e) => e.exSn);
      List<FeatureExerciseDtl> dtlLst = List.empty(growable: true);

      double dtlTotCal = 0;
      int dtlTotDuration = 0;
      groupedExSn.keys.forEach((e) {
        List<String>? hrLst = groupedExSn[e]?.asMap().values.map((dtl) => dtl.hrLst.toString()).toList();
        if(hrLst != null){
          SelectFeatureExerciseResult dtlInfo = groupedExSn[e]!.first;

          int duration = TimeUtil.hhmmToMinute(dtlInfo.endHhmm) - TimeUtil.hhmmToMinute(dtlInfo.startHhmm);

          dtlTotDuration += duration;
          dtlTotCal += dtlTotCal;

          dtlLst.add(
              FeatureExerciseDtl(
                  dtlInfo.startHhmm, dtlInfo.endHhmm, hrLst,
                  ExerciseClassify.fromValue(dtlInfo.type) ,
                  dtlInfo.metricKind, dtlInfo.metricVal.toInt(),
                  dtlInfo.distance, dtlInfo.calorie,duration)
          );
        }
      });

      returnedData.add(FeatureModel(exBaseDate.key, FeatureExercise(dtlTotDuration,dtlTotCal,dtlLst)));
    }

    return returnedData.isEmpty ? null : returnedData;


  }

  @override
  Future<List<FeatureModel>?> loadSavedHeartData(int previousDays) async{
    List<TbFeatureHrInfoData> hrInfo = await db.selectFeatureHr('-$previousDays days').get();
    List<FeatureModel>? returnedData = hrInfo.where(
            (e) => e.isrtDt != null
    ).map(
            (e) {
              List<int> hrLst =  List<int>.from(jsonDecode(e.hrLst) as List);
              String? strtDt = hrLst.asMap().entries.skip(1).where((e) => hrLst[e.key -1] == 0 && e.value != 0)
                  .map(
                      (e){
                        final hh = (e.key ~/ 60) % 24;
                        final mm = e.key % 60;
                        return '${hh.toString().padLeft(2, '0')}${mm.toString().padLeft(2, '0')}';
                      }
                      ).firstOrNull;
              return FeatureModel(e.isrtDt!, FeatureHr(strtDt ?? '000000','235959',[],hrLst));
            }
        ).toList();
    
    return returnedData.isEmpty ? null : returnedData;
  }

  @override
  Future<List<FeatureModel>?> loadSavedSleepData(int previousDays) async{
    List<SelectFeatureSleepInfoResult?> sleepInfo = await db.selectFeatureSleepInfo().get();
    List<SelectFeatureSleepSegmentaionResult> sleepDtl = await db.selectFeatureSleepSegmentaion().get();
    Map<String, List<SelectFeatureSleepSegmentaionResult>> groupedSleepDtl = groupBy(sleepDtl, (SelectFeatureSleepSegmentaionResult obj) => obj.baseDate);

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



  

