import 'package:bodymind/features/onboard/domain/repository/onboard_repository.dart';

import '../entity/onboard_info.dart';

class OnboardUseCase {
  final OnboardRepository repository;

  OnboardUseCase(this.repository);
  Future<OnboardInfo> getOnboardInfo() => repository.selectOnboardInfo();
}