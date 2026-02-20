import 'package:bodymind/core/health_module/health_plugin_provider.dart';
import 'package:bodymind/core/storage/db_provider.dart';
import 'package:bodymind/features/main_feature/home/data/repository/home_repository_impl.dart';
import 'package:bodymind/features/main_feature/home/domain/repository/home_repository.dart';
import 'package:bodymind/features/main_feature/home/domain/usecase/home_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodel/home_viewmodel.dart';

final homeInternalRepoProvider = Provider<HomeRepository>((ref) {
  final service = ref.read(healthProvider);
  final db = ref.read(dbProvider);
  return HomeRepositoryImpl(service,db);
});

final homeUseCaseProvider = Provider<HomeUsecase>((ref){
  final repo = ref.read(homeInternalRepoProvider);
  return HomeUsecase(repo);
});

final homeViewModelProvider = NotifierProvider<HomeViewModel,HomeViewState>(HomeViewModel.new);