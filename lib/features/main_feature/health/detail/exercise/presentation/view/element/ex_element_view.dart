import 'package:bodymind/core/util/bodymind_core_util.dart';
import 'package:bodymind/core/widget/cus_appbar.dart';
import 'package:bodymind/features/main_feature/health/detail/exercise/presentation/view/templete/ex_element_graph.dart';
import 'package:bodymind/features/main_feature/health/detail/util/feature_theme.dart';
import 'package:bodymind/features/main_feature/health/detail/util/feature_util.dart';
import 'package:bodymind/features/main_feature/home/presentation/theme/home_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../domain/entity/ex_element_dto.dart';

class ExElementView extends StatefulWidget{
  final DateTime dateTime;
  final ExElementDto state;

  ExElementView(this.dateTime, this.state);

  @override
  State<StatefulWidget> createState() => ExElementViewState();

}

class ExElementViewState extends State<ExElementView>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '오늘의 ${widget.state.exName}',
      ),
      body: Container(
        color: Color(0xffF9FAFB),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                _elementSummaryArea(widget.state),
                Gap(20.h),
                _graphArea(widget.state),
                Gap(20.h),
                _distanceInfo(widget.state),
                Gap(20.h),
                _countInfo(widget.state),
                Gap(20.h),
                _calorieInfo(widget.state),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _elementSummaryArea(ExElementDto state){
    final endTm = state.strtDt.add(Duration(minutes: state.duration));
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white),
      padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 25.w),
      width: 343.w,
      height: 280.h,
      child: Column(
        mainAxisAlignment: .spaceBetween,
        children: [
            SizedBox(
              height: 52.h,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  RichText(text: TextSpan(
                    children: [
                      TextSpan(
                        text: '오늘의 ${widget.state.exName}',
                        style: HomeTheme.evaluationTextStyle.copyWith(color: Colors.black)
                      ),
                      TextSpan(
                          text: '\n${TimeUtil.yyyyMMddToDtMdString(state.strtDt)} · ${state.strtDt.hour}:${state.strtDt.minute}~${endTm.hour}:${endTm.minute}',
                          style: FeatureTheme.exExplainText.copyWith(color: Color(0xff6B7280))
                      )
                    ]
                  )),

                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Color(0xffDBEAFE)),
                    width: 48.w,
                    height: 48.h,
                    child: SvgPicture.asset('assets/images/icon/runner.svg',colorFilter: ColorFilter.mode(Color(0xff2563eb), BlendMode.srcIn),),//parameter,
                  )
                ],
              ),
            ),

          SizedBox(
            height: 160.h,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: .spaceBetween,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 76.h,
                  child: Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      _characteristicsContainer(76.h, 138.5.w, Color(0xffF9FAFB), Color(0xff111827), '운동 시간', '${state.duration}분'),
                      _characteristicsContainer(76.h, 138.5.w, Color(0xffF9FAFB), Color(0xff3B82F6), '칼로리', '${state.activeCalorie.round()}')
                    ],
                  ),
                ),

                SizedBox(
                  width: double.infinity,
                  height: 76.h,
                  child: Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      _characteristicsContainer(72.h, 138.5.w, Color(0xffF9FAFB), Color(0xff111827), '평균 심박', '${state.hrLst.featureAvg().round()}'),
                      _characteristicsContainer(72.h, 138.5.w, Color(0xffF9FAFB), Color(0xffEF4444), '최고 심박', '${state.maxHr}')
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }


  Widget _graphArea(ExElementDto state){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white),
      width: 343.w,
      height: 294.h,
      child: Column(
        children: [
          SizedBox(width:293.w, height:28.h, child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text('심박수', style: FeatureTheme.hrMdText.copyWith(color: Colors.black),),
              Text('평균 ${state.hrLst.featureAvg().round()} bpm · 최고 ${state.maxHr} bpm', style: FeatureTheme.exSummaryText.copyWith(color: Color(0xff6B7280) ),)
            ]
          ),),
          Gap(16.h),
          Expanded(child: ExElementGraph(hrBySec: state.hrLst, hrInterval: state.hrInterval, startTm: state.strtDt)),
        ],
      ),
    );
  }

  Widget _distanceInfo(ExElementDto state){
    final distanceCharacteristics = [
      _characteristicsContainer(88.h, 293.w, Color(0xffEFF6FF), Color(0xff2563EB), '총 거리(km)', '${state.distance}')
    ];
    return SizedBox(
        width: 343.w,
        height: 190.h,
        child: _infosMaker('거리', SvgPicture.asset('assets/images/icon/road.svg'), distanceCharacteristics ));
  }

  Widget _countInfo(ExElementDto state){
    final countCharacteristics = [
      _characteristicsContainer(88.h, 293.w, Color(0xffFAF5FF), Color(0xff9333EA), '걸음', '${state.count}')
    ];
    return SizedBox(
        width: 343.w,
        height: 190.h,
        child: _infosMaker('보행수', SvgPicture.asset('assets/images/icon/step.svg'), countCharacteristics ));
  }

  Widget _calorieInfo(ExElementDto state){
    final calorieCharacteristics = [
      _characteristicsContainer(88.h, 138.5.w, Color(0xffFFF7ED), Color(0xffEA580C), '총 칼로리', state.activeCalorie.toStringAsFixed(1)),
      _characteristicsContainer(88.h, 138.5.w, Color(0xffFEF2F2), Color(0xffDC2626), '분당 칼로리', (state.activeCalorie / state.duration).toStringAsFixed(1))
    ];
    return SizedBox(
        width: 343.w,
        height: 190.h,
        child: _infosMaker('거리', SvgPicture.asset('assets/images/icon/calorie.svg'), calorieCharacteristics ));
  }

  Widget _infosMaker(String title, SvgPicture svgIcon, List<Widget> children ){
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white),
      height: 182.h,
      padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 25.w),
      child: Column(
        mainAxisAlignment: .spaceBetween,
        children: [
          SizedBox(
            height: 28.h,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(title, style: FeatureTheme.hrMdText,),
                SizedBox(
                  height: 24.h,
                  width: 14.w,
                  child: svgIcon,
                )
              ],
            ),
          ),

          SizedBox(
            height: 88.h,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: children,
            ),
          )
        ],
      ),
    );
  }

  Widget _characteristicsContainer(
      double height,
      double width,
      Color? backgroundColor,
      Color? textColor,
      String explainText,
      String valueText
      ){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 13.h),
      width: width,
      height: height,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: backgroundColor),
      child: Center(
        child: Column(
          mainAxisAlignment: .spaceBetween,
          children: [
            Text(valueText, style: HomeTheme.featureScoreTextStyle.copyWith(color: textColor),), 
            Text(explainText, style: HomeTheme.infoTextStyle.copyWith(color: Color(0xff6B7280)), ) 
          ],
        ),
      ),
    );
  }
}