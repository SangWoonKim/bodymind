import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ActWeeklyGraphView extends StatelessWidget {
  List<ActGraphData> dayByWalkCnt;
  final bool hideFuture;

  ActWeeklyGraphView({
    super.key,
    required dayByWalkCnt,
    this.hideFuture = true
  });

  final weeklyBarGroupData = dayByWalk

  @override
  Widget build(BuildContext context) {

    return BarChart(BarChartData(
      maxY: 7,
      minY: 0,
      gridData: FlGridData(show: true),
      borderData: FlBorderData(show: true),
      titlesData: FlTitlesData(
        show: true,
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
        bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true))
      ),
      barGroups:
    ));
  }
}