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

  static String convertOrigin(int sleepEnumVal){
    if(sleepEnumVal == 1){
      return 'A';
    } else if(sleepEnumVal == 2){
      return 'A';
    } else if(sleepEnumVal == 3){
      return 'L';
    }else if(sleepEnumVal == 4){
      return 'D';
    }else if(sleepEnumVal == 5){
      return 'R';
    }else{
      return 'A';
    }
  }
}