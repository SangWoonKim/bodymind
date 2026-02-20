import 'package:bodymind/core/storage/database/query/bodymind_database.dart';
import 'package:bodymind/core/storage/feature_model/feature_data/hr/feature_hr.dart';
import 'package:bodymind/core/storage/feature_model/feature_model.dart';

import '../../domain/repository/heart_dtl_repository.dart';

class HeartDtlRepositoryImpl extends HeartDtlRepository {
  final BodymindDatabase db;

  HeartDtlRepositoryImpl(this.db);

  @override
  Future<FeatureModel?> loadHrDataForDate(String yyyyMMdd) async{
    TbFeatureHrInfoData? hrInfo = await db.selectHrDtlForDate(yyyyMMdd).getSingleOrNull();
    if(hrInfo == null) return null;
    return FeatureModel(hrInfo.isrtDt!, FeatureHr('000000','235959',hrInfo.hrLst.split(',').map((e) => int.parse(e)).toList()));
  }
  
}