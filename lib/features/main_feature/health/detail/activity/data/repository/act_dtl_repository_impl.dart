import 'package:bodymind/core/storage/database/query/bodymind_database.dart';
import 'package:bodymind/core/storage/feature_model/feature_data/act/feature_act.dart';
import 'package:bodymind/core/storage/feature_model/feature_data/feature_data.dart';
import 'package:bodymind/core/storage/feature_model/feature_model.dart';
import 'package:bodymind/features/main_feature/health/detail/activity/domain/repository/act_dtl_repository.dart';

class ActDtlRepositoryImpl extends ActDtlRepository{
  final BodymindDatabase db;

  ActDtlRepositoryImpl(this.db);

  @override
  Future<List<FeatureModel>?> loadActDataForDate(String yyyyMMdd) async{
    List<TbFeatureActInfoData> result = await db.selectFeatureAct().get();
    if(result.isEmpty) return null;
   return result.map((e) => FeatureModel(e.isrtDt!, FeatureAct('000000', '235959',e.stepCount,e.calorie,e.distance))).toList();
  }

}