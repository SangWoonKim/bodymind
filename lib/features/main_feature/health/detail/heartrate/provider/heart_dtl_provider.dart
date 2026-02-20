import 'package:bodymind/core/storage/db_provider.dart';
import 'package:bodymind/features/main_feature/health/detail/heartrate/data/repository/heart_dtl_repository_impl.dart';
import 'package:bodymind/features/main_feature/health/detail/heartrate/domain/repository/heart_dtl_repository.dart';
import 'package:bodymind/features/main_feature/health/detail/heartrate/domain/usecase/heart_dtl_usecase.dart';
import 'package:bodymind/features/main_feature/health/detail/heartrate/viewmodel/heart_dtl_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final hrDtlRepoProvider = Provider<HeartDtlRepository>((ref) {
  final db = ref.read(dbProvider);
  return HeartDtlRepositoryImpl(db);
});

final hrDtlRepoUsecase = Provider<HeartDtlUsecase>((ref){
  final repo = ref.read(hrDtlRepoProvider);
  return HeartDtlUsecase(repo);
});

final hrDtlViewModelProvider = NotifierProvider<HeartDtlViewModel, HeartDtlState>(HeartDtlViewModel.new);