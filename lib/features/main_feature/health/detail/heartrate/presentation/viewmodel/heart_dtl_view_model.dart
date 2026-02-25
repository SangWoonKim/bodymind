import 'package:bodymind/core/util/bodymind_core_util.dart';
import 'package:bodymind/features/main_feature/health/detail/heartrate/domain/usecase/heart_dtl_usecase.dart';
import 'package:bodymind/features/main_feature/health/detail/heartrate/provider/heart_dtl_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class HeartDtlState{
  final String yyyyMMdd;
  final List<int> hrLst;
  final int maxHr;
  final int minHr;
  final int avgHr;
  final int stablePercent;
  final bool isExist;

  HeartDtlState(this.yyyyMMdd, this.hrLst, this.maxHr, this.minHr, this.avgHr,
      this.stablePercent, this.isExist);

  factory HeartDtlState.initial() => HeartDtlState(
      TimeUtil.dateTimeToyymmdd(DateTime.now()),
      [],
      0,
      0,
      0,
      0,
      false);


}

class HeartDtlViewModel extends Notifier<HeartDtlState>{
  late final HeartDtlUsecase _hrUsecase;
  late DateTime _initializedDay;

  @override
  HeartDtlState build() {
    _hrUsecase = ref.read(hrDtlRepoUsecase);
    _initializedDay = DateTime.now();
    Future.microtask(() => loadHrData(null));
    return HeartDtlState.initial();
  }

  Future<void> loadHrData(int? moveDay) async{
    _initializedDay = _initializedDay.add(Duration(days: moveDay ?? 0));
    String yyyyMMdd = TimeUtil.dateTimeToyymmdd(_initializedDay);
    final rec = await _hrUsecase.loadDbHrData(yyyyMMdd);
    if(rec == null) {
      state = HeartDtlState(yyyyMMdd,[],0,0,0,0,false);
      return;
    }else{
      final stableCnt = rec!.hrLst.where((e) => e >= 60 && 80 <= e).toList().length;
      state = HeartDtlState(yyyyMMdd, rec!.hrLst, rec!.max, rec!.min, rec.avg, ((stableCnt / rec.hrLst.length) * 100).round(), true);
    }
  }

}