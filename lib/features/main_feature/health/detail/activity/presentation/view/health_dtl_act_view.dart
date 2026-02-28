import 'package:bodymind/const/theme/global_theme.dart';
import 'package:bodymind/core/util/fourth.dart';
import 'package:bodymind/core/widget/cus_appbar.dart';
import 'package:bodymind/features/main_feature/health/detail/activity/presentation/provider/health_act_dtl_provider.dart';
import 'package:bodymind/features/main_feature/health/detail/activity/presentation/view/enum/act_graph_option.dart';
import 'package:bodymind/features/main_feature/health/detail/activity/presentation/view/templete/act_montly_graph_view.dart';
import 'package:bodymind/features/main_feature/health/detail/activity/presentation/view/templete/act_weekly_graph_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../../../../core/util/bodymind_core_util.dart';
import '../../../../../home/presentation/theme/home_theme.dart';
import '../../../util/feature_theme.dart';
import '../viewmodel/heatlh_act_view_model.dart';
class HealthDtlActView extends ConsumerStatefulWidget{
  final String? receivedYmd;

  HealthDtlActView({super.key, this.receivedYmd});

@override
  ConsumerState<ConsumerStatefulWidget> createState() => _HealthDtlActViewState();
}
class _HealthDtlActViewState extends ConsumerState<HealthDtlActView>{
  static const int _initialPage = 10000;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _initialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _movePrevDay() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  void _moveNextDay() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(actDtlViewModelProvider);

    return Scaffold(
      //actions에 달력 아이콘을 넣어서 주간 월간 선택 달력을 띄워야함
      appBar: CustomAppBar(
        title: '활동 상세',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _dateSelector(state, ref, _movePrevDay, _moveNextDay),
          Gap(20.h),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (page){
                // WidgetsBinding.instance.addPostFrameCallback((_){
                //   // if(mounted) _pageController.jumpToPage(_initialPage);
                // });
              },

              itemBuilder: (context,idx){
                return _infoSection(state);
              },
            ),
          )
        ],
      )
      ,
    );
  }

  Widget _infoSection(ActDtlState state){
    return state.actDatas.weeklyData.isEmpty ? CircularProgressIndicator(): SingleChildScrollView(
      child: Column(
        children: [
          _evaluationWidget(state),
          Gap(20.h),
          _actGraph(state),
          Gap(20.h),
          _gridSummaryInfo(state)
        ],
      ),
    );
  }

  //날짜 selector(주간일경우 2월 1주차, 월간일경우 2월)
  Widget _dateSelector(
      ActDtlState state,
      WidgetRef ref,
      Function() tapPrevious,
      Function() tapForward,
      ) {
    //주간 월간 선택여부에 따라 달라져야함
    //mdstr 주간 x월 / 월간 x월
    //eStr 주간 x주차 / none
    final mdStr = TimeUtil().monthWeekByFirstMondayRuleToUi(state.selectedDate);
    return Container(
      width: 335.w,
      height: 78.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 40.h,
                width: 40.w,
                child: InkWell(
                  onTap: tapPrevious,
                  child: Icon(Icons.arrow_back_ios, color: Colors.black),
                ),
              ),
              SizedBox(
                height: 46.h,
                width: 69.w,
                child: Column(
                  children: [
                    Text('${mdStr.month}월', style: FeatureTheme.hrMdText),
                    Text('${mdStr.week}주차', style: HomeTheme.infoTextStyle),
                  ],
                ),
              ),
              SizedBox(
                height: 40.h,
                width: 40.w,
                child: InkWell(
                  onTap: tapForward,
                  child: Icon(Icons.arrow_forward_ios, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _evaluationWidget(ActDtlState state){
    return Container(
      height: 152.h, 
      width: 336.w,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentGeometry.topLeft,
              end: AlignmentGeometry.bottomRight,
              colors: [
                Color(0xff6366F1),
                Color(0xff9333EA)
              ]
          )
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: double.infinity,
                height: 72.h,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //활동 점수 container
                    SizedBox(
                      width: 60.h,
                      height: 72.h,
                      child: RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '활동점수', style: HomeTheme.suggestTextStyle
                            ),
                            TextSpan(
                              text: state.mainScore.toString(), style: FeatureTheme.actMainScoreText
                            )
                          ]
                        )
                      ),
                    ),

                    //평가 문장 컨테이너
                    Container(
                      width: 124.w, height: 32.h,
                      color: Colors.white.withValues(alpha: 0.20),
                      child: Center(
                        child: Text(state.mainScoreEvaluation, style: HomeTheme.leadingTextStyle,)
                      ),
                    )

                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 20.h,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //삼항연산자 중첩 >, =, < 을 통한 아이콘 분기
                    Icon(Icons.arrow_upward_rounded),
                    Gap(6.w),
                    //삼항연산자 2개는 너무한데.. if문을 사용은 못하고 state에서 처리하기에는 property가 많아질거 같고 고민이구만
                    Text(state.evaluationPrev, style: GlobalTheme.leadCustomText)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  Widget _actGraph(ActDtlState state){
    final selectWeekOrMonth = TimeUtil().monthWeekByFirstMondayRuleToUi(state.selectedDate);
    return Container(
      width: 336.w,
      height: 324.h,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 28.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(state.isWeekly ? '주간' : '월간', style: HomeTheme.titleTextStyle),
                  SizedBox(
                    width: 210.w,
                    height: 28.h,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          width: 60.w,
                          height: 28.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: state.selectedOption == ActGraphSelection.COUNT ? Color(0xffEEF2FF)
                                : state.selectedOption == ActGraphSelection.CALORIE ? Color(0xffF3F4F6)
                                : state.selectedOption == ActGraphSelection.DISTANCE ? Color(0xffF3F4F6):
                            Color(0xffF3F4F6)
                          ),
                          child: Center(
                            child: Text('걸음수',
                              style: HomeTheme.leadingTextStyle.copyWith(
                                  color: state.selectedOption == ActGraphSelection.COUNT ? Color(0xff4f46e5)
                                      : state.selectedOption == ActGraphSelection.CALORIE ? Color(0xff4B5563)
                                      : state.selectedOption == ActGraphSelection.DISTANCE ? Color(0xff4B5563)
                                      : Color(0xff4B5563)
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 60.w,
                          height: 28.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: state.selectedOption == ActGraphSelection.COUNT ? Color(0xffF3F4F6)
                                  : state.selectedOption == ActGraphSelection.CALORIE ? Color(0xffEEF2FF)
                                  : state.selectedOption == ActGraphSelection.DISTANCE ? Color(0xffF3F4F6) :
                              Color(0xffF3F4F6)
                          ),
                          child: Center(
                            child: Text('칼로리',
                              style: HomeTheme.leadingTextStyle.copyWith(
                                  color: state.selectedOption == ActGraphSelection.COUNT ? Color(0xff4B5563)
                                      : state.selectedOption == ActGraphSelection.CALORIE ? Color(0xff4f46e5)
                                      : state.selectedOption == ActGraphSelection.DISTANCE ? Color(0xff4B5563)
                                      : Color(0xff4B5563)
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 60.w,
                          height: 28.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: state.selectedOption == ActGraphSelection.COUNT ? Color(0xffF3F4F6)
                                  : state.selectedOption == ActGraphSelection.CALORIE ? Color(0xffF3F4F6)
                                  : state.selectedOption == ActGraphSelection.DISTANCE ? Color(0xffEEF2FF)
                                  : Color(0xffF3F4F6)
                          ),
                          child: Center(
                            child: Text('거리',
                              style: HomeTheme.leadingTextStyle.copyWith(
                                  color: state.selectedOption == ActGraphSelection.COUNT ? Color(0xff4B5563)
                                      : state.selectedOption == ActGraphSelection.CALORIE ? Color(0xff4B5563)
                                      : state.selectedOption == ActGraphSelection.DISTANCE ? Color(0xff4f46e5)
                                      : Color(0xff4B5563)
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            SizedBox(
              height: 240.h,
              child: state.isWeekly ? ActWeeklyGraphView(weeklyData: state.actDatas.weeklyData[selectWeekOrMonth.week -1], option: state.selectedOption,)
                  : ActMontlyGraphView(montlyData: state.actDatas,option: state.selectedOption,),
            )

          ],
        ),
      ),
    );
  }


  Widget _gridSummaryInfo(ActDtlState state){
    final  weekOrMonth = TimeUtil().monthWeekByFirstMondayRuleToUi(state.selectedDate);

    Fourth<String, String, String, bool> totalStep = Fourth('', '', '', false);
    Fourth<String, String, String, bool> totalCnt = Fourth('', '', '', false);
    Fourth<String, String, String, bool> totalActiveDay = Fourth('', '', '', false);
    Fourth<String, String, String, bool> totalWriting = Fourth('', '', '', false);

    if(state.isWeekly){

      final weeklyData = state.actDatas.weeklyData[weekOrMonth.week -1];
      final prevWeeklyData = state.actDatas.weeklyData[weekOrMonth.week -2];
      int diffStepCnt = (weeklyData.weeklyAvgStepCnt - prevWeeklyData.weeklyAvgStepCnt);
      print(weeklyData.weeklyAvgStepCnt);
      print(prevWeeklyData.weeklyAvgStepCnt);
      final prevPercent = diffStepCnt == 0 ? 0 : (diffStepCnt ~/ (prevWeeklyData.weeklyAvgStepCnt == 0 ? 1 : prevWeeklyData.weeklyAvgStepCnt)).round();

      totalStep = Fourth('이번 주 총 걸음수', weeklyData.weeklyTotStepCnt.toString() , '평균 ${weeklyData.weeklyAvgStepCnt}보/일', false);
      totalCnt = Fourth('하루 평균 걸음수', weeklyData.weeklyAvgStepCnt.toString() , '${prevPercent}%', prevPercent < 0 ? false : true );
      totalActiveDay = Fourth('가장 활동적인 날', weeklyData.weeklyMostActDay == null ?'데이터없음':TimeUtil.yyyyMMddToMdForDate(weeklyData.weeklyMostActDay!) , '${weeklyData.actDailyData.firstWhere((e) => e.measrueDt == weeklyData.weeklyMostActDay).stepCnt}보', false);
      totalWriting = Fourth('연속 활동 기록', '${weeklyData.weeklyContinuousCnt.toString()}일 연속' , '7000보 이상', false);
    }else{
      final montlyData = state.actDatas;
      final prevMontlyData = state.actDatas;
      final prevPercent = (montlyData.montlyAvgStepCnt - prevMontlyData.montlyAvgStepCnt ~/ prevMontlyData.montlyAvgStepCnt).round();

      totalStep = Fourth('이번 달 총 걸음수', montlyData.montlyTotStepCnt.toString() , '평균 ${montlyData.montlyAvgStepCnt}보/일', false);
      totalCnt = Fourth('주간 평균 걸음수', montlyData.montlyAvgStepCnt.toString() , '${prevPercent}%', prevPercent < 0 ? false : true );
      totalActiveDay = Fourth('가장 활동적인 날', TimeUtil.yyyyMMddToMdString(montlyData.montlyMostActDay.toString()) , '${montlyData.weeklyData.firstWhere((e) => e.weeklyMostActDay == montlyData.montlyMostActDay).actDailyData.firstWhere((e) => e.measrueDt== montlyData.montlyMostActDay)}보', false);
      totalWriting = Fourth('연속 활동 기록', '${montlyData.montlyContinuousCnt.toString()}일 연속' , '7000보 이상', false);
    }

    return SizedBox(
      height: 224.h,
      width: 336.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            // crossAxisAlignment: .stretch,
            children: [
              _gridSummaryElement(totalStep.first, totalStep.second, totalStep.third, totalStep.fourth),
              _gridSummaryElement(totalCnt.first, totalCnt.second, totalCnt.third, totalCnt.fourth)
            ],
          ),
          Row(
            // crossAxisAlignment: .stretch,
            children: [
              _gridSummaryElement(totalActiveDay.first, totalActiveDay.second, totalActiveDay.third, totalActiveDay.fourth),
              _gridSummaryElement(totalWriting.first, totalWriting.second, totalWriting.third, totalWriting.fourth)
            ],
          )
        ],
      ),
    );
  }

  Widget _gridSummaryElement(String title , String summary , String leadingText, bool isAvg ){
    List<Widget> leadingArea = List.empty(growable: true);
    if(isAvg){
      leadingArea.add(SizedBox(
          height: 16.h,
          width: 7.5.w,
          child: Icon(Icons.arrow_upward_rounded,)
      ));
      leadingArea.add(Gap(4.h));
      leadingArea.add(
          Text(leadingText,
              style: HomeTheme.leadingTextStyle.copyWith(
                  color: Color(0xff22c55e)
              )
          )
      );
    }
    return Container(
      width: 161.5.w,
      height: 108.h,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),),
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          child: Column(
            mainAxisAlignment: .spaceBetween,
            crossAxisAlignment: .start,
            children: [
              Text(title),
              Text(summary, style: FeatureTheme.hrScoreText,),
              Row(
                children: [

                ]
              )
            ]
          ),
      ),
    );
  }



}