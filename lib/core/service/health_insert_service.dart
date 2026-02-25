import 'dart:async';
import 'dart:convert';

import 'package:bodymind/core/service/repository/health_repository.dart';
import 'package:bodymind/core/service/util/insert_formatter.dart';
import 'package:bodymind/core/storage/database/query/bodymind_database.dart';
import 'package:bodymind/core/storage/database/query/bodymind_extension.dart';
import 'package:bodymind/core/storage/feature_model/feature_data/act/feature_act.dart';
import 'package:bodymind/core/storage/feature_model/feature_data/hr/feature_hr.dart';
import 'package:bodymind/core/util/bodymind_core_util.dart';
import 'package:common_mutiple_health/entity/const/data_catalog.dart';
import 'package:drift/drift.dart';

import '../../features/main_feature/home/domain/entity/feature_entity.dart';
import '../../features/main_feature/home/domain/entity/home_feature_entity.dart';
import '../storage/feature_model/feature_data/exercise/detail/feature_exercise_dtl.dart';
import '../storage/feature_model/feature_data/exercise/feature_exercise.dart';
import '../storage/feature_model/feature_data/sleep/feature_sleep.dart';
import '../storage/feature_model/feature_model.dart';

class HealthInsertService {
  HealthInsertService._(this._repo, this._db);
  static HealthInsertService? _instance;

  final HealthRepository _repo;
  final BodymindDatabase _db;
  Timer? _refreshTimer;
  bool _isRunning = false;
  DateTime? _recentRunDt;

  final _doneController = StreamController<DateTime>.broadcast();
  Stream<DateTime> get onSyncDone => _doneController.stream;

  static HealthInsertService init({
    required HealthRepository repo,
    required BodymindDatabase db,
  }) {
    _instance ??= HealthInsertService._(repo, db);
    return _instance!;
  }


  void runService(){
    if(_isRunning) return;
    _isRunning = true;

    _refreshTimer = Timer.periodic(Duration(minutes: 10), (_) async{
      await runTimer();
    });
  }

  void pauseService() {
    _refreshTimer?.cancel();
    _refreshTimer = null;
    _isRunning = false;
    _doneController.close();
  }

  Future<void> runTimer() async {
    final now = DateTime.now();
    if (_recentRunDt != null &&
        now.difference(_recentRunDt!) < const Duration(minutes: 10)) {
      return;
    }
    _recentRunDt = now;

    await insertData();

    _doneController.add(DateTime.now());
  }


  Future<void> insertData() async{
    await _repo.requestPermission();
    List<FeatureModel> actData = List.empty(growable: true);
    List<FeatureModel> hrData = List.empty(growable: true);
    List<FeatureModel> slpData = List.empty(growable: true);
    List<FeatureModel> exData = List.empty(growable: true);

    final recvCompleter = Completer<bool>();
    Stream<FeatureEntity> recvDataStm =  _selectAllParallelEmitAsDone(7);
    recvDataStm.listen((data) {
      switch(data.category){

        case DataCatalog.Act:
          for (final e in data.featureLst ?? const []) {
            final data = e.featureData;
            if (data != null) actData.add(data);
          }
          break;
        case DataCatalog.Exercise:
          for (final e in data.featureLst ?? const []) {
            final data = e.featureData;
            if (data != null) exData.add(data);
          }
          break;
        case DataCatalog.Heart:
          for (final e in data.featureLst ?? const []) {
            final data = e.featureData;
            if (data != null) hrData.add(data);
          }
          break;
        case DataCatalog.Sleep:
          for (final e in data.featureLst ?? const []) {
            final data = e.featureData;
            if (data != null) slpData.add(data);
          }
          break;
      }
    }).onDone((){
      recvCompleter.complete(true);
    });

    if(await recvCompleter.future == true){
      await _savedActData(actData);
      await _savedHeartData(hrData, 30);
      await _savedExerciseData(exData);
      await _savedSleepData(slpData);
    }


  }

  Stream<FeatureEntity> _selectAllParallelEmitAsDone(int previousDays) {
    final controller = StreamController<FeatureEntity>();
    var remaining = 4;

    void done() {
      remaining--;
      if (remaining == 0) controller.close();
    }

    void emitFeature(DataCatalog catalog, Future<List<FeatureModel>?> future) {
      future
          .then((model) {
        controller.add(
          FeatureEntity(
            category: catalog,
            featureLst: _toFeatureList(catalog, model),
          ),
        );
      })
          .catchError(controller.addError)
          .whenComplete(done);
    }

    emitFeature(DataCatalog.Act, _repo.loadActData(previousDays));
    emitFeature(DataCatalog.Heart, _repo.loadHeartData(previousDays));
    emitFeature(DataCatalog.Sleep, _repo.loadSleepData(previousDays));
    emitFeature(DataCatalog.Exercise, _repo.loadExerciseData(previousDays));

    return controller.stream;
  }

  List<HomeFeatureEntity> _toFeatureList(
      DataCatalog catalog,
      List<FeatureModel>? model,
      ) {

    if (model == null) return const [];
    return model.map((e) {
      return HomeFeatureEntity(feature: catalog, featureData: e);
    }).toList();
  }


  Future<void> _savedActData(List<FeatureModel> actModel) async{
    await Future.forEach(actModel, (FeatureModel act) async{
      final data = act.feature as FeatureAct;
      await _db.insertFeatureActInfo(data.strtDt, data.stepCount, data.distance, data.calorie);
    });
  }

  Future<void> _savedExerciseData(List<FeatureModel> exModels) async {
    await Future.forEach(exModels, (FeatureModel ex) async {
      final data = ex.feature as FeatureExercise;
      await _insertAsyncEx(ex.instDt, data.featureData);
    });
  }

  Future<void> _savedHeartData(List<FeatureModel> hrModel, int age) async{

    await Future.forEach(hrModel, (FeatureModel hr) async{
      final formatter = InsertFormatter();
      final data = hr.feature as FeatureHr;
      final restBase = formatter.restProxy(data.hrData);
      final varBase = formatter.varProxy(data.hrData);
      final highBase = formatter.highMinutes(data.hrData, age);
      await _db.insertFeatureHrInfo(data.strtDt, jsonEncode(formatter.toMinuteMedianSeries(data.originData,TimeUtil.yyyyMMddToDateTime(data.strtDt))));
      await _db.insertHrProxy(data.strtDt, restBase, varBase, highBase.toDouble());
    });

  }

  Future<void> _savedSleepData(List<FeatureModel> slpModels) async{
    await Future.forEach(slpModels, (FeatureModel info) async{
      final data = info.feature as FeatureSleep;
      await _db.insertFeatureSleep(
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

        return _db.insertFeatureExercise(info: info, hrList: hrList);
      }
    });

  }
}