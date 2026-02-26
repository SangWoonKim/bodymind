import 'package:bodymind/const/theme/global_theme.dart';
import 'package:bodymind/core/widget/cus_appbar.dart';
import 'package:bodymind/features/main_feature/health/detail/activity/presentation/view/enum/act_graph_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../../../../core/util/bodymind_core_util.dart';
import '../../../../../home/presentation/theme/home_theme.dart';
import '../../../util/feature_theme.dart';
import '../viewmodel/heatlh_act_view_model.dart';

class HealthDtlActView extends ConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      //actions에 달력 아이콘을 넣어서 주간 월간 선택 달력을 띄워야함
      appBar: CustomAppBar(
        title: '활동 상세',
      ),
      body:  Center(
        child: Column(

        ),
      )
      ,
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
    return Container(
      width: 336.w,
      height: 324.h,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('주간 / 월간 활동량'),
            SizedBox(
              width: 140.w,
              height: 28.h,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: state.selectedOption == ActGraphSelection.COUNT ? Color(0xffEEF2FF)
                          : state.selectedOption == ActGraphSelection.CALORIE ? Color(0xffEEF2FF)
                          : state.selectedOption == ActGraphSelection.DISTANCE ? Color(0xffEEF2FF) :
                      Color(0xffF3F4F6)
                    ),
                    child: Center(
                      child: Text('걸음수',
                        style: HomeTheme.leadingTextStyle.copyWith(
                            color: state.selectedOption == ActGraphSelection.COUNT ? Color(0xff4f46e5)
                                : state.selectedOption == ActGraphSelection.CALORIE ? Color(0xff4f46e5)
                                : state.selectedOption == ActGraphSelection.DISTANCE ? Color(0xff4f46e5)
                                : Color(0xff4B5563)
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: state.selectedOption == ActGraphSelection.COUNT ? Color(0xffEEF2FF)
                            : state.selectedOption == ActGraphSelection.CALORIE ? Color(0xffEEF2FF)
                            : state.selectedOption == ActGraphSelection.DISTANCE ? Color(0xffEEF2FF)
                            : Color(0xffF3F4F6)
                    ),
                    child: Center(
                      child: Text('활동시간',
                        style: HomeTheme.leadingTextStyle.copyWith(
                            color: state.selectedOption == ActGraphSelection.COUNT ? Color(0xff4f46e5)
                                : state.selectedOption == ActGraphSelection.CALORIE ? Color(0xff4f46e5)
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
    );
  }




}