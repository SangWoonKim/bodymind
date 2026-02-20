import 'package:common_mutiple_health/entity/common_mutiple_health_impl.dart';
import 'package:common_mutiple_health/entity/const/data_catalog.dart';
import 'package:common_mutiple_health/entity/const/permission_mapper.dart';
import 'package:common_mutiple_health/entity/const/permission_option.dart';
import 'package:common_mutiple_health/entity/const/platform_result.dart';


class HealthService{
  late final CommonMutipleHealthInterface healthModule;

  HealthService(){
    healthModule = CommonMutipleHealthInterface();
  }

  Future<PlatformResult> loadAllData(int previousDays) async{
    PlatformResult receivedData = await healthModule.loadAllData(previousDays);
    return receivedData;
  }

  Future<PlatformResult> loadData(int previousDays, DataCatalog feature) async{
    PlatformResult receivedData = await healthModule.loadData(previousDays, feature);
    return receivedData;
  }

  Future<PlatformResult> requestPermission(PermissionOption option, List<PermissionMapper> permissions) async{
    PlatformResult receivedData = await healthModule.requestPermission(option, permissions);
    return receivedData;
  }

}



