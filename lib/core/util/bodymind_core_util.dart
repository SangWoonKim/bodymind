import 'package:intl/intl.dart';

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

  static String yyyyMMddToMdString(String date){
    return DateFormat('M월 d일', 'ko_KR').format(yyyyMMddToDateTime(date));
  }

  static String yyyyMMddToEString(String date){
    return DateFormat('E요일', 'ko_KR').format(yyyyMMddToDateTime(date));
  }
}