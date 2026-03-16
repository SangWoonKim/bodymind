import 'package:bodymind/features/main_feature/health/detail/exercise/domain/entity/ex_month_dto.dart';
import 'package:bodymind/features/main_feature/health/detail/exercise/domain/usecase/ex_dtl_usecase.dart';
import 'package:bodymind/features/main_feature/health/detail/exercise/presentation/provider/ex_dtl_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/util/bodymind_core_util.dart';
import '../../domain/entity/ex_daily_dto.dart';
class ExDtlState {
  final DateTime selectedDate;
  final ExMonthDto exDatas;

  ExDtlState(this.selectedDate, this.exDatas);

  factory ExDtlState.initialize() {
    final now = DateTime.now();
    return ExDtlState(now, ExMonthDto(
      now,
      []
    ));
  }

  ExDtlState copyWith(
  DateTime? selectedDate,
  ExMonthDto? exDatas
  ){
    return ExDtlState(selectedDate ?? this.selectedDate, exDatas ?? this.exDatas);
  }
}

class ExDtlViewmodel extends AutoDisposeNotifier<ExDtlState>{
  late final ExDtlUsecase _exDtlUsecase;

  @override
  ExDtlState build() {
    _exDtlUsecase = ref.read(exDtlUsecaseProvider);
    Future.microtask(()=> initalize(DateTime.now()));
    return ExDtlState.initialize();
  }

  Future<void> initalize(DateTime initDate) async{
    await _loadExData(initDate);
  }

  Future<void> _loadExData(DateTime requestDate) async{
    final loadMonthRange = TimeUtil().buildMonthWeekRanges(requestDate.year, requestDate.month);
    final stYmd = TimeUtil.dateTimeToyymmdd(loadMonthRange.monthStart);
    final endYmd = TimeUtil.dateTimeToyymmdd(loadMonthRange.monthEnd);
    state = state.copyWith(requestDate, await _exDtlUsecase.loadDbExData(stYmd, endYmd, requestDate) ?? ExMonthDto(requestDate, []));
  }

  Future<void> selectDate(DateTime selectedDate) async{
    if(state.selectedDate.month != selectedDate.month){
      _loadExData(selectedDate);
    }else{
      state = state.copyWith(selectedDate, null);
    }
  }

}