import 'dart:math' as math;

import '../../storage/feature_model/feature_data/hr/feature_hr.dart';
import 'package:collection/collection.dart';

class InsertFormatter {
  int hrMax(int age) => (208 - 0.7 * age).round();

  double clamp(double x, double lo, double hi) =>
      x < lo ? lo : (x > hi ? hi : x);
  double clamp01(double x) => clamp(x, 0, 1);

  /// 1) 촘촘한 샘플 -> 1분안에 데이터가 여러개 들어올 경우 다음샘플 하는 함수
  List<int> toMinuteMedianSeries(List<FeatureHrDtl> samples, DateTime dayStart) {
    // 1440분 배열 생성
    final buckets = List<List<int>>.generate(1440, (_) => []);
    for (final s in samples) {
      //심박수 필터링
      if (s.bpm < 30 || s.bpm > 220) continue;
      //하루 단위 필터링
      final diff = s.time.difference(dayStart).inMinutes;

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

    //이전 회사에서 교수님에게 심박 필터링에 대한 의논시 평균 데이터를 선택하는 것이 노이즈를 필터링 한다 함
    //1분안에 있는 데이터 평균값 선택 알고리즘
    int avgOf(List<int> avgs){
      return avgs.average.round();
    }

    // 비어있는 분은 이전 값 carry (끊김 방지)
    final hr1m = List<int>.filled(1440, 0);
    int last = 0;
    for (int i = 0; i < 1440; i++) {
      if (buckets[i].isNotEmpty) {
        last = avgOf(buckets[i]);
      }
      hr1m[i] = last; // last가 0이면 초반 구간은 0일 수 있음(원하면 기본값 처리)
    }

    // 시작부 0 보정(첫 유효값으로 채움)
    final firstNonZero = hr1m.indexWhere((v) => v > 0);
    if (firstNonZero > 0) {
      for (int i = 0; i < firstNonZero; i++) {
        hr1m[i] = 0;
      }
    }
    return hr1m;
  }
  ///휴식 심박 프록시
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

  /// 1분 연속 차이
  double varProxy(List<int> hr1m) {
    if (hr1m.length < 2) return 0;
    double sumSq = 0;
    for (int i = 1; i < hr1m.length; i++) {
      final d = (hr1m[i] - hr1m[i - 1]).toDouble();
      sumSq += d * d;
    }
    return math.sqrt(sumSq / (hr1m.length - 1));
  }

  ///>= 80% HRmax
  int highMinutes(List<int> hr1m, int age) {
    final th = (0.8 * hrMax(age)).round();
    return hr1m
        .where((v) => v >= th)
        .length;
  }

}