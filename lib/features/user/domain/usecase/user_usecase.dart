import 'package:bodymind/features/user/domain/entity/user_info.dart';
import 'package:bodymind/features/user/domain/repository/user_repository.dart';

class UserUseCase{
  final UserRepository repository;

  UserUseCase(this.repository);
  Future<void> acceptUserInfo(UserInfo userInfo) => repository.insertUserInfo(userInfo);
  Future<UserInfo?> getUserInfo() => repository.selectUserInfo();
}