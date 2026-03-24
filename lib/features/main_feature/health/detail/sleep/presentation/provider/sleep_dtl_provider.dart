import 'package:bodymind/core/storage/db_provider.dart';
import 'package:bodymind/features/main_feature/health/detail/sleep/data/repostitory/sleep_dtl_repository_impl.dart';
import 'package:bodymind/features/main_feature/health/detail/sleep/domain/repository/sleep_dtl_repository.dart';
import 'package:bodymind/features/main_feature/health/detail/sleep/domain/usecase/sleep_usecase.dart';
import 'package:bodymind/features/main_feature/health/detail/sleep/presentation/viewmodel/sleep_dtl_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sleepRepoProvider = Provider<SleepDtlRepository>((ref){
  final db = ref.read(dbProvider);
  return SleepDtlRepositoryImpl(db);
});

final sleepDtlUsecaseProvider = Provider<SleepUsecase>((ref){
  final repo = ref.read(sleepRepoProvider);

  return SleepUsecase(repo);
});

final sleepDtlViewModelProvider = AutoDisposeNotifierProvider<SleepDtlViewmodel, SleepDtlViewState>(SleepDtlViewmodel.new);