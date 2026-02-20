import 'dart:math';

import 'package:bodymind/core/util/bodymind_core_util.dart';

extension Avg on Iterable<num?>{
  double featureAvg() {
    final filtered = whereType<num>(); // null 제거 + 타입 안전
    final list = filtered.toList();
    if (list.isEmpty) return 0;

    final sum = list.fold<num>(0, (x, y) => x + y);
    return sum.toDouble() / list.length;
  }

  double featureMin() {
    final list = whereType<num>().toList();
    if (list.isEmpty) return 0;

    final m = list.skip(1).fold<num>(list.first, (x, y) => min(x, y));
    return m.toDouble();
  }

  double featureMax() {
    final list = whereType<num>().toList();
    if (list.isEmpty) return 0;

    final m = list.skip(1).fold<num>(list.first, (x, y) => max(x, y));
    return m.toDouble();
  }
}

class HrInsertUtil{
  static List<int> toFullDay1440({
    required String startDt, // yyyyMMddHHmm
    required List<int> hrLst, // startDt부터 연속 1분값
  }) {
    final start = TimeUtil.yyyyMMddHHmmToDateTime(startDt);
    final dayStart = DateTime(start.year, start.month, start.day);
    final offset = start.difference(dayStart).inMinutes; //0~1439

    final daySeries = List<int>.filled(1440, 0);

    for (int i = 0; i < hrLst.length; i++) {
      final idx = offset + i;
      if (idx < 0 || idx >= 1440) continue;
      daySeries[idx] = hrLst[i]; // hrLst가 0이면 결측으로 유지
    }

    return daySeries;
  }
}