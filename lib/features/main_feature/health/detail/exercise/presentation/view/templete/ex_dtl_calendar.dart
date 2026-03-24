import 'package:bodymind/features/main_feature/health/detail/exercise/domain/entity/ex_daily_dto.dart';
import 'package:bodymind/features/main_feature/health/detail/exercise/domain/entity/ex_element_dto.dart';
import 'package:bodymind/features/main_feature/health/detail/exercise/domain/entity/ex_month_dto.dart';
import 'package:bodymind/features/main_feature/home/presentation/viewmodel/injector/home_exercise_injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:collection/collection.dart';
import '../../../../../../home/presentation/theme/home_theme.dart';

class ExDtlCalendar extends StatefulWidget{
  final DateTime initialDate;
  DateTime? firstDate;
  DateTime? lastDate;
  final ValueChanged<DateTime> onDateSelected;
  final ExMonthDto exDatas;

  ExDtlCalendar({
    super.key,
    required this.initialDate,
    required this.onDateSelected,
    required this.exDatas,
    DateTime? firstDate,
    DateTime? lastDate,
  })  : firstDate = firstDate ?? DateTime(2020, 1, 1),
        lastDate = lastDate ?? DateTime(2030, 12, 31);

  @override
  State<StatefulWidget> createState() =>ExDtlCalendarState();

}

class ExDtlCalendarState extends State<ExDtlCalendar>{
  static const List<String> weekDays = ['월', '화', '수', '목', '금', '토', '일'];

  late DateTime selectedDate;
  late DateTime visibleMonth;
  late Map<int, List<ExElementDto>> groupedData;

  DateTime _dateOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  DateTime _monthStart(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  DateTime _monthEnd(DateTime date) {
    return DateTime(date.year, date.month + 1, 0);
  }

  bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  bool _isSelectable(DateTime date) {
    final d = _dateOnly(date);
    return !d.isBefore(_dateOnly(widget.firstDate!)) &&
        !d.isAfter(_dateOnly(widget.lastDate!));
  }

  void _moveMonth(int offset) {
    final moved = DateTime(visibleMonth.year, visibleMonth.month + offset, 1);

    final firstMonth = DateTime(widget.firstDate!.year, widget.firstDate!.month, 1);
    final lastMonth = DateTime(widget.lastDate!.year, widget.lastDate!.month, 1);

    if (moved.isBefore(firstMonth) || moved.isAfter(lastMonth)) return;

    setState(() {
      visibleMonth = moved;
    });
  }

  List<DateTime> _buildCalendarDates() {
    //해당 달의 start / end 날짜 구함
    final firstDayOfMonth = _monthStart(visibleMonth);
    final lastDayOfMonth = _monthEnd(visibleMonth);

    //월요일 부터 시작
    final int startOffset = firstDayOfMonth.weekday - 1; // 월=1 ... 일=7
    final DateTime gridStart = firstDayOfMonth.subtract(Duration(days: startOffset));

    final int endOffset = 7 - lastDayOfMonth.weekday;
    final DateTime gridEnd = lastDayOfMonth.add(Duration(days: endOffset));

    final days = <DateTime>[];
    DateTime current = gridStart;

    while (!current.isAfter(gridEnd)) {
      days.add(current);
      current = current.add(const Duration(days: 1));
    }

    return days;
  }

  @override
  void initState() {
    super.initState();
    selectedDate = _dateOnly(widget.initialDate);
    visibleMonth = DateTime(widget.initialDate.year, widget.initialDate.month);
    Map<int,List<ExElementDto>> data = {};
    widget.exDatas.dailyData.forEach((e) => data.addAll({e.day: e.element}));
    groupedData = data;

  }

  @override
  void didUpdateWidget(covariant ExDtlCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(oldWidget.initialDate != widget.initialDate){
      setState(() {
        visibleMonth = DateTime(widget.initialDate.year, widget.initialDate.month);
      });
    }

    if(oldWidget.exDatas != widget.exDatas){
      setState(() {
        Map<int,List<ExElementDto>> data = {};
        widget.exDatas.dailyData.forEach((e) => data.addAll({e.day: e.element}));
        groupedData = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dates = _buildCalendarDates();
    final today = _dateOnly(selectedDate);
    return Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 8.h),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final rowCount = (dates.length / 7).ceil();

            const crossAxisCount = 7;
            final crossSpacing = 4.w;
            final mainSpacing = 2.h;

            final totalHorizontalSpacing = crossSpacing * (crossAxisCount - 1);
            final totalVerticalSpacing = mainSpacing * (rowCount - 1);

            final cellWidth =
                (constraints.maxWidth - totalHorizontalSpacing) / crossAxisCount;
            final cellHeight =
                (constraints.maxHeight - totalVerticalSpacing) / rowCount;

            final aspectRatio = cellWidth / cellHeight;

            return GridView.builder(
              itemCount: dates.length,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: mainSpacing,
                crossAxisSpacing: crossSpacing,
                childAspectRatio: aspectRatio,
              ),
              itemBuilder: (ctx, idx) {
                final date = dates[idx];
                final bool isCurrentMonth = date.month == visibleMonth.month;
                final bool isSelected = _isSameDate(date, selectedDate);
                final bool isToday = _isSameDate(date, today);
                final bool isEnabled = _isSelectable(date);
                final List<Widget> typeIcons = _iconCreator(date, widget.exDatas);

                Color textColor = Colors.black87;
                if (date.weekday == DateTime.saturday) textColor = Colors.blue;
                if (date.weekday == DateTime.sunday) textColor = Colors.red;

                if (!isCurrentMonth) {
                  textColor = textColor.withOpacity(0.25);
                } else if (!isEnabled) {
                  textColor = Colors.grey.shade400;
                }

                return InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: (!isEnabled || !isCurrentMonth)
                      ? null
                      : () {
                    setState(() {
                      selectedDate = date;
                    });
                    widget.onDateSelected(date);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Color(0xff3b82f6)
                          : isToday
                          ? Colors.grey.shade200
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: isToday && !isSelected
                          ? Border.all(color: Colors.black26)
                          : null,
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraint) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${date.day}',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: isSelected || isToday
                                      ? FontWeight.w500
                                      : FontWeight.w500,
                                  color: isSelected ? Colors.white : textColor,
                                ),
                              ),
                              SizedBox(
                                height: constraint.maxHeight * 0.22,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: typeIcons,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      );
  }

  List<Widget> _iconCreator(DateTime date, ExMonthDto datas){
    List<Widget> typeIcons = List.empty(growable: true);

    final dailyData = groupedData[date.day] ?? [];

    for(final e in dailyData){
        if(typeIcons.length > 3) break;

        //색상 및 아이콘 작업 필요
        switch(e.exType){

          case ExerciseType.walkRun:
            typeIcons.add(Container(
              height: 4.h,
              width: 4.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Color(0xff2563eb)
              ),
            ));
            break;

          case ExerciseType.cycle:
            typeIcons.add(Container(
              height: 4.h,
              width: 4.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Color(0xff2563eb)
              ),
            ));
            break;

          case ExerciseType.strength:
            typeIcons.add(Container(
              height: 4.h,
              width: 4.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Color(0xffdcfce7)
              ),
            ));
            break;

          case ExerciseType.swim:
            typeIcons.add(Container(
              height: 4.h,
              width: 4.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Color(0xfff97316)
              ),
            ));
            break;
          case ExerciseType.cadio:
            typeIcons.add(Container(
              height: 4.h,
              width: 4.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Color(0xffDBEAFE)
              ),
              child: Center(
                child: SvgPicture.asset('assets/images/icon/ex/swim.svg',colorFilter: ColorFilter.mode(Color(0xffef4444), BlendMode.srcIn),),
              ),
            ));
            break;
        }
    }
    return typeIcons;
  }

}