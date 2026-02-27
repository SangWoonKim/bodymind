import 'package:bodymind/features/main_feature/health/detail/activity/presentation/viewmodel/heatlh_act_view_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

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
    return BarChart(BarChartData(
      maxY: 7,
      minY: 0,
      gridData: FlGridData(show: true),
      borderData: FlBorderData(show: true),
      titlesData: FlTitlesData(
          show: true,
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 20,
              reservedSize: 36,
              getTitlesWidget: (value, meta) => Text(value.toInt().toString()),),
          ),
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: xWeekTitle)
          )
      ),
      barGroups: barDatas(option),
    ));


  }



  List<BarChartGroupData> barDatas(ActGraphSelection select){
    List<BarChartGroupData> result = List.empty(growable: true);
    DateTime start = weeklyData.weeklyMondayDate;
    List<ActDailyDto> dailyData = List.empty(growable: true);

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
    final modDay = dailyData.last.measrueDt.difference(start).inDays;
    if(modDay != 0){
      for(int i = 0; i< modDay; i++){
        dailyData.add(ActDailyDto(0, 0, 0, DateTime(start.year, start.month, start.day + 1)));
      }
    }
    switch(select){
    //for문 중간에 색상 변경해야함(오늘 데이터일 경우와 어제 데이터일 경우)
      case ActGraphSelection.COUNT:
        for(int x = 0; x < dailyData.length; x++){
          result.add(BarChartGroupData(x: x, barRods: [BarChartRodData(toY: dailyData[x].stepCnt.toDouble(), color: Colors.deepPurpleAccent)]));
        }
        break;
      case ActGraphSelection.DISTANCE:
        for(int x = 0; x < dailyData.length; x++){
          result.add(BarChartGroupData(x: x, barRods: [BarChartRodData(toY: dailyData[x].stepCnt.toDouble(), color: Colors.deepPurpleAccent)]));
        }
        break;
      case ActGraphSelection.CALORIE:
        for(int x = 0; x < dailyData.length; x++){
          result.add(BarChartGroupData(x: x, barRods: [BarChartRodData(toY: dailyData[x].stepCnt.toDouble(), color: Colors.deepPurpleAccent)]));
        }
        break;
    }
    return result;
  }

  Widget xWeekTitle(double value, TitleMeta meta){
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