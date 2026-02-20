import 'package:bodymind/core/storage/database/query/bodymind_database.dart';
import 'package:bodymind/core/storage/db_provider.dart';
import 'package:bodymind/features/user/data/repository/user_repository_impl.dart';
import 'package:bodymind/features/user/domain/repository/user_repository.dart';
import 'package:bodymind/features/user/domain/usecase/user_usecase.dart';
import 'package:bodymind/features/user/presentation/viewmodel/user_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRepositoryProvider = Provider<UserRepository>((ref){
  final db = ref.watch(dbProvider);
  return UserRepositoryImpl(db);
});

final userUseCaseProvider = Provider<UserUseCase>((ref){
  final repo = ref.read(userRepositoryProvider);
  return UserUseCase(repo);
});

final userViewModelProvider = NotifierProvider<UserViewModel,UserViewState>(UserViewModel.new);