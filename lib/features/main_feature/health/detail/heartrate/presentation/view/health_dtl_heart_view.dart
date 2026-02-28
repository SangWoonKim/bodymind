import 'package:bodymind/const/theme/global_theme.dart';
import 'package:bodymind/core/util/bodymind_core_util.dart';
import 'package:bodymind/core/widget/cus_appbar.dart';
import 'package:bodymind/features/main_feature/health/detail/heartrate/presentation/enum/health_dtl_heart_summary.dart';
import 'package:bodymind/features/main_feature/health/detail/heartrate/presentation/view/templete/heart_dtl_graph.dart';
import 'package:bodymind/features/main_feature/health/detail/heartrate/presentation/view/templete/heart_dtl_templete.dart';
import 'package:bodymind/features/main_feature/health/detail/heartrate/provider/heart_dtl_provider.dart';
import 'package:bodymind/features/main_feature/home/presentation/theme/home_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../util/feature_theme.dart';
import '../viewmodel/heart_dtl_view_model.dart';

class HealthDtlHeartView extends ConsumerStatefulWidget {
  final String? receivedYmd;

  const HealthDtlHeartView({super.key, this.receivedYmd});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HealthDtlHeartViewState();
}

class _HealthDtlHeartViewState extends ConsumerState<HealthDtlHeartView> {
  static const int _initialPage = 10000;
  final DateTime today = DateTime.now();

  //viewModel에 역할 넘겼다가 di에 대한 타이밍 때문인지 로그에 에러가 쌓인다... view로 빼자...
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
    final heartDtlState = ref.watch(hrDtlViewModelProvider);

    return Scaffold(
      appBar: CustomAppBar(backgroundColor: Colors.white, title: '심박 상세'),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xffeef2ff), Color(0xfffaf5ff), Color(0xfffdf2f8)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            dateSelector(heartDtlState, ref, _movePrevDay, _moveNextDay),
            Gap(20.h),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (page) {
                  final diff = page - _initialPage;
                  if (diff == 0) return;

                  final step = diff > 0 ? 1 : -1;
                  ref.read(hrDtlViewModelProvider.notifier).loadHrData(step);

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) _pageController.jumpToPage(_initialPage);
                  });
                },

                itemBuilder: (context, index) {
                  return _infoSection(heartDtlState);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dateSelector(
    HeartDtlState state,
    WidgetRef ref,
    Function() tapPrevious,
    Function() tapForward,
  ) {
    final mdStr = TimeUtil.yyyyMMddToMdString(state.yyyyMMdd);
    final eStr = TimeUtil.yyyyMMddToEString(state.yyyyMMdd);
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
                    Text(mdStr, style: FeatureTheme.hrMdText),
                    Text(eStr, style: HomeTheme.infoTextStyle),
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

  Widget summarizedRow(HeartDtlState state) {
    return SizedBox(
      height: 106.h,
      width: 335.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _summerySections(HealthDtlHeartSummary.avg, state.avgHr),
          _summerySections(HealthDtlHeartSummary.high, state.maxHr),
          _summerySections(HealthDtlHeartSummary.low, state.minHr),
        ],
      ),
    );
  }

  Widget stableSectionGraph(HeartDtlState state) {
    final percentage = state.stablePercent;
    return Container(
      height: 108.h,
      width: 335.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
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
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Color(0xffF3E8FF),
                      ),
                      child: SvgPicture.asset(
                        'assets/images/icon/graph.svg',
                        fit: BoxFit.none,
                      ),
                    ),
                    SizedBox(
                      width: 60.w,
                      height: 36.h,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '안정구간',
                              style: GlobalTheme.leadCustomText.copyWith(
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: '\n60-80 bpm',
                              style: HomeTheme.infoTextStyle.copyWith(
                                color: Color(0xff6B7280),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // 안정구간 퍼센테이지
              SizedBox(
                height: 48.h,
                width: 52.w,
                child: RichText(
                  textAlign: TextAlign.end,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '$percentage%',
                        style: HomeTheme.featureScoreTextStyle.copyWith(
                          color: Color(0xff9333EA),
                        ),
                      ),
                      TextSpan(
                        text: '\n하루 중',
                        style: HomeTheme.infoTextStyle.copyWith(
                          color: Color(0xff6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          //안정구간 percentage graph
          HeartProgressBar(targetValue: percentage / 100),
        ],
      ),
    );
  }

  Widget dailyHrGraph(HeartDtlState state) {
    return Container(
      height: 360.h,
      width: 335.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
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
                Text(
                  '일간 삼박 흐름',
                  style: HomeTheme.titleTextStyle.copyWith(
                    color: Color(0xff1F2937),
                  ),
                ),
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
                          children: [
                            Container(
                              height: 8.h,
                              width: 8.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Color(0xff6366F1),
                              ),
                            ),
                            Gap(4.w),
                            Text('심박', style: HomeTheme.infoTextStyle),
                          ],
                        ),
                      ),

                      SizedBox(
                        width: 35.w,
                        height: 16.h,
                        child: Row(
                          children: [
                            Container(
                              height: 8.h,
                              width: 8.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Color(0xff9CA3AF),
                              ),
                            ),
                            Gap(4.w),
                            Text('평균', style: HomeTheme.infoTextStyle),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Gap(16.h),
          SizedBox(
            height: 280.h,
            width: double.infinity,
            child: HeartDtlGraph(
              hrByMinute: state.hrLst,
              hideFuture: state.yyyyMMdd == today.year + today.month + today.day
                  ? true
                  : false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _summerySections(HealthDtlHeartSummary hrEnum, int bpm) {
    return Container(
      width: 106.3.w,
      height: 106.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 40.w, 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 16.w,
                height: 16.h,
                child: SvgPicture.asset(hrEnum.assetPath, fit: BoxFit.none),
              ),
              Gap(6.w),
              Text(hrEnum.name, style: HomeTheme.infoTextStyle),
            ],
          ),
          Text(bpm.toString(), style: FeatureTheme.hrScoreText),
          Text(
            'bpm',
            style: HomeTheme.leadingTextStyle.copyWith(
              color: Color(0xff9CA3AF),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoSection(HeartDtlState state) {
    return SingleChildScrollView(
      child: Column(
        children: [
          summarizedRow(state),
          Gap(20.h),
          stableSectionGraph(state),
          Gap(20.h),
          dailyHrGraph(state),
          Gap(20.h),
        ],
      ),
    );
  }
}
