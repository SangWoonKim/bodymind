import 'package:bodymind/core/storage/database/query/bodymind_database.dart';
import 'package:bodymind/core/storage/db_provider.dart';
import 'package:bodymind/features/onboard/data/repository/onboard_repository_impl.dart';
import 'package:bodymind/features/onboard/domain/repository/onboard_repository.dart';
import 'package:bodymind/features/onboard/domain/usecase/onboard_usecase.dart';
import 'package:bodymind/features/onboard/presentation/viewmodel/onboard_page_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final onboardRepositoryProvider = Provider<OnboardRepository>((ref) {
  final db = ref.read(dbProvider);
  return OnboardRepositoryImpl(db);
});

final onboardUseCaseProvider = Provider<OnboardUseCase>((ref){
  final repo = ref.read(onboardRepositoryProvider);
  return OnboardUseCase(repo);
});

final onboardViewModelProvider = NotifierProvider<OnboardPageViewModel,OnboardContentState>(OnboardPageViewModel.new);