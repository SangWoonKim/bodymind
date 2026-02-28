import 'package:intl/intl.dart';
class WeekRange {
  final int weekOfMonth;   // 1..N
  final DateTime start;    // Monday
  final DateTime end;      // Sunday (but clamped to month end)

  const WeekRange(this.weekOfMonth, this.start, this.end);
}

class MonthRangeResult {
  final DateTime monthStart;   // yyyy-mm-01
  final DateTime monthEnd;     // last day of month
  final List<WeekRange> weeks; // 1..N

  const MonthRangeResult(this.monthStart, this.monthEnd, this.weeks);

}

class MonthWeek {
  final int year;
  final int month; // 표시할 월 (전월로 넘어가면 전월)
  final int week;  // 1..N
  final DateTime weekStart; // 월요일
  final DateTime weekEnd;   // 일요일

  const MonthWeek({
    required this.year,
    required this.month,
    required this.week,
    required this.weekStart,
    required this.weekEnd,
  });

  String label() => '${month}월 ${week}주차';
}

class TimeUtil {
  static int hhmmToMinute(String hhmm) {
    final hh = int.parse(hhmm.substring(0, 2));
    final mm = int.parse(hhmm.substring(2, 4));
    return hh * 60 + mm;
  }

  static String dateTimeToyymmdd(DateTime dateTime){
    return dateTime.year.toString().padLeft(2,'0') +
        dateTime.month.toString().padLeft(2,'0') +
        dateTime.day.toString().padLeft(2,'0');
  }

  static String dateTimeToHHmm(DateTime dateTime){
    return dateTime.hour.toString().padLeft(2,'0') +
        dateTime.minute.toString().padLeft(2,'0');
  }

  static String dateTimeToFullDt(DateTime dateTime){
    return dateTime.year.toString().padLeft(2,'0') +
        dateTime.month.toString().padLeft(2,'0') +
        dateTime.day.toString().padLeft(2,'0') +
        dateTime.hour.toString().padLeft(2,'0') +
        dateTime.minute.toString().padLeft(2,'0');
  }

  static DateTime yyyyMMddHHmmToDateTime(String ymdhm){
    String s = ymdhm.trim();
    if (s.length != 12) {
      s = ymdhm +'0000';
    }
    final y = int.parse(s.substring(0, 4));
    final m = int.parse(s.substring(4, 6));
    final d = int.parse(s.substring(6, 8));
    final h = int.parse(s.substring(8, 10));
    final mm = int.parse(s.substring(10, 12));
    return DateTime(y, m, d, h, mm);
  }

  static DateTime yyyyMMddToDateTime(String ymd) {
    final s = ymd.trim();
    if (s.length < 8) {
      throw FormatException('Expected yyyyMMdd(8), got "$s" len=${s.length}');
    }
    final y = int.parse(s.substring(0, 4));
    final m = int.parse(s.substring(4, 6));
    final d = int.parse(s.substring(6, 8));
    return DateTime(y, m, d);
  }

  static String commonKoreanDate(DateTime date) {
    return DateFormat('M월 d일 (E)', 'ko_KR').format(date);
  }
  static String yyyyMMddToMdForDate(DateTime date) {
    return DateFormat('M월 d일 (E)', 'ko_KR').format(date);
  }

  static String yyyyMMddToMdString(String date){
    return DateFormat('M월 d일', 'ko_KR').format(yyyyMMddToDateTime(date));
  }

  static String yyyyMMddToEString(String date){
    return DateFormat('E요일', 'ko_KR').format(yyyyMMddToDateTime(date));
  }

  /**
   * ============================ 주차 별 계산(bussiness rogic) start
   * */
  DateTime _monthStart(int year, int month) => DateTime(year, month, 1);

  DateTime _monthEnd(int year, int month) =>
      DateTime(year, month + 1, 1).subtract(const Duration(days: 1));

  /// 년도와 월을 넣을시 그 달의 첫번째 월요일을 반환
  DateTime firstMondayOfMonthToInt(int year, int month) {
    final firstDay = DateTime(year, month, 1);
    final daysToNextMonday = (DateTime.monday - firstDay.weekday) % 7;
    return firstDay.add(Duration(days: daysToNextMonday));
  }

  ///월 주차 계산 + 0주차 제거(전월로 넘김)
  MonthRangeResult buildMonthWeekRanges(int year, int month) {
    final start = _monthStart(year, month);
    final end = _monthEnd(year, month);
    final week1Start = firstMondayOfMonthToInt(year, month);

    // week1Start가 monthEnd보다 뒤면(그 달에 월요일이 없는 경우는 없음) 방어 처리
    if (week1Start.isAfter(end)) {
      return MonthRangeResult(start, end, const []);
    }

    final weeks = <WeekRange>[];
    int w = 1;
    DateTime curStart = week1Start;

    while (!curStart.isAfter(end)) {
      final curEnd = curStart.add(const Duration(days: 6));
      final clampedEnd = curEnd.isAfter(end) ? end : curEnd;

      weeks.add(WeekRange(w, curStart, clampedEnd));

      w += 1;
      curStart = curStart.add(const Duration(days: 7));
    }

    return MonthRangeResult(start, end, weeks);
  }

  /**
   * ============================ 주차 별 계산(bussiness rogic) end
   * */


  /**
   * ============================ 주차 별 계산(view rogic) start
   * */

  /// 그 달의 첫 월요일(1주차 시작)
  DateTime firstMondayOfMonthToUi(int year, int month) {
    final firstDay = DateTime(year, month, 1);
    final daysToNextMonday = (DateTime.monday - firstDay.weekday) % 7;
    return firstDay.add(Duration(days: daysToNextMonday));
  }

  /// month에 속한 주차 개수(첫 월요일부터 monthEnd까지)
  int weeksCountOfMonthToUi(int year, int month) {
    final firstMonday = firstMondayOfMonthToUi(year, month);
    final monthEnd = DateTime(year, month + 1, 1).subtract(const Duration(days: 1));

    if (firstMonday.isAfter(monthEnd)) return 0;

    final days = monthEnd.difference(firstMonday).inDays; // 0 이상
    return (days ~/ 7) + 1;
  }

  /// - 첫 월요일 이전이면 전월로 넘겨서 전월 주차로 반환
  MonthWeek monthWeekByFirstMondayRuleToUi(DateTime date) {
    final parseDate = DateTime(date.year, date.month, date.day);
    final firstMonday = firstMondayOfMonthToUi(parseDate.year, parseDate.month);

    // 첫 월요일 이전이면 전월 마지막 날로 넘겨서 "전월 주차" 반환
    if (parseDate.isBefore(firstMonday)) {
      final prevMonthLastDay = DateTime(parseDate.year, parseDate.month, 0);
      return monthWeekByFirstMondayRuleToUi(prevMonthLastDay);
    }

    final diffDays = parseDate.difference(firstMonday).inDays;
    final week = (diffDays ~/ 7) + 1;

    final weekStart = firstMonday.add(Duration(days: 7 * (week - 1)));
    final weekEnd = weekStart.add(const Duration(days: 6));

    return MonthWeek(
      year: parseDate.year,
      month: parseDate.month,
      week: week,
      weekStart: weekStart,
      weekEnd: weekEnd,
    );
  }
}