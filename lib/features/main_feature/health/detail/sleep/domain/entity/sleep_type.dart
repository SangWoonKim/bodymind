import 'package:common_mutiple_health/entity/const/sleep_type.dart';

enum SleepType{
  awake(0,'A'),
  light(1,'L'),
  rem(2,'R'),
  deep(3,'D');

  final int value;
  final String typeStr;
  const SleepType(this.value, this.typeStr);

  static SleepType convertInt(int sleepInt){
    return SleepType.values.firstWhere((e) => sleepInt == e.value);
  }

  static SleepType convertStr(String sleepType){
    return SleepType.values.firstWhere((e) => sleepType == e.typeStr);
  }
}