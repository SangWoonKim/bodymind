import 'dart:math' as math;

import 'package:common_mutiple_health/entity/model/element/heartrate_model.dart';

import '../../../../../../core/storage/feature_model/feature_data/hr/feature_hr.dart';
import '../../../../../../core/util/bodymind_core_util.dart';
import '../../../../../../core/util/fourth.dart';
import '../../../../../user/domain/entity/user_info.dart';
import '../../../domain/entity/feature_entity.dart';
import '../home_viewmodel.dart';

class HrSample {
  final DateTime t;
  final int bpm;
  HrSample(this.t, this.bpm);
}

class HomeHeartInjector {
  List<HrSample> convertHrSample(HeartRateModel origin){
    return origin.originData.map((e) => HrSample(DateTime.fromMillisecondsSinceEpoch(e.measureTime), e.heartRate)).toList();
  }

  double clamp(double x, double lo, double hi) =>
      x < lo ? lo : (x > hi ? hi : x);
  double clamp01(double x) => clamp(x, 0, 1);

  int hrMax(int age) => (208 - 0.7 * age).round();

  /// 1) 촘촘한 샘플 -> 1분안에 데이터가 여러개 들어올 경우 다음샘플 하는 함수
  List<int> toMinuteMedianSeries(List<HrSample> samples, DateTime dayStart) {
    // 1440분 배열 생성
    final buckets = List<List<int>>.generate(1440, (_) => []);
    for (final s in samples) {
      //심박수 필터링
      if (s.bpm < 30 || s.bpm > 220) continue;
      //하루 단위 필터링
      final diff = s.t.difference(dayStart).inMinutes;

      if (diff < 0 || diff >= 1440) continue;
      //1분 단위 배열에 심박수 삽입
      buckets[diff].add(s.bpm);
    }

    //평균이 아닌 심박 측정 데이터는 중앙값을 선택하는 것이 노이즈를 필터링 할 확률 높음
    //1분안에 있는 데이터 중앙값 선택 알고리즘
    int medianOf(List<int> xs) {
      xs.sort();
      return xs[xs.length ~/ 2];
    }

    // 비어있는 분은 이전 값 carry (끊김 방지)
    final hr1m = List<int>.filled(1440, 0);
    int last = 0;
    for (int i = 0; i < 1440; i++) {
      if (buckets[i].isNotEmpty) {
        last = medianOf(buckets[i]);
      }
      hr1m[i] = last; // last가 0이면 초반 구간은 0일 수 있음(원하면 기본값 처리)
    }

    // 시작부 0 보정(첫 유효값으로 채움)
    final firstNonZero = hr1m.indexWhere((v) => v > 0);
    if (firstNonZero > 0) {
      for (int i = 0; i < firstNonZero; i++) {
        hr1m[i] = hr1m[firstNonZero];
      }
    }
    return hr1m;
  }

  /// 2) 10분 이동평균의 최소값 (휴식 심박 프록시)
  double restProxy(List<int> hr1m) {
    const win = 10;
    double minAvg = double.infinity;
    int sum = 0;
    for (int i = 0; i < hr1m.length; i++) {
      sum += hr1m[i];
      if (i >= win) sum -= hr1m[i - win];
      if (i >= win - 1) {
        final avg = sum / win;
        if (avg < minAvg) minAvg = avg;
      }
    }
    return minAvg.isFinite ? minAvg : 0;
  }

  /// 3) RMSSD 프록시(1분 연속 차이)
  double varProxy(List<int> hr1m) {
    if (hr1m.length < 2) return 0;
    double sumSq = 0;
    for (int i = 1; i < hr1m.length; i++) {
      final d = (hr1m[i] - hr1m[i - 1]).toDouble();
      sumSq += d * d;
    }
    return math.sqrt(sumSq / (hr1m.length - 1));
  }

  /// 4) 고심박 분(>= 80% HRmax)
  int highMinutes(List<int> hr1m, int age) {
    final th = (0.8 * hrMax(age)).round();
    return hr1m.where((v) => v >= th).length;
  }

  /// 5) 최종 점수
  int processingHeart({
    required List<HrSample> samples,
    required DateTime dayStart,
    required int age,
    required double restBase,
    required double varBase,
    required int highBase,
  }) {
    final hr1m = toMinuteMedianSeries(samples, dayStart);

    final rest = restProxy(hr1m);
    final vari = varProxy(hr1m);
    final high = highMinutes(hr1m, age);

    final sRest = 1.0 - clamp01((rest - restBase) / 12.0);
    final sVar = clamp01(varBase <= 0 ? 0 : (vari / varBase));
    final ratio = high / math.max(highBase, 10).toDouble();
    final sLoad = 1.0 - clamp01((ratio - 1.0) / 2.0);

    final raw = 0.55 * sRest + 0.30 * sVar + 0.15 * sLoad;
    return (raw * 100).round().clamp(0, 100);
  }

  int _savedDataProcessingHeart({
    required List<int> samples,
    required DateTime dayStart,
    required int age,
    required double restBase,
    required double varBase,
    required int highBase,
  }) {
    final rest = restProxy(samples);
    final vari = varProxy(samples);
    final high = highMinutes(samples, age);

    final sRest = 1.0 - clamp01((rest - restBase) / 12.0);
    final sVar = clamp01(varBase <= 0 ? 0 : (vari / varBase));
    final ratio = high / math.max(highBase, 10).toDouble();
    final sLoad = 1.0 - clamp01((ratio - 1.0) / 2.0);

    final raw = 0.55 * sRest + 0.30 * sVar + 0.15 * sLoad;
    return (raw * 100).round().clamp(0, 100);
  }

  Fourth processingHr(FeatureEntity receive, DateTime now, DateTime previousDay, HomeViewState state, UserInfo userInfo){
    int currentScore = 0;
    int previousScore = 0;
    int weeklyScore = 0;
    int weeklyCnt = 1;

    receive.featureLst?.forEach((featuredData){
      final hrModel = featuredData.featureData?.feature as FeatureHr?;

      if(hrModel != null){
        String day = featuredData.featureData!.instDt.substring(6,8);
        final dayStart = TimeUtil.yyyyMMddToDateTime(featuredData.featureData!.instDt);
        // final hrSample = heartInjector.convertHrSample(hrModel.hrData);

        final hrScore = _savedDataProcessingHeart(
          // samples: hrSample,
            samples: hrModel.hrData,
            dayStart: DateTime(dayStart.year, dayStart.month, dayStart.day),
            age: userInfo.age,
            restBase: 0,
            varBase: 0,
            highBase: 0);

        weeklyCnt += 1;
        if(int.parse(day) == now.day){
          currentScore = hrScore;
        }else if(int.parse(day) == previousDay.day){
          currentScore = hrScore;
        }
        weeklyScore += hrScore;

        print('hrScore = $hrScore');
      }

    });

    FeatureInfo feature = state.featureInfo['heart']!.copyWith(
        score: currentScore
    );

    return Fourth(
        currentScore.round(),
        previousScore.round(),
        (weeklyScore / weeklyCnt).round(),
        state.featureInfo['heart']!.copyWith(
            score: currentScore.round())
    );
  }
}

