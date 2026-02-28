import 'package:bodymind/core/storage/db_provider.dart';
import 'package:bodymind/features/main_feature/health/detail/activity/data/repository/act_dtl_repository_impl.dart';
import 'package:bodymind/features/main_feature/health/detail/activity/domain/repository/act_dtl_repository.dart';
import 'package:bodymind/features/main_feature/health/detail/activity/domain/usecase/act_dtl_usecase.dart';
import 'package:bodymind/features/main_feature/health/detail/activity/presentation/viewmodel/heatlh_act_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actDtlRepoProvider = Provider<ActDtlRepository>((ref){
  final db = ref.read(dbProvider);
  return ActDtlRepositoryImpl(db);
});

final actDtlUsecase = Provider<ActDtlUsecase>((ref){
  final repo = ref.read(actDtlRepoProvider);
  return ActDtlUsecase(repo);
});

final actDtlViewModelProvider = NotifierProvider<HealthActViewModel, ActDtlState>(HealthActViewModel.new);