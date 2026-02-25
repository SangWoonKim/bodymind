import 'package:bodymind/features/main_feature/home/domain/entity/feature_entity.dart';
import 'package:bodymind/features/main_feature/home/domain/usecase/home_usecase.dart';
import 'package:bodymind/features/user/domain/entity/user_info.dart';
import 'package:bodymind/features/user/domain/usecase/user_usecase.dart';
import 'package:bodymind/features/user/presentation/provider/user_provider.dart';
import 'package:common_mutiple_health/entity/const/data_catalog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/home_provider.dart';
import 'injector/home_act_injector.dart';
import 'injector/home_exercise_injector.dart';
import 'injector/home_heart_injector.dart';
import 'injector/home_sleep_injector.dart';

class HomeViewState{
  final int totalScore;
  final String evaluationStr;
  final int previousScore;
  final int weeklyScore;
  final Map<String, FeatureInfo> featureInfo;
  final int todayCnt;
  final int previousCnt;
  final int weeklyCnt;

  HomeViewState({
    required this.totalScore,
    required this.evaluationStr,
    required this.previousScore,
    required this.weeklyScore,
    required this.featureInfo,
    required this.todayCnt,
    required this.previousCnt,
    required this.weeklyCnt
  });

  factory HomeViewState.initial() => HomeViewState(totalScore: 0, evaluationStr: '없음', previousScore: 0, weeklyScore: 0, featureInfo: {
    'act': FeatureInfo(score: 0,
        featureEvaluationStr: '데이터 조회 필요',
        route:  '/feature/act'),
    'heart': FeatureInfo(score: 0,
        featureEvaluationStr: '데이터 조회 필요',
        route:  '/feature/heart'),
    'sleep': FeatureInfo(score: 0,
        featureEvaluationStr: '데이터 조회 필요',
        route:  '/feature/sleep'),
    'exercise': FeatureInfo(score: 0,
        featureEvaluationStr: '데이터 조회 필요',
        route: '/feature/exercise'),
  }, todayCnt: 0, previousCnt: 0, weeklyCnt: 0
  );

  HomeViewState copyWith({
    int? totalScore,
    String? evaluationStr,
    int? previousScore,
    int? weeklyScore,
    Map<String, FeatureInfo>? featureInfo
  }){
    int toCnt = this.todayCnt;
    int prCnt = this.previousCnt;
    int wkCnt = this.weeklyCnt;
    if (totalScore != 0){
      toCnt += 1;
    }
    if (previousScore != 0){
      prCnt += 1;
    }
    if (weeklyScore != 0){
      wkCnt += 1;
    }
    Map<String,FeatureInfo> featureData = this.featureInfo;
    if(featureInfo != null){
      featureData.addAll(featureInfo);
    }
    return HomeViewState(
        totalScore: totalScore ?? this.totalScore,
        evaluationStr: evaluationStr ?? this.evaluationStr,
        previousScore: previousScore ?? this.previousScore,
        weeklyScore: weeklyScore ?? this.weeklyScore,
        featureInfo: featureData,
        todayCnt: toCnt,
        previousCnt: prCnt,
        weeklyCnt: wkCnt

    );
  }
}
class FeatureInfo{
  final int score;
  final String featureEvaluationStr;
  final String route;

  FeatureInfo({
    required this.score,
    required this.featureEvaluationStr,
    required this.route});

  FeatureInfo copyWith({
    int? score,
    String? featureEvaluationStr,
    String? route
  }){
    return FeatureInfo(
        score: score ?? this.score,
        featureEvaluationStr: featureEvaluationStr ?? this.featureEvaluationStr,
        route: route ?? this.route);
  }
}

class HomeViewModel extends Notifier<HomeViewState> {
  late final HomeUsecase _homeUsecase;
  late final UserUseCase _userUseCase;
  UserInfo? _userInfo;

  @override
  HomeViewState build() {
    _homeUsecase = ref.read(homeUseCaseProvider);
    _userUseCase = ref.read(userUseCaseProvider);

    ref.listen(healthSyncDoneProvider, (prev, next) {
      next.whenData((_) => loadFeaturedData(7));
    });
    //요기 오버헤드 줄일 방법 생각하자
    Future.microtask(()=> loadFeaturedData(7));
    return HomeViewState.initial();
  }

  void loadFeaturedData(int previousDays) async{
    _userInfo ??= await _userUseCase.getUserInfo();
    // await _homeUsecase.requestPermission();

    DateTime now = DateTime.now();
    DateTime previousDay = now.add(Duration(days: -1));

    Stream<FeatureEntity> streamData = _homeUsecase.selectAllParallelEmitAsDone(previousDays);
    streamData.listen((receive) {
      switch(receive.category){

        //act
        case DataCatalog.Act:
          final actScore = HomeActInjector().processingAct(receive.featureLst, _userInfo!, state);

          state = state.copyWith(
              totalScore: actScore!.first,
            previousScore: actScore!.second,
            weeklyScore: actScore!.third,
            featureInfo : {'act': actScore.fourth}
          );
          break;


          //ex
        case DataCatalog.Exercise:
          final exScore = HomeExerciseInjector().processingEx(receive, now, previousDay, state);

          state = state.copyWith(
              totalScore: exScore!.first,
              previousScore: exScore!.second,
              weeklyScore: exScore!.third,
              featureInfo : {'exercise': exScore.fourth}
          );
          break;

          //hr
        case DataCatalog.Heart:
          final hrScore = HomeHeartInjector().processingHr(receive, now, previousDay, state, _userInfo!);

          state = state.copyWith(
              totalScore: hrScore!.first,
              previousScore: hrScore!.second,
              weeklyScore: hrScore!.third,
              featureInfo : {'heart': hrScore.fourth}
          );
          break;


          //sleep
        case DataCatalog.Sleep:
          final sleepScore = HomeSleepInjector().processingSlp(receive, now, previousDay, state);

          state = state.copyWith(
              totalScore: sleepScore!.first,
              previousScore: sleepScore!.second,
              weeklyScore: sleepScore!.third,
              featureInfo : {'sleep': sleepScore.fourth}
          );
          break;
      }

    });
  }



}