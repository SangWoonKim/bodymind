import 'package:bodymind/core/health_module/health_service.dart';
import 'package:bodymind/core/storage/database/query/bodymind_database.dart';
import 'package:bodymind/core/storage/feature_model/feature_data/act/feature_act.dart';
import 'package:bodymind/core/storage/feature_model/feature_data/exercise/detail/feature_exercise_dtl.dart';
import 'package:bodymind/core/storage/feature_model/feature_data/exercise/feature_exercise.dart';
import 'package:bodymind/core/storage/feature_model/feature_data/hr/feature_hr.dart';
import 'package:bodymind/core/storage/feature_model/feature_data/sleep/detail/feature_sleep_dtl.dart';
import 'package:bodymind/core/storage/feature_model/feature_data/sleep/feature_sleep.dart';
import 'package:bodymind/core/storage/feature_model/feature_model.dart';
import 'package:bodymind/core/util/bodymind_core_util.dart';
import 'package:bodymind/features/main_feature/home/domain/repository/home_repository.dart';
import 'package:common_mutiple_health/entity/const/data_catalog.dart';
import 'package:common_mutiple_health/entity/const/permission_option.dart';
import 'package:common_mutiple_health/entity/model/base/base_dynamic_model.dart';
import 'package:common_mutiple_health/entity/model/base/base_model.dart';
import 'package:common_mutiple_health/entity/model/element/act_model.dart';
import 'package:common_mutiple_health/entity/model/element/exercise_model.dart';
import 'package:common_mutiple_health/entity/model/element/heartrate_model.dart';
import 'package:common_mutiple_health/entity/model/element/sleep_model.dart';
import 'package:collection/collection.dart';

class HomeRepositoryImpl extends HomeRepository{
  final HealthService healthService;
  final BodymindDatabase db;

  HomeRepositoryImpl(this.healthService, this.db);


  //healthService
  @override
  Future<List<FeatureModel>?> loadActData(int previousDays) async{
    final received = await healthService.loadData(previousDays, DataCatalog.Act);
    final data = received.body.resultObj as BaseDynamicModel;

    if(data.data != null){
      List<BaseModel> actModel = data.data!.where((e) => e.data!= null).toList();

      return actModel.map((e) {
        final element = e.data as ActModel?;
        String insrDt = TimeUtil.dateTimeToyymmdd(DateTime.fromMillisecondsSinceEpoch(e.baseStartTime!));
        String endDt = TimeUtil.dateTimeToyymmdd(DateTime.fromMillisecondsSinceEpoch(e.baseEndTime!));

        return FeatureModel(insrDt, FeatureAct(insrDt, endDt, element?.stepCount ?? 0, element?.distance ?? 0, element?.actCalories ?? 0));
      }).toList();
    }

    return null;
  }

  @override
  Future<List<FeatureModel>?> loadExerciseData(int previousDays) async{
    final received = await healthService.loadData(previousDays, DataCatalog.Exercise);
    final data =  received.body.resultObj as BaseDynamicModel;
    if(data.data != null){
      List<BaseModel> exModel = data.data!.where((e) => e.data != null).toList();

      Map<String, List<BaseModel>> groupedBaseDt = groupBy(exModel, (e) => TimeUtil.dateTimeToyymmdd(DateTime.fromMillisecondsSinceEpoch(e.baseStartTime!)));

      List<FeatureModel> groupCpt = List.empty(growable: true);

      groupedBaseDt.keys.forEach((e){
        double totalCalorie = 0;
        int totalDuration = 0;
        List<FeatureExerciseDtl?> baseExLst = groupedBaseDt[e]?.map((e) {

          final element = e.data as ExerciseModel?;

          if(element != null){
            String insrDt = TimeUtil.dateTimeToyymmdd(DateTime.fromMillisecondsSinceEpoch(e.baseStartTime!));
            String endDt = TimeUtil.dateTimeToyymmdd(DateTime.fromMillisecondsSinceEpoch(e.baseEndTime!));

            int duration = (e.baseEndTime! - e.baseStartTime!) * 1000;

            totalCalorie += element.calorie ;
            totalDuration = duration;

            List<String> normalizedHrLst = element.heartRateLst.map((e) => e.heartRate.toString()).toList();
            return FeatureExerciseDtl(insrDt, endDt, normalizedHrLst, element.exerciseType, '다음에 하자', element.count, element.distance, element.calorie, duration);
          }

        }).toList() ?? [];
        if(baseExLst.isNotEmpty){
          groupCpt.add(FeatureModel(e, FeatureExercise(totalDuration, totalCalorie, baseExLst)) );
        }
      });

      return groupCpt.isEmpty ? null : groupCpt;
    }

  }

  @override
  Future<List<FeatureModel>?> loadHeartData(int previousDays) async{
    final received = await healthService.loadData(previousDays, DataCatalog.Heart);
    final ex = received.body.resultObj;
    final data = received.body.resultObj as BaseDynamicModel;

    if(data.data != null){
      final hrModel =  data.data!.where((e) => e.data != null).toList();

      return hrModel.map((e) {
        final hrDtl = e.data as HeartRateModel?;

        return FeatureModel(
            TimeUtil.dateTimeToyymmdd(DateTime.fromMillisecondsSinceEpoch(e.baseStartTime!)),
            FeatureHr(
                TimeUtil.dateTimeToFullDt(DateTime.fromMillisecondsSinceEpoch(e.baseStartTime!)),
                TimeUtil.dateTimeToFullDt(DateTime.fromMillisecondsSinceEpoch(e.baseEndTime!)),
                hrDtl!.optimizedData??[]
            )
        );

      }).toList();
    }
    return null;

  }

  @override
  Future<List<FeatureModel>?> loadSleepData(int previousDays) async{
    final received = await healthService.loadData(previousDays, DataCatalog.Sleep);
    final data = received.body.resultObj as BaseDynamicModel;

    if(data.data != null){
      final sleepModel = data.data!.where((e) => e.data != null).toList();

      final returndData =  sleepModel.map((e){
        final sleepInfo = e.data as SleepModel?;

        if(sleepInfo != null){
          return FeatureModel(
            TimeUtil.dateTimeToyymmdd(DateTime.fromMillisecondsSinceEpoch(e.baseEndTime!)),
            FeatureSleep(
                TimeUtil.dateTimeToFullDt(DateTime.fromMillisecondsSinceEpoch(sleepInfo.detailData.first.sleepStartTime)) ,
                TimeUtil.dateTimeToFullDt(DateTime.fromMillisecondsSinceEpoch(sleepInfo.detailData.last.sleepEndTime)) ,
                sleepInfo.detailData.map((element) => FeatureSleepDtl(
                    'A',
                    TimeUtil.dateTimeToFullDt(DateTime.fromMillisecondsSinceEpoch(element.sleepStartTime)),
                    TimeUtil.dateTimeToFullDt(DateTime.fromMillisecondsSinceEpoch(element.sleepEndTime)),
                    element.sleepDuration)
                ).toList(),
                sleepInfo.totalDeepDuration + sleepInfo.totalRemDuration + sleepInfo.totalLightDuration,
                sleepInfo.totalDuration,
                sleepInfo.totalAwakeDuration,
                sleepInfo.totalLightDuration,
                sleepInfo.totalRemDuration,
                sleepInfo.totalDeepDuration
            ),
          );
        }
      }).toList();
    }

  }

  @override
  Future<void> requestPermission() async{
    await healthService.requestPermission(PermissionOption.All, []);
    return;
  }



}