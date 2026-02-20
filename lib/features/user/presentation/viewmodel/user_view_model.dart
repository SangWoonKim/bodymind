import 'package:bodymind/features/user/domain/entity/user_info.dart';
import 'package:bodymind/features/user/domain/usecase/user_usecase.dart';
import 'package:bodymind/features/user/presentation/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class UserViewState{
  final String? nickName;
  final int? age;
  final double? height;
  final double? weight;
  final String? gender;
  final bool isComplete;

  UserViewState({
    this.nickName,
    this.age,
    this.height,
    this.weight,
    this.gender,
    this.isComplete = false
  });

  factory UserViewState.initial() => UserViewState();

  UserViewState copyWith({
    String? nickName,
    int? age,
    double? height,
    double? weight,
    String? gender,
    bool? isComplete
  }){
    return UserViewState(
      nickName: nickName ?? this.nickName,
      age: age ?? this.age,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      gender: gender ?? this.gender,
      isComplete: isComplete ?? this.isComplete
    );
  }

}
class UserViewModel extends Notifier<UserViewState>{
  late final UserUseCase _userUseCase;
  late final PageController _controller;

  @override
  UserViewState build() {
    _userUseCase = ref.read(userUseCaseProvider);
    return UserViewState();
  }

  void appendUserInfo({
    String? nickName,
    int? age,
    double? height,
    double? weight,
    String? gender
  }){
    bool isComplete = false;

    state = state.copyWith(
        nickName: nickName,
        age: age,
        height: height,
        weight: weight,
        gender: gender,
        isComplete: isComplete
    );

    if(state.nickName != null && state.age != null && state.height != null && state.weight != null && state.gender != null){
      state = state.copyWith(
          nickName: nickName,
          age: age,
          height: height,
          weight: weight,
          gender: gender,
          isComplete: true
      );
    }else{
      state = state.copyWith(
          nickName: nickName,
          age: age,
          height: height,
          weight: weight,
          gender: gender,
          isComplete: false
      );
    }
  }

  void routeUserPage(BuildContext context){
    context.pushReplacementNamed('home');
  }

  void insertUserInfo(BuildContext context) async{
    await _userUseCase.acceptUserInfo(
        UserInfo(
            nickName: state.nickName!,
            age: state.age!,
            height: state.height!,
            weight: state.weight!,
            gender: state.gender!
        )
    );

    context.goNamed('home');
  }

}