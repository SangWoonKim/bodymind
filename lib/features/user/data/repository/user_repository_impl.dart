import 'package:bodymind/core/storage/database/query/bodymind_database.dart';

import '../../domain/entity/user_info.dart';
import '../../domain/repository/user_repository.dart';

class UserRepositoryImpl extends UserRepository{
  final BodymindDatabase database;

  UserRepositoryImpl(this.database);

  @override
  Future<void> insertUserInfo(UserInfo userInfo) async{
    database.insertUserInfo(
        userInfo.nickName,
        userInfo.age,
        userInfo.height,
        userInfo.weight,
        userInfo.gender
    );
  }

  @override
  Future<UserInfo?> selectUserInfo() async{
    TbUserInfoData? selectedUser = await database.selectUserInfo().getSingleOrNull();

    return selectedUser != null ?
    UserInfo(
        nickName: selectedUser.nickName,
        age: selectedUser.age,
        height: selectedUser.height,
        weight: selectedUser.weight,
        gender: selectedUser.gender
    ) : null;
  }

}