import '../entity/user_info.dart';

abstract class UserRepository{
  Future<void> insertUserInfo(UserInfo userInfo);
  Future<UserInfo?> selectUserInfo();
}