import 'package:bodymind/core/health_module/health_plugin_provider.dart';
import 'package:bodymind/core/storage/db_provider.dart';
import 'package:bodymind/features/main_feature/home/data/repository/home_db_repository_impl.dart';
import 'package:bodymind/features/main_feature/home/domain/repository/home_db_repository.dart';
import 'package:bodymind/features/main_feature/home/domain/usecase/home_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodel/home_viewmodel.dart';

final homeInternalRepoProvider = Provider<HomeDbRepository>((ref) {
  final db = ref.read(dbProvider);
  return HomeDbRepositoryImpl(db);
});

final homeUseCaseProvider = Provider<HomeUsecase>((ref){
  final repo = ref.read(homeInternalRepoProvider);
  return HomeUsecase(repo);
});

final healthSyncDoneProvider = StreamProvider<DateTime>((ref) {
  final svc = ref.read(insertServiceProvider);
  return svc.onSyncDone;
});

final homeViewModelProvider = NotifierProvider<HomeViewModel,HomeViewState>(HomeViewModel.new);