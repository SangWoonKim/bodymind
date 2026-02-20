import 'package:bodymind/core/storage/feature_model/feature_data/hr/feature_hr.dart';
import 'package:bodymind/core/storage/feature_model/feature_model.dart';
import 'package:bodymind/features/main_feature/health/detail/heartrate/domain/repository/heart_dtl_repository.dart';
import 'package:bodymind/features/main_feature/health/detail/util/feature_util.dart';

import '../entity/heart_dtl_dto.dart';

class HeartDtlUsecase {
  final HeartDtlRepository repository;
  HeartDtlUsecase(this.repository);
  
  Future<HeartDtlDto?> loadDbHrData(String yyyyMMdd) async{
    FeatureModel? hrModels = await repository.loadHrDataForDate(yyyyMMdd);
    if(hrModels == null) return null;
    final hrData = hrModels.feature as FeatureHr;
    if(hrData.hrData.isEmpty) return null;
    final hrLst = hrData.hrData;

    return HeartDtlDto(
        hrLst.featureAvg().toInt(),
        hrLst.featureMin().toInt(),
        hrLst.featureMax().toInt(),
        hrLst,
        hrModels.instDt);
  }
}