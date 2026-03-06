import 'package:bodymind/features/main_feature/health/detail/activity/presentation/viewmodel/heatlh_act_view_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/entity/act_daily_dto.dart';
import '../../../domain/entity/act_week_dto.dart';
import '../enum/act_graph_option.dart';

class ActWeeklyGraphView extends StatelessWidget {
  ActWeekDto weeklyData;
  final bool hideFuture;
  ActGraphSelection option;


  ActWeeklyGraphView({
    super.key,
    required this.weeklyData,
    this.hideFuture = true,
    required this.option
  });


  @override
  Widget build(BuildContext context) {
    final maxY = weeklyData.actDailyData.isEmpty ? 
    10000 : weeklyData.actDailyData.map((e) {
      int selectObj = 0;
      if(option == ActGraphSelection.CALORIE){
        selectObj = e.calorie.toInt();
      }else if(option == ActGraphSelection.DISTANCE){
        selectObj = e.distance.toInt();
      }else{
        selectObj = e.stepCnt.toInt();
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
              interval: maxY < 10000 ? 10000 : (((maxY / 4) / 1000).round()) * 1000,
              reservedSize: 36,
              getTitlesWidget: (value, meta) => Text(value.toInt().toString()),),
          ),
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 36,
                  getTitlesWidget: _xWeekTitle)
          )
      ),
      barGroups: barDatas(option),
    ));


  }



  List<BarChartGroupData> barDatas(ActGraphSelection select){
    List<BarChartGroupData> result = List.empty(growable: true);
    DateTime start = weeklyData.weeklyMondayDate;
    List<ActDailyDto> dailyData = List.empty(growable: true);
    if(weeklyData.actDailyData.isEmpty){
      for(int x = 0; x < 7; x++){
        result.add(BarChartGroupData(x: x, barRods: [BarChartRodData(toY: 0, color: Colors.deepPurpleAccent)]));
      }
      return result;
    }
    //7일 데이터 앞부분 빈 데이터 생성
    if(weeklyData.actDailyData.isNotEmpty){
      if(weeklyData.weeklyMondayDate.compareTo(weeklyData.actDailyData.first.measrueDt) == -1){
        final forCnt =weeklyData.actDailyData.first.measrueDt.difference(weeklyData.weeklyMondayDate).inDays;
        for(int i = 0; i< forCnt; i++){
          dailyData.add(ActDailyDto(0, 0, 0, DateTime(weeklyData.weeklyMondayDate.year, weeklyData.weeklyMondayDate.month, weeklyData.weeklyMondayDate.day + i)));
        }
      }
    }

    //7일 데이터 주입 및 없을 경우 생성
    weeklyData.actDailyData.forEach((e){
      int diffDay = start.difference(e.measrueDt).inDays;
      if(diffDay == 1){
        dailyData.add(e);
        start = e.measrueDt;
      }else{
        for(int i = 0; i < diffDay; i++){
          dailyData.add(ActDailyDto(0, 0, 0, DateTime(start.year, start.month, start.day + 1)));
        }
        dailyData.add(e);
        start = e.measrueDt;
      }
    });
    //반복후 없을 경우 추가 생성
    if(dailyData.length != 7){
      final emptylen = 7 -dailyData.length;
      for(int i = 0; i < emptylen; i++){
        dailyData.add(ActDailyDto(0, 0, 0, DateTime(start.year, start.month, start.day + i)));
      }
    }
    switch(select){
    //for문 중간에 색상 변경해야함(오늘 데이터일 경우와 어제 데이터일 경우)
      case ActGraphSelection.COUNT:
        for(int x = 0; x < dailyData.length; x++){
          result.add(BarChartGroupData(
              x: x,
              barRods: [BarChartRodData(
                  toY: dailyData[x].stepCnt.toDouble(),
                  color: Colors.deepPurpleAccent,
                  width: 30.w,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
              )
              ]
          ));
        }
        break;
      case ActGraphSelection.DISTANCE:
        for(int x = 0; x < dailyData.length; x++){
          result.add(BarChartGroupData(x: x, barRods: [BarChartRodData(toY: dailyData[x].distance.toDouble(), color: Colors.deepPurpleAccent)]));
        }
        break;
      case ActGraphSelection.CALORIE:
        for(int x = 0; x < dailyData.length; x++){
          result.add(BarChartGroupData(x: x, barRods: [BarChartRodData(toY: dailyData[x].calorie.toDouble(), color: Colors.deepPurpleAccent)]));
        }
        break;
    }
    return result;
  }

  Widget _xWeekTitle(double value, TitleMeta meta){
    Widget weekly;

    switch(value.toInt()){
      case 0:
        weekly = Text('월');
        break;
      case 1:
        weekly = Text('화');
        break;
      case 2:
        weekly = Text('수');
        break;
      case 3:
        weekly = Text('목');
        break;
      case 4:
        weekly = Text('금');
        break;
      case 5:
        weekly = Text('토');
        break;
      case 6:
        weekly = Text('일');
        break;
      default:
        weekly = Text('일');
        break;
    }

    return SideTitleWidget(meta: meta, child: weekly);
  }


}