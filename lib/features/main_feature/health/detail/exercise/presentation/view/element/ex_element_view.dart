import 'dart:js_interop';

import 'package:bodymind/const/theme/global_theme.dart';
import 'package:bodymind/core/widget/cus_appbar.dart';
import 'package:bodymind/features/main_feature/health/detail/util/feature_theme.dart';
import 'package:bodymind/features/main_feature/home/presentation/theme/home_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ExElementView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => ExElementViewState();

}

class ExElementViewState extends State<ExElementView>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '오늘의 러닝',
      ),
      body:,
    );
  }

  Widget _elementSummaryArea(ExElementState state){
    return Container(
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
                        text: '오늘의 러닝',
                        style: HomeTheme.evaluationTextStyle
                      ),
                      TextSpan(
                          text: '3월 9일 · 19:10~19:42',
                          style: FeatureTheme.exExplainText
                      )
                    ]
                  )),

                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    width: 48.w,
                    height: 48.h,
                    child: SvgPicture.asset('assets/images/icon/ex/runner.svg',colorFilter: ColorFilter.mode(Color(0xff2563eb), BlendMode.srcIn),),//parameter,
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
                      _characteristicsContainer(76.h, 138.5.w, Color(0xffF9FAFB), Color(0xff111827), '운동 시간', '32분'),
                      _characteristicsContainer(76.h, 138.5.w, Color(0xffF9FAFB), Color(0xff3B82F6), '칼로리', '240')
                    ],
                  ),
                ),

                SizedBox(
                  width: double.infinity,
                  height: 76.h,
                  child: Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      _characteristicsContainer(72.h, 138.5.w, Color(0xffF9FAFB), Color(0xff111827), '평균 심박', '142'),
                      _characteristicsContainer(72.h, 138.5.w, Color(0xffF9FAFB), Color(0xff3B82F6), '최고 심박', '168')
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


  Widget _graphArea(){
    return Container(
      width: 343.w,
      height: 294.h,
      child: ,
    );
  }

  Widget _distanceInfo(){
    final distanceCharacteristics = [
      _characteristicsContainer(88.h, double.infinity, Color(0xffEFF6FF), Color(0xff2563EB), '총 거리(km)', '3.4')
    ];
    return _infosMaker('거리', SvgPicture.asset('road.svg'), distanceCharacteristics );
  }

  Widget _countInfo(){
    final countCharacteristics = [
      _characteristicsContainer(88.h, double.infinity, Color(0xffFAF5FF), Color(0xff9333EA), '걸음', '4820')
    ];
    return _infosMaker('보행수', SvgPicture.asset('step.svg'), countCharacteristics );
  }

  Widget _calorieInfo(){
    final calorieCharacteristics = [
      _characteristicsContainer(88.h, 138.5.w, Color(0xffFFF7ED), Color(0xffEA580C), '총 칼로리', '240'),
      _characteristicsContainer(88.h, 138.5.w, Color(0xffFEF2F2), Color(0xffDC2626), '분당 칼로리', '7.5')
    ];
    return _infosMaker('거리', SvgPicture.asset('road.svg'), calorieCharacteristics );
  }

  Widget _infosMaker(String title, SvgPicture svgIcon, List<Widget> children ){
    return Container(
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
                Container(
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