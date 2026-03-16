import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ExElementGraph extends StatelessWidget {
  final List<int> hrBySec; // 실제로는 hrInterval 간격의 샘플들
  final int hrInterval; // 초 단위 간격 (5, 10, 60 ...)
  final DateTime startTm;

  const ExElementGraph({
    super.key,
    required this.hrBySec,
    required this.hrInterval,
    required this.startTm,
  });

  @override
  Widget build(BuildContext context) {
    final source = hrBySec;

    if (source.isEmpty) {
      return const Center(child: Text('심박 데이터가 없습니다'));
    }

    // final hrSmoothed = smoothMovingAverage(source, window: 7);
    final segments = _buildLineSegments(source, hrInterval);

    final validValues = source.where((e) => e > 0).toList();

    final minY = validValues.isEmpty
        ? 50.0
        : (validValues.reduce((a, b) => a < b ? a : b) - 5)
        .clamp(50, 250)
        .toDouble();

    final maxY = validValues.isEmpty
        ? 140.0
        : (validValues.reduce((a, b) => a > b ? a : b) + 5)
        .clamp(50, 250)
        .toDouble();

    final avgY = validValues.isEmpty
        ? 0.0
        : (validValues.reduce((a, b) => a + b) / validValues.length)
        .clamp(50, 250)
        .toDouble();

    final minVal = validValues.isEmpty
        ? 0
        : validValues.reduce((a, b) => a < b ? a : b);

    final maxVal = validValues.isEmpty
        ? 0
        : validValues.reduce((a, b) => a > b ? a : b);

    final firstMinIndex = source.indexWhere((v) => v == minVal);
    final firstMaxIndex = source.indexWhere((v) => v == maxVal);

    final markerSpots = <FlSpot>[];
    if (firstMinIndex >= 0) {
      markerSpots.add(
        FlSpot((firstMinIndex * hrInterval).toDouble(), minVal.toDouble()),
      );
    }
    if (firstMaxIndex >= 0) {
      markerSpots.add(
        FlSpot((firstMaxIndex * hrInterval).toDouble(), maxVal.toDouble()),
      );
    }


    final totalSeconds = (source.length - 1) * hrInterval;
    final xInterval = _resolveXAxisInterval(totalSeconds);

    return LineChart(
      LineChartData(
        minX: 0,
        maxX: totalSeconds.toDouble(),
        minY: minY,
        maxY: maxY,

        extraLinesData: ExtraLinesData(
          horizontalLines: [
            HorizontalLine(
              y: avgY,
              color: Colors.grey.withOpacity(0.8),
              strokeWidth: 1,
              dashArray: [6, 4],
              label: HorizontalLineLabel(
                show: true,
                alignment: Alignment.topLeft,
                style: const TextStyle(fontSize: 10),
                labelResolver: (_) => avgY.toInt().toString(),
              ),
            ),
          ],
        ),

        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          verticalInterval: xInterval.toDouble(),
          horizontalInterval: 20,
        ),

        borderData: FlBorderData(
          show: true,
          border: const Border(
            bottom: BorderSide(color: Colors.grey),
            left: BorderSide(color: Colors.grey),
          ),
        ),

        titlesData: FlTitlesData(
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 36,
              interval: 20,
              getTitlesWidget: (value, meta) {
                return Text(value.toInt().toString());
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: xInterval.toDouble(),
              getTitlesWidget: (value, meta) {
                final sec = value.toInt();
                final time = startTm.add(Duration(seconds: sec));
                final hh = time.hour.toString().padLeft(2, '0');
                final mm = time.minute.toString().padLeft(2, '0');
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text('$hh:$mm', style: const TextStyle(fontSize: 10)),
                );
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
                final sec = s.x.round();
                final time = startTm.add(Duration(seconds: sec));
                final hh = time.hour.toString().padLeft(2, '0');
                final mm = time.minute.toString().padLeft(2, '0');
                final ss = time.second.toString().padLeft(2, '0');

                return LineTooltipItem(
                  '$hh:$mm:$ss  ${s.y.toInt()} bpm',
                  const TextStyle(color: Colors.white),
                );
              }).toList();
            },
          ),
        ),

        lineBarsData: [
          if (markerSpots.isNotEmpty)
            LineChartBarData(
              spots: markerSpots,
              barWidth: 0,
              color: Colors.transparent,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, bar, index) {
                  final fill = (index == 0)
                      ? const Color(0xFF22C55E)
                      : const Color(0xFFEF4444);

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
              curveSmoothness: 0.05,
              preventCurveOverShooting: false,
              barWidth: 2,
              color: const Color(0xFF6366F1),
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
              isStrokeCapRound: true,
            ),
        ],
      ),
    );
  }

  int _resolveXAxisInterval(int totalSeconds) {
    if (totalSeconds <= 10 * 60) return 60;        // 1분
    if (totalSeconds <= 60 * 60) return 5 * 60;    // 5분
    if (totalSeconds <= 3 * 60 * 60) return 15 * 60; // 15분
    return 30 * 60; // 30분
  }
}

/// 이동 평균
List<int> smoothMovingAverage(List<int> hr, {int window = 7}) {
  final out = List<int>.filled(hr.length, 0);
  final half = window ~/ 2;

  for (int i = 0; i < hr.length; i++) {
    int sum = 0;
    int cnt = 0;

    for (int j = i - half; j <= i + half; j++) {
      if (j < 0 || j >= hr.length) continue;
      final v = hr[j];
      if (v > 0) {
        sum += v;
        cnt++;
      }
    }

    out[i] = cnt == 0 ? 0 : (sum / cnt).round();
  }

  return out;
}

/// 0이 나오면 끊기는 라인 세그먼트
List<List<FlSpot>> _buildLineSegments(List<int> hr, int hrInterval) {
  final segments = <List<FlSpot>>[];
  var current = <FlSpot>[];

  for (int i = 0; i < hr.length; i++) {
    final v = hr[i];

    if (v <= 0) {
      if (current.isNotEmpty) {
        segments.add(current);
        current = <FlSpot>[];
      }
      continue;
    }

    final xSec = i * hrInterval;
    current.add(FlSpot(xSec.toDouble(), v.toDouble()));
  }

  if (current.isNotEmpty) {
    segments.add(current);
  }

  return segments;
}