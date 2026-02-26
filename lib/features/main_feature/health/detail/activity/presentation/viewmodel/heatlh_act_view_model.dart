import 'package:bodymind/features/main_feature/health/detail/activity/domain/entity/act_graph_dto.dart';
import 'package:bodymind/features/main_feature/health/detail/activity/presentation/view/enum/act_graph_option.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActDtlState {
  final int mainScore;
  final ActGraphSelection selectedOption;
  final bool isWeekly;
  final String mainScoreEvaluation;
  final List<ActGraphDto> actDatas;
  final DateTime selectedDate;
  final String evaluationPrev;

  ActDtlState(
    this.mainScore,
    this.isWeekly,
    this.mainScoreEvaluation,
    this.actDatas,
    this.selectedDate, {
    this.selectedOption = ActGraphSelection.COUNT,
        this.evaluationPrev =' 데이터 없음'
  });

  factory ActDtlState.initial() =>
      ActDtlState(0, true, '데이터 없음', [], DateTime.now());
}

class HeatlhActViewModel extends Notifier<ActDtlState> {
  @override
  ActDtlState build() {
    // TODO: implement build
    throw UnimplementedError();
  }
}
