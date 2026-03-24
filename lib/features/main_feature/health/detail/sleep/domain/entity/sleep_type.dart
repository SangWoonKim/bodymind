import 'package:common_mutiple_health/entity/const/sleep_type.dart';

enum SleepType{
  awake(0),
  light(1),
  rem(2),
  deep(3);

  final int value;
  const SleepType(this.value);

  static SleepType convertInt(int sleepInt){
    return SleepType.values.firstWhere((e) => sleepInt == e.value);
  }
}