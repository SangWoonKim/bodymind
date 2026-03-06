import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../const/theme/global_theme.dart';
import '../main_feature/health/detail/util/feature_theme.dart';
import '../main_feature/home/presentation/theme/home_theme.dart';

class ActionCalendar {
  Future<DateTime?> showActionCalendar({
    required BuildContext context,
    required DateTime initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) {
    return showGeneralDialog<DateTime>(
      context: context,
      barrierLabel: 'calendar',
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.35),
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (dialogContext, animation, secondaryAnimation) {
        final screen = MediaQuery.of(dialogContext).size;

        return SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: screen.width,
                height: screen.height * 0.5,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 12,
                      offset: Offset(0, 4),
                      color: Colors.black12,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 8, 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '날짜 선택',
                              style: GlobalTheme.titleCustomText,
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(dialogContext),
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    Expanded(
                      child: CustomCalendar(
                        initialDate: initialDate,
                        firstDate: firstDate ?? DateTime(2020),
                        lastDate: lastDate ?? DateTime(2030),
                        onDateSelected: (date) {
                          Navigator.pop(dialogContext, date);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ),
          ),
          child: child,
        );
      },
    );
  }

  Future<void> openActionCalendar({
    required BuildContext context,
    required DateTime initialDate,
    required ValueChanged<DateTime> onSelected,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    final picked = await showActionCalendar(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked == null) return;
    onSelected(picked);
  }
}


class CustomCalendar extends StatefulWidget {
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final ValueChanged<DateTime> onDateSelected;

  const CustomCalendar({
    super.key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.onDateSelected,
  });

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  static const List<String> weekDays = ['월', '화', '수', '목', '금', '토', '일'];

  late DateTime selectedDate;
  late DateTime visibleMonth;

  @override
  void initState() {
    super.initState();
    selectedDate = _dateOnly(widget.initialDate);
    visibleMonth = DateTime(widget.initialDate.year, widget.initialDate.month);
  }

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
    return !d.isBefore(_dateOnly(widget.firstDate)) &&
        !d.isAfter(_dateOnly(widget.lastDate));
  }

  void _moveMonth(int offset) {
    final moved = DateTime(visibleMonth.year, visibleMonth.month + offset, 1);

    final firstMonth = DateTime(widget.firstDate.year, widget.firstDate.month, 1);
    final lastMonth = DateTime(widget.lastDate.year, widget.lastDate.month, 1);

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
  Widget build(BuildContext context) {
    final dates = _buildCalendarDates();
    final today = _dateOnly(DateTime.now());

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
          child: Row(
            children: [
              /// 상단 월 선택 탭
              IconButton(
                onPressed: () => _moveMonth(-1),
                icon: const Icon(Icons.chevron_left),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    '${visibleMonth.year}.${visibleMonth.month.toString().padLeft(2, '0')}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () => _moveMonth(1),
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
        ),
        /// 주별 요일 String
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: weekDays
                .map(
                  (day) => Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
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
            )
                .toList(),
          ),
        ),
        const Divider(height: 1),
        /// 달력 grid 생성
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: dates.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 2.h,
                crossAxisSpacing: 4.w,
                childAspectRatio: 1.sp,
              ),
              // 날 데이터 생성
              itemBuilder: (context, index) {
                final date = dates[index];
                final bool isCurrentMonth = date.month == visibleMonth.month;
                final bool isSelected = _isSameDate(date, selectedDate);
                final bool isToday = _isSameDate(date, today);
                final bool isEnabled = _isSelectable(date);

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
                    child: Center(
                      child: Text(
                        '${date.day}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: isSelected || isToday
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: isSelected ? Colors.white : textColor,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

