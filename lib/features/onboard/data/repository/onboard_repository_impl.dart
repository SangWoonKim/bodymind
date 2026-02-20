import 'package:bodymind/core/storage/database/query/bodymind_database.dart';
import 'package:bodymind/features/onboard/domain/entity/onboard_info.dart';
import 'package:bodymind/features/user/domain/entity/user_info.dart';

import '../../domain/repository/onboard_repository.dart';
import '../../domain/entity/on_board_detail.dart';

class OnboardRepositoryImpl implements OnboardRepository{
  final BodymindDatabase remote;

  OnboardRepositoryImpl(this.remote);

  @override
  Future<OnboardInfo> selectOnboardInfo() async{

    String? isComplete = await remote.selectOnboardStatus().getSingleOrNull();

    return OnboardInfo(
      isComplete: isComplete == null ? false :
                  isComplete == 'y' ? true : false,
    );
  }

  @override
  Future<void> insertOnboardInfo(OnboardInfo onboardInfo) async{
    await remote.insertOnboardStatus(0,onboardInfo.isComplete ? 'y' : 'n');
  }
}