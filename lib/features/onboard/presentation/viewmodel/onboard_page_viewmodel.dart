import 'package:bodymind/features/onboard/domain/entity/onboard_info.dart';
import 'package:bodymind/features/onboard/domain/usecase/onboard_usecase.dart';
import 'package:bodymind/features/splash/presentation/provider/splash_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../enum/onboard_content.dart';
import '../provider/onboard_provider.dart';
class OnboardContentState{
  final bool isLoading;
  final int? totalPage;
  final OnboardContent? content;
  final PageController? controller;

  const OnboardContentState({
    required this.isLoading,
    this.totalPage,
    this.content,
    this.controller
  });

  factory OnboardContentState.initial() => const OnboardContentState(isLoading: true);

  OnboardContentState copyWith({
    bool? isLoading,
    int? totalPage,
    OnboardContent? content,
    PageController? controller,
  }){
    return OnboardContentState(
        isLoading: isLoading ?? this.isLoading,
      totalPage: totalPage ?? this.totalPage,
      content: content ?? this.content,
      controller: controller?? this.controller
    );
  }
}

class OnboardPageViewModel extends Notifier<OnboardContentState>{
  late final OnboardUseCase _onboardUseCase;
  late final PageController _controller;

  @override
  OnboardContentState build() {
    _onboardUseCase = ref.read(onboardUseCaseProvider);
    Future.microtask(fetch);
    return OnboardContentState.initial();
  }
  void onPageChanged(int idx){
    state = state.copyWith(
      content: OnboardContent.values[idx]
    );
  }

  Future<void> fetch() async{
    state = state.copyWith(isLoading: true);
    try{
      final result = await _onboardUseCase.getOnboardInfo();

      _controller = PageController(initialPage: 0);
      state = state.copyWith(
        isLoading: false,
        totalPage: OnboardContent.values.length,
        controller: _controller,
          content: OnboardContent.values[0]
      );

    }catch(e){
      state = state.copyWith(
        isLoading: false,
        totalPage: null,
        content: null,
        controller: null,
      );
    }
  }

  void routeUserRegister(BuildContext context) async{
    await _onboardUseCase.repository.insertOnboardInfo(OnboardInfo(isComplete: true));
    ref.invalidate(appStartProvider);
    context.pushReplacementNamed('user');
  }


}