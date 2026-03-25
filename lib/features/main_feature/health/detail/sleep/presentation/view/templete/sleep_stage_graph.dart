import 'package:bodymind/features/main_feature/health/detail/sleep/domain/entity/sleep_stage.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SleepStageGraph extends StatelessWidget{
  final List<SleepStage>? stages;
  final DateTime? startTime;


  const SleepStageGraph({
    super.key,
    required this.stages,
    required this.startTime
  });

  @override
  Widget build(BuildContext context) {

    if(stages == null){
      return const Center(child: Text('수면 데이터가 없습니다'));
    }


    final markerSpots = <FlSpot>[];
    int runningTime = 0;

    for (var e in stages!) {
      markerSpots.add(
        FlSpot(runningTime.toDouble(), e.stage.value.toDouble()),
      );
      runningTime += e.durationMin;
    }

    final totalMins = runningTime;
    return LineChart(
      LineChartData(
        minX: 0,
        maxX: totalMins.toDouble(),
        minY: 0,
        maxY: 3,

        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          verticalInterval: 30,
          horizontalInterval: 1,
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
              interval: 1,
              getTitlesWidget: (value, meta) {
                return Text(value.toInt().toString());
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 30,
              getTitlesWidget: (value, meta) {
                final min = value.toInt();
                final time = startTime!.add(Duration(minutes: min));
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

        lineBarsData: [
          if(markerSpots.isNotEmpty)
            LineChartBarData(
              spots: markerSpots,
              barWidth: 2.sp,
              color: Colors.grey,
              isCurved: false,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(show: false),
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, bar, index){
                  Color dotColor = Color(0xffF87171);
                  if(spot.y.toInt() == 0){ //awake
                    dotColor = Color(0xffF87171);
                  }else if(spot.y.toInt() == 1){ //light
                    dotColor = Color(0xffFACC15);
                  }else if(spot.y.toInt() == 2){ //rem
                    dotColor = Color(0xff22C55E);
                  }else if(spot.y.toInt() == 3){ //deep
                    dotColor = Color(0xffA855F7);
                  }

                  return FlDotCirclePainter(
                    radius: 3,
                    color: dotColor,
                    strokeWidth: 2,
                    strokeColor: Colors.white60
                  );
                }
              )
            ),
        ]
      )
    );
  }

}