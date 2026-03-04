import 'package:bodymind/features/main_feature/health/detail/activity/domain/entity/act_daily_dto.dart';
import 'package:bodymind/features/main_feature/health/detail/activity/domain/entity/act_month_dto.dart';
import 'package:bodymind/features/main_feature/health/detail/activity/domain/entity/act_week_dto.dart';
import 'package:bodymind/features/main_feature/health/detail/activity/presentation/view/enum/act_graph_option.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    montlyData = ActMonthDto(montlyData.weeklyData.skip(1).toList(), 0, 0, montlyData.weeklyData[1].weeklyMondayDate, null, 0);
    final maxY = montlyData.weeklyData.isEmpty ?
    10000 : montlyData.weeklyData.map((e){
      int selectObj = 0;
      if(option == ActGraphSelection.CALORIE){
        selectObj = e.weeklyTotCalorie.toInt();
      }else if(option == ActGraphSelection.DISTANCE){
        selectObj = e.weeklyTotDistance.toInt();
      }else{
        selectObj = e.weeklyTotStepCnt.toInt();
      }
      return selectObj;
    }).reduce((a,b) => a > b ? a : b ).clamp(0, 100000).toDouble() + 1000;

    return BarChart(BarChartData(
        maxY: maxY.toDouble(),
        minY: 0,
        gridData: FlGridData(show: true, drawVerticalLine: false),
        borderData: FlBorderData(show: false, border: Border(bottom:BorderSide(color: Colors.grey) ,left:BorderSide(color: Colors.grey))),
        titlesData: FlTitlesData(
            show: true,
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: (((maxY / 4) / 1000).round()) * 1000,
                  reservedSize: 36,
                  getTitlesWidget: (value, meta) => Text(value.toInt().toString()),),
                ),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: _xWeekNumTitle
                ),
            )
        ),
        barGroups: barDatas(option)
    ));
  }

  List<BarChartGroupData> barDatas(ActGraphSelection select){
    List<BarChartGroupData> result = List.empty(growable: true);
    DateTime start = montlyData.montlyMondayDate;
    List<ActWeekDto> weeklyData = List.empty(growable: true);
    if(montlyData.weeklyData.isEmpty){
      for(int x = 0; x < montlyData.weeklyData.length; x++){
        result.add(BarChartGroupData(x: x, barRods: [BarChartRodData(toY: 0, color: Colors.deepPurpleAccent)]));
      }
      return result;
    }
    //7일 데이터 주입 및 없을 경우 생성
    montlyData.weeklyData.forEach((e){
      int diffDay = start.difference(e.weeklyMondayDate).inDays;
      if(diffDay <= 7){
        weeklyData.add(e);
        start = e.weeklyMondayDate;
      }else{
        for(int i = 0; i < diffDay ~/ 7; i++){
          weeklyData.add(ActWeekDto([], 0, 0, e.weeklyMondayDate, null, 0, 0, 0));
        }
        start = e.weeklyMondayDate;
      }
    });
    //반복후 없을 경우 추가 생성
    if(weeklyData.length != montlyData.weeklyData.length){
      final emptylen = montlyData.weeklyData.length - weeklyData.length;
      for(int i = 0; i < emptylen; i++){
        weeklyData.add(ActWeekDto([], 0, 0, DateTime(start.year, start.month, start.day + (i * 7)), null, 0, 0, 0));
      }
    }
    switch(select){
    //for문 중간에 색상 변경해야함(오늘 데이터일 경우와 어제 데이터일 경우)
      case ActGraphSelection.COUNT:
        for(int x = 0; x < weeklyData.length; x++){
          result.add(BarChartGroupData(
              x: x,
              barRods: [BarChartRodData(
                  toY: weeklyData[x].weeklyTotStepCnt.toDouble(),
                  color: Colors.deepPurpleAccent,
                  width: 40.w,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
              )
              ]
          ));
        }
        break;
      case ActGraphSelection.DISTANCE:
        for(int x = 0; x < weeklyData.length; x++){
          result.add(BarChartGroupData(x: x, barRods: [BarChartRodData(toY: weeklyData[x].weeklyTotDistance.toDouble(), color: Colors.deepPurpleAccent)]));
        }
        break;
      case ActGraphSelection.CALORIE:
        for(int x = 0; x < weeklyData.length; x++){
          result.add(BarChartGroupData(x: x, barRods: [BarChartRodData(toY: weeklyData[x].weeklyTotCalorie.toDouble(), color: Colors.deepPurpleAccent)]));
        }
        break;
    }
    return result;
  }

  Widget _xWeekNumTitle(double value, TitleMeta meta){
    Widget weeklyNum;
    switch(value.toInt()){
      case 0:
        weeklyNum = Text('1주차');
        break;
      case 1:
        weeklyNum = Text('2주차');
        break;
      case 2:
        weeklyNum = Text('3주차');
        break;
      case 3:
        weeklyNum = Text('4주차');
        break;
      case 4:
        weeklyNum = Text('5주차');
        break;
      default:
        weeklyNum = Text('1주차');
        break;
    }

    return SideTitleWidget(meta: meta, child: weeklyNum);
  }
}