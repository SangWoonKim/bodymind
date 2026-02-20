import 'package:bodymind/const/theme/global_theme.dart';
import 'package:bodymind/features/main_feature/home/presentation/templete/home_feature_info_widget.dart';
import 'package:bodymind/features/main_feature/home/presentation/templete/home_progress_indicator.dart';
import 'package:bodymind/features/main_feature/home/presentation/theme/home_theme.dart';
import 'package:bodymind/features/main_feature/home/presentation/view/enum/feature_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../../../core/util/bodymind_core_util.dart';
import '../provider/home_provider.dart';
import '../viewmodel/home_viewmodel.dart';

class HomeView extends ConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModelProvider);

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromRGBO(249, 250, 251, 1), Colors.white],
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Gap(48.h),
                    titleArea(state),
                    Gap(20.h),
                    summeryArea(state),
                    Gap(20.h),
                    featureArea(state),
                    Gap(20.h),
                    suggestArea(),
                    Gap(20.h),
                    otherArea()
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget titleArea(HomeViewState state){
    return SizedBox(
      height: 52.h,
      width: 335.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //날짜 및 분석 결과
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                TimeUtil.commonKoreanDate(DateTime.now()),
                style: GlobalTheme.leadCustomText.copyWith(color: Color(0xff6b7280)),),
              Text(
                state.evaluationStr,
                style: HomeTheme.evaluationTextStyle.copyWith(color: Color(0xff1e293b)),
              )
            ]
          ),
          //아이콘
          Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.white,
              border: Border.all(color: Color(0xffe5e7eb))
            ),
            child: SvgPicture.asset('assets/images/icon/setting.svg', fit: BoxFit.none,),
          )
        ],
      ),
    );
  }


  Widget summeryArea(HomeViewState state){
    return Container(
      height: 300.h,
      width: 335.w,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Color.fromRGBO(229, 231, 235, 1),),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.10),
              offset: Offset(0, 4),
              blurRadius: 6,
              spreadRadius: 0
            ),
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.10),
                offset: Offset(0, 10),
                blurRadius: 15,
                spreadRadius: 0
            )
          ]
        ),
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 24.h,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('오늘의 종합 점수',
                          style: HomeTheme.titleTextStyle.copyWith(color: Color(0xff1e293b)),),
                        Text('점수 기준',
                          style: HomeTheme.leadingTextStyle.copyWith(color: Color(0xff4f46e5)),)
                      ],
                    ),
                  ),

              Center(
                child: SizedBox(
                    height: 140.h, width: 140.w,
                    child: HomeProgressIndicator(
                      evaluation: Text(
                        state.evaluationStr,
                        style: HomeTheme.titleTextStyle,
                      ),
                      progressStyle: HomeTheme.mainScoreTextStyle,
                      progress: 0.2,
                    )
                )
              ),
              Container(
                height: 54.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Color(0xfff3f4f6),
                            width: 1,
                          ),
                        )
                    ),
                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: 36.h,
                            width: 45.w,
                            child: Column(
                                children: [
                                  Text('어제보다', style: HomeTheme.infoTextStyle,),
                                  Text('3', style: GlobalTheme.leadCustomText)
                                ]
                            )
                        ),
                        VerticalDivider(color: Color(0xfff3f4f6), thickness: 1.w,),
                        SizedBox(
                          height: 36.h,
                          width: 45.w,
                          child:Column(
                              children: [
                                Text('주간평균', style: HomeTheme.infoTextStyle,),
                                Text('74', style: GlobalTheme.leadCustomText,)
                              ]
                          ),
                        )
                      ],
                    ),
                  )


            ],
          ),
        ),
      ),
    );
  }


  Widget featureArea(HomeViewState state){
    return SizedBox(
      width: 335.w,
      height: 316.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 152.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HomeFeatureInfoWidget(
                    content: FeatureContent.act,
                    featureScore: state.featureInfo['act']!.score,
                    evaluationSummery: state.featureInfo['act']!.featureEvaluationStr,
                    onRoute: state.featureInfo['act']!.route),
                HomeFeatureInfoWidget(
                    content: FeatureContent.heart,
                    featureScore: state.featureInfo['heart']!.score,
                    evaluationSummery: state.featureInfo['heart']!.featureEvaluationStr,
                    onRoute: state.featureInfo['heart']!.route),
              ],
            ),
          ),
          SizedBox(
            height: 152.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HomeFeatureInfoWidget(
                    content: FeatureContent.sleep,
                    featureScore: state.featureInfo['sleep']!.score,
                    evaluationSummery: state.featureInfo['sleep']!.featureEvaluationStr,
                    onRoute: state.featureInfo['sleep']!.route),
                HomeFeatureInfoWidget(
                    content: FeatureContent.exercise,
                    featureScore: state.featureInfo['exercise']!.score,
                    evaluationSummery: state.featureInfo['exercise']!.featureEvaluationStr,
                    onRoute: state.featureInfo['exercise']!.route),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget suggestArea(){
    return Container(
      height: 146.h,
      width: 335.w,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffe5e6eb)),
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
            colors: [
              Color(0xff6366F1),
              Color(0xff9333ea)
            ]
        )
      ),
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
      child: SizedBox(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                color: Color(0xffFFFFFF).withValues(alpha: 0.20),
                // border: Border.all(color: Color(0xffE5E7EB))
              ),
              child: SvgPicture.asset('assets/images/icon/tip.svg', fit: BoxFit.none,),
            ),
            Gap(12.w),
            SizedBox(
              height: 105.h,
              width: 240.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("오늘의 제안", style: GlobalTheme.leadCustomText.copyWith(color: Colors.white)),
                  Text("오늘은 산책 15분만 더해도 점수가 좋아져요", style: GlobalTheme.leadCustomText2.copyWith(color: Colors.white)),
                  Gap(33.h),
                  Text("분석에서 더 보기 ->", style: HomeTheme.suggestTextStyle.copyWith(color: Colors.white)),
                ],
              ),
            )
          ],
        )
      ),
    );
  }

  Widget otherArea(){
    return SizedBox(
      height: 76.h,
      width: 335.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 162.w,
            height: 76.h,
            padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 18.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xffE0E7FF))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 40.h,
                  width: 40.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffe5e7eb)),
                    borderRadius: BorderRadius.circular(100),
                    color: Color(0xffeef2ff)
                  ),
                  child: SvgPicture.asset(
                    'assets/images/icon/tip.svg',
                    fit: BoxFit.none,
                  colorFilter: ColorFilter.mode(Color(0xff4f46e5), BlendMode.srcIn),),
                ),
                Text('내 흐름 분석', style: GlobalTheme.leadCustomText,)
              ],
            ),
          ),

          Container(
            width: 162.w,
            height: 76.h,
            padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 18.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xffE0E7FF))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 40.h,
                  width: 40.h,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffe5e7eb)),
                      borderRadius: BorderRadius.circular(100),
                      color: Color(0xffFAF5FF)
                  ),
                  child: SvgPicture.asset(
                    'assets/images/icon/chat.svg',
                    fit: BoxFit.none,
                    colorFilter: ColorFilter.mode(Color(0xff9333ea), BlendMode.srcIn),
                  ),
                ),
                Text('응원 채팅', style: GlobalTheme.leadCustomText,)
              ],
            ),
          )
        ],
      ),
    );
  }

}