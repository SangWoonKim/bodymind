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
        List<String>? hrLst = groupedExSn[e]?.asMap().values.map((dtl) => dtl.hr.toString()).toList();
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
              List<int> hrLst = e.hrLst.split(',').map((e) => int.parse(e)).toList();
              String? strtDt = hrLst.asMap().entries.skip(1).where((e) => hrLst[e.key -1] == 0 && e.value != 0)
                  .map(
                      (e){
                        final hh = (e.key ~/ 60) % 24;
                        final mm = e.key % 60;
                        return '${hh.toString().padLeft(2, '0')}${mm.toString().padLeft(2, '0')}';
                      }
                      ).firstOrNull;
              return FeatureModel(e.isrtDt!, FeatureHr(strtDt ?? '000000','235959',hrLst));
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

  @override
  Future<void> savedActData(String isrtDt, int stepCount, double distance, double calorie) async{
    await db.insertFeatureActInfo(isrtDt, stepCount, distance, calorie);
  }

  @override
  Future<void> savedExerciseData(List<FeatureModel> exModels) async {
    await Future.forEach(exModels, (FeatureModel ex) async {
      final data = ex.feature as FeatureExercise;
      await _insertAsyncEx(ex.instDt, data.featureData);
    });
  }

  @override
  Future<void> savedHeartData(String isrtDt, List<int> hrLst, double restBase, double varBase, double highBase) async{
    StringBuffer hrStrBuff = StringBuffer();
    String hrStr = '';
    for(int hr in hrLst){
      hrStrBuff.write('$hr,');
    }

    hrStr = hrStrBuff.toString();

    if (hrStr.endsWith(',')) {
      hrStrBuff
        ..clear()
        ..write(hrStr.substring(0, hrStr.length - 1));
    }

    await db.insertFeatureHrInfo(isrtDt, hrStr);
    await db.insertHrProxy(isrtDt, restBase, varBase, highBase);

  }

  @override
  Future<void> savedSleepData(List<FeatureModel> slpModels) async{
    await Future.forEach(slpModels, (FeatureModel info) async{
      final data = info.feature as FeatureSleep;
      await db.insertFeatureSleep(
          baseDate: info.instDt,
          totalInbedM: data.totalInbedM,
          totalSlpM: data.totalSlpM,
          totalAwakeM: data.totalAwakeM,
          totalLightM: data.totalLightM,
          totalDeepM: data.totalDeepM,
          totalRemM: data.totalRemM,
          segments: data.detail);
    });

  }

  Future<void> _insertAsyncEx(String instDt, List<FeatureExerciseDtl?> exDtls) async{
    return await Future.forEach(exDtls, (FeatureExerciseDtl? dtl) async{
      if(dtl != null){
        final info = TbFeatureExerciseInfoCompanion.insert(
            baseDate: instDt,
            type: dtl.exerciseType.value ,
            metricKind: dtl.metricKind,
            metricVal: dtl.metricVal.toDouble(),
            distance: dtl.distance,
            calorie: dtl.calorie,
            startHhmm: dtl.strtDt,
            endHhmm: dtl.endDt);
        final hrList = TbFeatureExerciseHrCompanion.insert(exSn:Value(0), hrLst: jsonEncode(dtl.hrLst), stepSec: 5);

        return db.insertFeatureExercise(info: info, hrList: hrList);
      }
    });

  }
}



  

