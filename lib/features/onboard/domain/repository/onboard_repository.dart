import '../entity/onboard_info.dart';

abstract class OnboardRepository{
  Future<OnboardInfo> selectOnboardInfo();
  Future<void> insertOnboardInfo(OnboardInfo onboardInfo);
}