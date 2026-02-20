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

    // 1) 0 구간 끊김 처리를 위해 라인 세그먼트 생성
    final segments = _buildLineSegments(hrByMinute, endMinuteExclusive);

    // 2) 0(미착용) 구간을 음영 처리할 범위로 변환
    final missingRanges = _buildMissingRanges(hrByMinute, endMinuteExclusive);

    // 3) y축 범위(0 제외)
    final valid = hrByMinute.take(endMinuteExclusive).where((v) => v > 0).toList();
    final minY = valid.isEmpty ? 40.0 : (valid.reduce((a, b) => a < b ? a : b) - 5).clamp(30, 250).toDouble();
    final maxY = valid.isEmpty ? 140.0 : (valid.reduce((a, b) => a > b ? a : b) + 5).clamp(30, 250).toDouble();

    return LineChart(
      LineChartData(
        minX: 0,
        maxX: 1440, // 축은 0~24시까지 고정
        minY: minY,
        maxY: maxY,

        // 미착용 구간 회색 음영
        rangeAnnotations: RangeAnnotations(
          verticalRangeAnnotations: [
            for (final r in missingRanges)
              VerticalRangeAnnotation(
                x1: r.start.toDouble(),
                x2: r.endExclusive.toDouble(),
                color: Colors.grey.withOpacity(0.15), // “회색 음영”
              ),
          ],
        ),

        // 현재 시각 세로 라인
        extraLinesData: ExtraLinesData(
          verticalLines: [
            VerticalLine(
              x: nowMinute.toDouble(),
              color: Colors.grey.withOpacity(0.65),
              strokeWidth: 1,
              dashArray: [6, 4],
              label: VerticalLineLabel(
                show: true,
                alignment: Alignment.topRight,
                style: const TextStyle(fontSize: 10),
                labelResolver: (_) => 'NOW',
              ),
            ),
          ],
        ),

        gridData: FlGridData(
          show: true,
          verticalInterval: 240,   // 4시간(240분)
          horizontalInterval: 20,  // bpm 간격(원하면 조절)
        ),
        borderData: FlBorderData(show: false),

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
              interval: 240, // 0,4,8,12,16,20,24
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
          for (final seg in segments)
            LineChartBarData(
              spots: seg,
              isCurved: true,
              barWidth: 2,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
              isStrokeCapRound: true,
            ),
        ],
      ),
    );
  }
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
