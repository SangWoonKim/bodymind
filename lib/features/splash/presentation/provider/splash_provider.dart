import 'dart:async';

import 'package:bodymind/core/storage/db_provider.dart';
import 'package:bodymind/features/onboard/data/repository/onboard_repository_impl.dart';
import 'package:bodymind/features/onboard/domain/repository/onboard_repository.dart';
import 'package:bodymind/features/user/presentation/provider/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/storage/database/query/bodymind_database.dart';

final onboardRepoProvider = Provider<OnboardRepository>((ref){
  final db = ref.read(dbProvider);
  return OnboardRepositoryImpl(db);
});

final appStartProvider = AsyncNotifierProvider<AppStartNotifier, AppStartState>(
  AppStartNotifier.new
);

class AppStartNotifier extends AsyncNotifier<AppStartState>{
  @override
  FutureOr<AppStartState> build() async {
    print("AppStartNotifier build start");

    final onboard = ref.read(onboardRepoProvider);
    final user = ref.read(userRepositoryProvider);

    try {
      final isUserRegistered = await user.selectUserInfo();
      final isOnboard = await onboard.selectOnboardInfo()
          .timeout(const Duration(seconds: 5));


      print("selectOnboardInfo result = ${isOnboard.isComplete}");
      return AppStartState(isOnboarded: isOnboard.isComplete == true, isUserRegistered: isUserRegistered != null);
    } catch (e, st) {
      print("AppStartNotifier error: $e");
      print(st);
      return AppStartState(isOnboarded: false, isUserRegistered: false); // 혹은 rethrow
    }
  }

}

class AppStartState{
  final bool isOnboarded;
  final bool isUserRegistered;

  const AppStartState({
    required this.isOnboarded,
    required this.isUserRegistered
  });
}