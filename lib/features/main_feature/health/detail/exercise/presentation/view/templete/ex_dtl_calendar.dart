import 'package:bodymind/features/main_feature/health/detail/exercise/domain/entity/ex_month_dto.dart';
import 'package:bodymind/features/main_feature/home/presentation/viewmodel/injector/home_exercise_injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../home/presentation/theme/home_theme.dart';

class ExDtlCalendar extends StatefulWidget{
  final DateTime initialDate;
  DateTime? firstDate;
  DateTime? lastDate;
  final ValueChanged<DateTime> onDateSelected;
  final ExMonthDto exDatas;

  ExDtlCalendar({
    required this.initialDate,
    required this.onDateSelected, super.key,
    required this.exDatas,
    this.firstDate,
    this.lastDate
  }
  ){
    firstDate ?? DateTime(2020);
    lastDate ?? DateTime(2030);
  }

  @override
  State<StatefulWidget> createState() =>ExDtlCalendarState();

}

class ExDtlCalendarState extends State<ExDtlCalendar>{
  static const List<String> weekDays = ['월', '화', '수', '목', '금', '토', '일'];

  late DateTime selectedDate;
  late DateTime visibleMonth;
  late ExMonthDto datas;

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
    datas = widget.exDatas;
  }

  @override
  Widget build(BuildContext context) {
    final dates = _buildCalendarDates();
    final today = _dateOnly(widget.initialDate);
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              children: weekDays
                  .map(
                    (day) => Expanded(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.w),
                      child: Text(
                        day,
                        style: HomeTheme.suggestTextStyle.copyWith(color: day == '토'
                            ? Colors.blue
                            : day == '일'
                            ? Colors.red
                            : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
              ).toList(),
            ),
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 8.h ),
              child: GridView.builder(
                itemCount: dates.length,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisSpacing: 2.h,
                  crossAxisSpacing: 4.w,
                  childAspectRatio: 1.sp
                ),
                itemBuilder: (ctx,idx){
                  final date = dates[idx];
                  final bool isCurrentMonth = date.month == visibleMonth.month;
                  final bool isSelected = _isSameDate(date, selectedDate);
                  final bool isToday = _isSameDate(date, today);
                  final bool isEnabled = _isSelectable(date);
                  final List<Widget> typeIcons = _iconCreator(date, datas);

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
                            ? Colors.black87
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
                          return Center(
                            child: Column(
                              mainAxisAlignment: .spaceBetween,
                              children: [
                                Text(
                                  '${date.day}',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: isSelected || isToday
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                    color: isSelected ? Colors.white : textColor,
                                  ),
                                ),
                                SizedBox(
                                  height: constraint.maxHeight * 0.2,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: typeIcons,
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),


    );
  }

  List<Widget> _iconCreator(DateTime date, ExMonthDto datas){
    List<Widget> typeIcons = List.empty(growable: true);
    datas.dailyData.where((e) => e.day == date.day).map((e){
      e.element.map((e) {
        if(typeIcons.length > 3){
          return;
        }
        switch(e.exType){

          case ExerciseType.walkRun:
            typeIcons.add(Container(
              height: 4.h,
              width: 4.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Color(0xffDBEAFE)
              ),
              child: Center(
                child: SvgPicture.asset('assets/images/icon/ex/runner.svg',colorFilter: ColorFilter.mode(Color(0xff2563eb), BlendMode.srcIn),),
              ),
            ));
            break;

          case ExerciseType.cycle:
            typeIcons.add(Container(
              height: 4.h,
              width: 4.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Color(0xffDBEAFE)
              ),
              child: Center(
                child: SvgPicture.asset('assets/images/icon/ex/cycle.svg',colorFilter: ColorFilter.mode(Color(0xff2563eb), BlendMode.srcIn),),
              ),
            ));
            break;

          case ExerciseType.strength:
            typeIcons.add(Container(
              height: 4.h,
              width: 4.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Color(0xffDBEAFE)
              ),
              child: Center(
                child: SvgPicture.asset('assets/images/icon/ex/strength.svg',colorFilter: ColorFilter.mode(Color(0xff2563eb), BlendMode.srcIn),),
              ),
            ));
            break;

          case ExerciseType.swim:
            typeIcons.add(Container(
              height: 4.h,
              width: 4.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Color(0xffDBEAFE)
              ),
              child: Center(
                child: SvgPicture.asset('assets/images/icon/ex/swim.svg',colorFilter: ColorFilter.mode(Color(0xff2563eb), BlendMode.srcIn),),
              ),
            ));
            break;
        }
      });
    });
    return typeIcons;
  }

}