import 'package:bodymind/features/main_feature/health/detail/activity/domain/entity/act_daily_dto.dart';
import 'package:bodymind/features/main_feature/health/detail/activity/domain/entity/act_month_dto.dart';
import 'package:bodymind/features/main_feature/health/detail/activity/domain/entity/act_week_dto.dart';
import 'package:bodymind/features/main_feature/health/detail/activity/presentation/view/enum/act_graph_option.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../viewmodel/heatlh_act_view_model.dart';

class ActMontlyGraphView extends StatelessWidget {
  ActMonthDto montlyData;
  final bool hideFuture;
  ActGraphSelection option;

  ActMontlyGraphView({
    super.key,
    required this.montlyData,
    this.hideFuture = true,
    required this.option
  });

  // final weeklyBarGroupData = dayByWalk

  @override
  Widget build(BuildContext context) {

    return BarChart(BarChartData(
        maxY: montlyData.weeklyData.length.toDouble(),
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