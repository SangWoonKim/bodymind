import 'package:bodymind/const/theme/global_theme.dart';
import 'package:bodymind/core/util/bodymind_core_util.dart';
import 'package:bodymind/features/main_feature/health/detail/heartrate/presentation/enum/health_dtl_heart_summary.dart';
import 'package:bodymind/features/main_feature/health/detail/heartrate/presentation/view/templete/heart_dtl_graph.dart';
import 'package:bodymind/features/main_feature/health/detail/heartrate/presentation/view/templete/heart_dtl_templete.dart';
import 'package:bodymind/features/main_feature/health/detail/heartrate/provider/heart_dtl_provider.dart';
import 'package:bodymind/features/main_feature/health/detail/heartrate/viewmodel/heart_dtl_view_model.dart';
import 'package:bodymind/features/main_feature/home/presentation/theme/home_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../util/feature_theme.dart';

class HealthDtlHeartView extends ConsumerWidget{
  final String? receivedYmd;

  const HealthDtlHeartView({super.key, this.receivedYmd});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final heartDtlState = ref.watch(hrDtlViewModelProvider);

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xffeef2ff),
              Color(0xfffaf5ff),
              Color(0xfffdf2f8)
            ],
          ),
        ),
        child: LayoutBuilder(
            builder: (context, constraints){
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      dateSelector(heartDtlState),
                      Gap(20.h),
                      summarizedRow(heartDtlState),
                      Gap(20.h),
                      stableSectionGraph(heartDtlState),
                      Gap(20.h),
                      dailyHrGraph(heartDtlState)
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }


  Widget dateSelector(HeartDtlState state){
    final mdStr = TimeUtil.yyyyMMddToMdString(state.yyyyMMdd);
    final eStr = TimeUtil.yyyyMMddToEString(state.yyyyMMdd);
    return Container(
      width: 335.w,
      height: 78.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12)
      ),
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('<'),
            Column(
              children: [
                Text(mdStr, style: FeatureTheme.hrMdText,),
                Text(eStr, style: HomeTheme.infoTextStyle,)
              ]
            ),
            Text('>')
          ],
        ),
      ),
    );
  }

  Widget summarizedRow(HeartDtlState state){
    return SizedBox(
      height: 106.h,
      width: 335.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _summerySections(HealthDtlHeartSummary.avg, state.avgHr),
          _summerySections(HealthDtlHeartSummary.high, state.maxHr),
          _summerySections(HealthDtlHeartSummary.low, state.minHr)
        ],
      ),
    );
  }

  Widget stableSectionGraph(HeartDtlState state){
    final percentage = state.stablePercent;
    return Container(
      height: 108.h,
      width: 335.w,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white),
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //안정구간 영역
              SizedBox(
                height: 40.h,
                width: 108.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 40.w, 
                      height: 40.h,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Color(0xffF3E8FF)),
                      child: SvgPicture.asset('assets/images/icon/graph.svg', fit: BoxFit.none,),
                    ),
                    SizedBox(
                      width: 60.w,
                      height: 36.h,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(text: '안정구간', style: GlobalTheme.leadCustomText ),
                            TextSpan(text: '\n60-80 bpm', style: HomeTheme.infoTextStyle,)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // 안정구간 퍼센테이지
              SizedBox(
                height: 48.h,
                width: 52.w,
                child:RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: '$percentage%', style: HomeTheme.featureScoreTextStyle ),
                      TextSpan(text: '하루 중', style: HomeTheme.infoTextStyle,)
                    ],
                  ),
                ),
              )
            ],
          ),

          //안정구간 percentage graph
          HeartProgressBar(targetValue: percentage / 100),
        ],
      ),
    );
  }


  Widget dailyHrGraph(HeartDtlState state){
    return Container(
      height: 360.h,
      width: 335.w,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 24.h,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('일별 삼박 흐름'),
                SizedBox(
                  height: 16.h,
                  width: 78.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 35.w,
                        height: 16.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                color: Color(0xff6366F1)
                              ),
                            ),
                            Text('심박', style: HomeTheme.infoTextStyle,)
                          ],
                        ),
                      ),

                      SizedBox(
                        width: 35.w,
                        height: 16.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Color(0xff9CA3AF)
                              ),
                            ),
                            Text('평균', style: HomeTheme.infoTextStyle,)
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          SizedBox(
            height: 280.h,
            width: double.infinity,
            child: HeartDtlGraph(hrByMinute: state.hrLst),
          )
        ],
      ),
    );
  }


  Widget _summerySections(HealthDtlHeartSummary hrEnum, int bpm){
    return Container(
      width: 106.3.w,
      height: 106.h,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12)
      ),
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 40.w, 16.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 16.w,
                height: 16.h,
                child: SvgPicture.asset(
                  hrEnum.assetPath,
                  fit: BoxFit.none,
                ),
              ),
              Text(hrEnum.name, style: HomeTheme.infoTextStyle,),
            ],
          ),
          Text(bpm.toString(), style: FeatureTheme.hrScoreText,),
          Text('bpm',style: HomeTheme.leadingTextStyle,)
        ],
      ),
    );
  }
}