import 'package:bodymind/core/widget/cus_appbar.dart';
import 'package:bodymind/features/main_feature/health/detail/sleep/presentation/provider/sleep_dtl_provider.dart';
import 'package:bodymind/features/main_feature/health/detail/util/feature_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:path/path.dart';

import '../../../../../home/presentation/theme/home_theme.dart';
import '../viewmodel/sleep_dtl_viewmodel.dart';

class SleepDtlView extends ConsumerStatefulWidget{
  const SleepDtlView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => SleepDtlViewState();


}

class SleepDtlViewState extends ConsumerState<SleepDtlView>{
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(sleepDtlViewModelProvider);
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: '수면',
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: .center,
            children: [
              _dateSelector(state, ref, tapPrevious, tapForward),
              Gap(20.h),
              _summaryTile(state),
              Gap(20.h),
              _sleepGraphContainer(state),
              Gap(20.h),
              _stageSummaryContainer(state),
              Gap(20.h),
              _sleepAnalysisContainer(state)
            ],
          ),
        ),
      ),
    );
  }


  Widget _dateSelector(SleepDtlState state, WidgetRef ref, Function() tapPrevious, Function() tapForward){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      height: 73.h,
      width: 375.w,
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xffE5E7EB)))),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          InkWell(
            onTap: tapPrevious
            ,
            child: SizedBox(
              height: 40.h,
              width: 26.w,
              child: Icon(Icons.arrow_back_ios_new_rounded),
            ),
          ),

          RichText(
            text: TextSpan(
              children:[
                TextSpan(text:'${state.selectedDate?.year}년 ${state.selectedDate.month}월 ${state.selectedDate.day.toString().padLeft(2,'0')}',
                    style: FeatureTheme.hrMdText.copyWith(color: Colors.black)
                ),
                TextSpan(text:'${state.selectedDate.weekday}',
                    style: FeatureTheme.exExplainDetail.copyWith(color: Color(0xff6B7280))
                ),
              ],
            ),
          ),

          InkWell(
            onTap: tapForward
            ,
            child: SizedBox(
              height: 40.h,
              width: 26.w,
              child: Icon(Icons.arrow_forward_ios_rounded),
            ),
          )
        ],
      ),
    );
  }

  Widget _summaryTile(SleepDtlState state, ){
    return Container(
      width: 343.w,
      height: 196.h,
      child: Column(
        mainAxisAlignment: .spaceBetween,
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              _summaryContainer(state, typeColor, '총 수면 시간', bodyStr),
              _summaryContainer(state, typeColor, '갚은 수면 시간', bodyStr)
            ],
          ),
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              _summaryContainer(state, typeColor, '수면 점수', '${state.summary?.todayScore ?? 0} 점'),
              _summaryContainer(state, typeColor, '실제 수면 시간', '${state.summary.sleepRecognized}')
            ],
          )
        ],
      ),
    );
  }

  Widget _summaryContainer(SleepDtlState state, Color typeColor, String title, String bodyStr){
    return Container(
      height: 92.h,
      width: 166.w,
      padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 16.h),
      child: Column(
        mainAxisAlignment: .spaceBetween,
        children: [
          SizedBox(
            height: 20.h,
            width: 134.w,
            child: Row(
              children: [
                Container(
                  height: 12.h,
                  width: 12.w,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: typeColor),
                ),
                Gap(8.w),
                Text(title, style: FeatureTheme.exExplainDetail.copyWith(color: Color(0xff4B5563)),)
              ],
            ),
          ),
          Text(bodyStr, style: HomeTheme.featureScoreTextStyle,)
        ],
      ),
    );
  }

  Widget _sleepGraphContainer(SleepDtlState state){
    return Container(
      width: 343.w,
      height: 338.h,
      padding: EdgeInsets.symmetric(vertical: 17.h, horizontal: 17.h),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Column(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text('수면 타임라인', style: FeatureTheme.hrMdText.copyWith(color: Colors.black),),
          SizedBox(
            height: 260.h,
            width: 309.w,
            child: ,
          )
        ]
      ),
    );
  }

  Widget _stageSummaryContainer(SleepDtlState state){
    return Container(
      height: 222.h,
      width: 343.w,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white),
      padding: EdgeInsets.symmetric(vertical: 17.h, horizontal: 17.w),
      child: Column(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text('수면 단계', style: FeatureTheme.hrMdText.copyWith(color: Colors.black),),
          Container(
              height: 144.h,
              width: 309.w,
            child: Column(
              mainAxisAlignment: .spaceBetween,
              children: [
                _stageInfo(state, typeColor, title, timeStr),
                _stageInfo(state, typeColor, title, timeStr),
                _stageInfo(state, typeColor, title, timeStr),
                _stageInfo(state, typeColor, title, timeStr),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _stageInfo(SleepDtlState state, Color typeColor, String title, String timeStr){
    return Container(
      width: 309.w,
      height: 24.h,
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Container(
            height: 24.h,
            width: 100.w,
            child: Row(
              children: [
                Container(
                  width: 16.w,
                  height: 16.h,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: typeColor),
                ),
                Gap(12.w),
                Text(title, style: HomeTheme.titleTextStyle.copyWith(color: Color(0xff374151)),)
              ],
            ),
          ),
          Text(timeStr, style: HomeTheme.titleTextStyle.copyWith(color: Colors.black, fontWeight: FontWeight.w600),)
        ],
      ),
    );
  }

  Widget _sleepAnalysisContainer(SleepDtlState state){
    return Container(
      width: 343.w,
      height: 266.h,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white),
      padding: EdgeInsets.symmetric(vertical: 17.h, horizontal: 17.w),
      child: Column(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text('수면 분석', style: FeatureTheme.hrMdText.copyWith(color: Colors.black),),
          Container(
            height: 188.h,
            width: 309.w,
            child: Column(
              mainAxisAlignment: .spaceBetween,
              children: [
                _sleepAnalysisItem(iconPath, body, backgroundColor),
                _sleepAnalysisItem(iconPath, body, backgroundColor),
                _sleepAnalysisItem(iconPath, body, backgroundColor),
              ],
            ),
          )
        ]

      ),
    );
  }

  Widget _sleepAnalysisItem(String iconPath, String body, Color backgroundColor){
    return Container(
      height: 50.h,
      width: 309.w,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: backgroundColor),
      child: Row(
        crossAxisAlignment: .center,
        children: [
          SvgPicture.asset(iconPath),
          Text(body, style: FeatureTheme.exExplainText.copyWith(color: Color(0xff374151)),)
        ],
      ),
    );
  }
}