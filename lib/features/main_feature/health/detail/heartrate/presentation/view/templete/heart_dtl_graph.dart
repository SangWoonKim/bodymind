import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HeartDtlGraph extends StatelessWidget {
   List<int> hrByMinute;
  final bool hideFuture;

  HeartDtlGraph({
    super.key,
    required this.hrByMinute,
    this.hideFuture = true,
  });

  @override
  Widget build(BuildContext context) {
    if(hrByMinute.isEmpty){
      hrByMinute = List.filled(1440, 0);
    }
    assert(hrByMinute.length == 1440);

    final now = DateTime.now();
    final nowMinute = now.hour * 60 + now.minute; // 0~1439
    final endMinuteExclusive = hideFuture ? (nowMinute + 1).clamp(0, 1440) : 1440;

    // 0) 그래프 곡선을 위한 평균화
    final hrSmoothed = smoothMovingAverage(hrByMinute, window: 7); // 5~11 추천

    // 1) 0 구간 끊김 처리를 위해 라인 세그먼트 생성
    final segments = _buildLineSegments(hrSmoothed, endMinuteExclusive);

    // 2) 0(미착용) 구간을 음영 처리할 범위로 변환
    final missingRanges = _buildMissingRanges(hrSmoothed, endMinuteExclusive);

    // 3) y축 범위(0 제외)
    final valid = hrSmoothed.take(endMinuteExclusive).where((v) => v > 0).toList();
    final minY = valid.isEmpty ? 50.0 : (valid.reduce((a, b) => a < b ? a : b) - 5).clamp(50, 250).toDouble();
    final maxY = valid.isEmpty ? 140.0 : (valid.reduce((a, b) => a > b ? a : b) + 5).clamp(50, 250).toDouble();
    final avgY = valid.isEmpty ? 0.0 : (valid.reduce((a, b) => a + b) / valid.length).clamp(50, 250).toDouble();

    // 제외 유효 범위
    final range = hrSmoothed.take(endMinuteExclusive).toList();

    // 최저/최고 값
    final minVal = valid.isEmpty ? 0 : valid.reduce((a, b) => a < b ? a : b);
    final maxVal = valid.isEmpty ? 0 : valid.reduce((a, b) => a > b ? a : b);

    // 최저/최고가 "처음" 나온 minute
    final firstMinMinute = range.indexWhere((v) => v == minVal);
    final firstMaxMinute = range.indexWhere((v) => v == maxVal);

    // 찍을 점
    final markerSpots = <FlSpot>[];
    if (firstMinMinute >= 0) {
      markerSpots.add(FlSpot(firstMinMinute.toDouble(), minVal.toDouble()));
    }
    if (firstMaxMinute >= 0) {
      markerSpots.add(FlSpot(firstMaxMinute.toDouble(), maxVal.toDouble()));
    }

    return LineChart(
      LineChartData(
        minX: 0,
        maxX: 1440, // 축은 0~24시까지 고정
        minY: minY,
        maxY: maxY,

        // 현재 시각 세로 라인
        extraLinesData: ExtraLinesData(
          horizontalLines: [
            HorizontalLine(
              y: avgY,
              color: Colors.grey.withOpacity(0.80),
              strokeWidth: 1,
              dashArray: [6, 4],
              label: HorizontalLineLabel(
                show: true,
                alignment: Alignment.topLeft,
                style: const TextStyle(fontSize: 10),
                labelResolver: (_) => avgY.toInt().toString(),
              ),
            )
          ],
        ),

        gridData: FlGridData(
          show: false,
          verticalInterval: 480,   // 4시간(240분)
          horizontalInterval: 40,  // bpm 간격(원하면 조절)
        ),
        borderData: FlBorderData(show: true, border: Border(bottom:BorderSide(color: Colors.grey) ,left:BorderSide(color: Colors.grey))),

        titlesData: FlTitlesData(
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 36,
              interval: 20,
              getTitlesWidget: (value, meta) => Text(value.toInt().toString()),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 480, // 8,16,24
              getTitlesWidget: (value, meta) {
                final h = (value ~/ 60).toInt();
                if (h < 0 || h > 24) return const SizedBox.shrink();
                return Text(h.toString());
              },
            ),
          ),
        ),

        lineTouchData: LineTouchData(
          enabled: true,
          handleBuiltInTouches: true,
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((s) {
                final minute = s.x.round().clamp(0, 1439);
                final hh = (minute ~/ 60).toString().padLeft(2, '0');
                final mm = (minute % 60).toString().padLeft(2, '0');
                return LineTooltipItem('$hh:$mm  ${s.y.toInt()} bpm', const TextStyle());
              }).toList();
            },
          ),
        ),

        // 0 구간에서 끊어진 “선”들
        lineBarsData: [
          if (markerSpots.isNotEmpty)
          LineChartBarData(
            spots: markerSpots,
            barWidth: 0,
            color: Colors.transparent,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, bar, index) {
                // index 0: 최저, index 1: 최고
                final fill = (index == 0)
                    ? const Color(0xFF22C55E) // 최저점: 초록
                    : const Color(0xFFEF4444); // 최고점: 빨강

                return FlDotCirclePainter(
                  radius: 3,
                  color: fill,
                  strokeWidth: 2,
                  strokeColor: Colors.grey,
                );
              },
            ),
          ),
          for (final seg in segments)
            LineChartBarData(
              spots: seg,
              isCurved: true,
              curveSmoothness: 0.2,
              preventCurveOverShooting: true,
              barWidth: 2,
              color: const Color(0xFF6366f1),
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
              isStrokeCapRound: true,
            ),
        ],
      ),
    );
  }
}

/// graph smoothing 로직 즉 이동 평균화
List<int> smoothMovingAverage(List<int> hr, {int window = 7}) {
  final out = List<int>.filled(hr.length, 0);
  final half = window ~/ 2;

  for (int i = 0; i < hr.length; i++) {
    int sum = 0;
    int cnt = 0;

    for (int j = i - half; j <= i + half; j++) {
      if (j < 0 || j >= hr.length) continue;
      final v = hr[j];
      if (v > 0) { // 결측 제외
        sum += v;
        cnt++;
      }
    }
    out[i] = cnt == 0 ? 0 : (sum / cnt).round();
  }
  return out;
}

/// 라인 세그먼트 분할: 0 나오면 끊김
List<List<FlSpot>> _buildLineSegments(List<int> hr, int endMinuteExclusive) {
  final segments = <List<FlSpot>>[];
  var current = <FlSpot>[];

  for (int m = 0; m < endMinuteExclusive; m++) {
    final v = hr[m];
    if (v <= 0) {
      if (current.isNotEmpty) {
        segments.add(current);
        current = <FlSpot>[];
      }
      continue;
    }
    current.add(FlSpot(m.toDouble(), v.toDouble()));
  }
  if (current.isNotEmpty) segments.add(current);
  return segments;
}

/// 미착용(0) 연속 구간 찾기 -> [start, endExclusive)
List<_Range> _buildMissingRanges(List<int> hr, int endMinuteExclusive) {
  final ranges = <_Range>[];
  int? start;

  for (int m = 0; m < endMinuteExclusive; m++) {
    final isMissing = hr[m] <= 0;

    if (isMissing && start == null) {
      start = m;
    } else if (!isMissing && start != null) {
      // start..m-1 까지가 결측
      // 너무 짧은 결측(1~2분)까지 칠하기 싫으면 여기서 길이 필터 가능
      ranges.add(_Range(start, m)); // endExclusive = m
      start = null;
    }
  }

  if (start != null) {
    ranges.add(_Range(start, endMinuteExclusive));
  }

  return ranges;
}

class _Range {
  final int start;
  final int endExclusive;
  _Range(this.start, this.endExclusive);
}
