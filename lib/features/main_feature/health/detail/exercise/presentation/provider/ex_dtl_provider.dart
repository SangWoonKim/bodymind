import 'package:bodymind/core/storage/db_provider.dart';
import 'package:bodymind/features/main_feature/health/detail/exercise/data/repository/ex_dtl_repository_impl.dart';
import 'package:bodymind/features/main_feature/health/detail/exercise/domain/repository/ex_dtl_repository.dart';
import 'package:bodymind/features/main_feature/health/detail/exercise/domain/usecase/ex_dtl_usecase.dart';
import 'package:bodymind/features/main_feature/health/detail/exercise/presentation/viewmodel/ex_dtl_viewmodel.dart';
import 'package:bodymind/features/user/presentation/provider/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final exDtlRepoProvider = Provider<ExDtlRepository>((ref){
  final db = ref.read(dbProvider);
  return ExDtlRepositoryImpl(db);
});

final exDtlUsecaseProvider = Provider<ExDtlUsecase>((ref){
  final repo = ref.read(exDtlRepoProvider);
  final user = ref.read(userUseCaseProvider);
  return ExDtlUsecase(repo, user);
});

final exDtlViewModelProvider = AutoDisposeNotifierProvider<ExDtlViewmodel,ExDtlState>(ExDtlViewmodel.new);