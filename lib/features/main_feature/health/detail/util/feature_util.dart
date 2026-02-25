import 'dart:math';

import 'package:bodymind/core/util/bodymind_core_util.dart';

extension Avg on Iterable<num?>{
  double featureAvg() {
    final list = whereType<num>().toList();
    final positives = list.where((e) => e > 0).toList();
    if (positives.isEmpty) return 0;

    return positives.reduce((x,y) => x+y) / positives.length;
  }

  double featureMin() {
    final list = whereType<num>().toList();
    final positives = list.where((e) => e > 0).toList();

    if (positives.isEmpty) return 0;

    final m = positives.reduce(min);
    return m.toDouble();
  }

  double featureMax() {
    final list = whereType<num>().toList();
    final positives = list.where((e) => e > 0).toList();
    if (positives.isEmpty) return 0;

    return positives.reduce(max).toDouble();
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
      daySeries[idx] = hrLst[i];
    }

    return daySeries;
  }
}