import 'package:bodymind/features/main_feature/health/detail/activity/presentation/viewmodel/heatlh_act_view_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ActWeeklyGraphView extends StatelessWidget {
  ActDtlState weeklyData;
  final bool hideFuture;

  ActWeeklyGraphView({
    super.key,
    required this.weeklyData,
    this.hideFuture = true
  });

  // final weeklyBarGroupData = dayByWalk

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
      barGroups: []
    ));
  }
}