import 'package:bodymind/core/util/bodymind_core_util.dart';
import 'package:bodymind/core/widget/cus_appbar.dart';
import 'package:bodymind/features/main_feature/health/detail/sleep/domain/entity/sleep_summary.dart';
import 'package:bodymind/features/main_feature/health/detail/sleep/presentation/provider/sleep_dtl_provider.dart';
import 'package:bodymind/features/main_feature/health/detail/sleep/presentation/view/templete/sleep_stage_graph.dart';
import 'package:bodymind/features/main_feature/health/detail/util/feature_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:path/path.dart';

import '../../../../../../common_util/action_calendar.dart';
import '../../../../../home/presentation/theme/home_theme.dart';
import '../../domain/entity/sleep_analysis.dart';
import '../viewmodel/sleep_dtl_viewmodel.dart';

class HealthDtlSleepView extends ConsumerStatefulWidget {
  const HealthDtlSleepView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      HealthDtlSleepViewState();
}

class HealthDtlSleepViewState extends ConsumerState<HealthDtlSleepView> {
  int _initialPage = 10000;
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

  void _tapPrevious() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  void _tapForward() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(sleepDtlViewModelProvider);
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: '수면',
          actions: [
            InkWell(
              child: Icon(Icons.calendar_month),
              onTap: () {
                final selectedDate = state.selectedDate;
                ActionCalendar().openActionCalendar(
                  context: context,
                  initialDate: selectedDate,
                  onSelected: (date) {
                    bool isMoveMonth = date.month != state.selectedDate.month;
                    bool isMoveYear = date.year != state.selectedDate.year;
                    ref
                        .read(sleepDtlViewModelProvider.notifier)
                        .selectedDate(
                          isMoveMonth: isMoveMonth || isMoveYear,
                          selectedDate: date,
                        );
                  },
                );
              },
            ),
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Color(0xfff9fafb),
          child: Column(
            crossAxisAlignment: .center,
            children: [
              _dateSelector(state, ref, _tapPrevious, _tapForward),
              Gap(20.h),
              Expanded(
                child: PageView.builder(
                  itemBuilder: (ctx, idx) {
                    return SingleChildScrollView(child: _infoContainer(state));
                  },
                  controller: _pageController,
                  onPageChanged: (page) {
                    int diff = (page - _initialPage).sign;

                    if (diff == 0) return;

                    _initialPage = page;

                    final viewModel = ref.read(
                      sleepDtlViewModelProvider.notifier,
                    );

                    final moveDay = state.selectedDate.add(
                      Duration(days: diff),
                    );

                    if (state.selectedDate.month != moveDay.month) {
                      viewModel.selectedDate(
                        isMoveMonth: true,
                        selectedDate: moveDay,
                      );
                    } else {
                      viewModel.selectedDate(
                        isMoveMonth: false,
                        selectedDate: moveDay,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoContainer(SleepDtlState state) {
    return Column(
      children: [
        _summaryTile(state.summary),
        Gap(20.h),
        // Container( width: 343.w,
        //   height: 338.h,),
        _sleepGraphContainer(state),
        Gap(20.h),
        _stageSummaryContainer(state.summary),
        Gap(20.h),
        _sleepAnalysisContainer(state.analysis),
      ],
    );
  }

  Widget _dateSelector(
    SleepDtlState state,
    WidgetRef ref,
    Function() tapPrevious,
    Function() tapForward,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      height: 73.h,
      width: 375.w,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xffE5E7EB))),
      ),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          InkWell(
            onTap: tapPrevious,
            child: SizedBox(
              height: 40.h,
              width: 26.w,
              child: Icon(Icons.arrow_back_ios_new_rounded),
            ),
          ),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          '${state.selectedDate.year}년 ${state.selectedDate.month}월 ${state.selectedDate.day.toString().padLeft(2, '0')}일',
                      style: FeatureTheme.hrMdText.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text:
                          '\n${TimeUtil.weekDayToString(state.selectedDate.weekday)}',
                      style: FeatureTheme.exExplainDetail.copyWith(
                        color: Color(0xff6B7280),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          InkWell(
            onTap: tapForward,
            child: SizedBox(
              height: 40.h,
              width: 26.w,
              child: Icon(Icons.arrow_forward_ios_rounded),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryTile(SleepSummary? summary) {
    final totalDuration = summary?.totalDuration == null
        ? '0분'
        : TimeUtil.durationToTmStr(summary!.totalDuration);
    final totalRecognized = summary?.sleepRecognized == null
        ? '0분'
        : TimeUtil.durationToTmStr(summary!.sleepRecognized);
    final totalDeepDuration = summary?.deepDuration == null
        ? '0분'
        : TimeUtil.durationToTmStr(summary!.deepDuration);

    return Container(
      width: 343.w,
      height: 196.h,

      child: Column(
        mainAxisAlignment: .spaceBetween,
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              _summaryContainer(Color(0xff3B82F6), '총 수면 시간', totalDuration),
              _summaryContainer(
                Color(0xffA855F7),
                '갚은 수면 시간',
                totalDeepDuration,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              _summaryContainer(
                Color(0xff93c5fd),
                '수면 점수',
                '${summary?.todayScore ?? 0}점',
              ),
              _summaryContainer(Color(0xff009FFB), '실제 수면 시간', totalRecognized),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryContainer(Color typeColor, String title, String bodyStr) {
    return Container(
      height: 92.h,
      width: 166.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 16.h),
      child: Column(
        mainAxisAlignment: .spaceBetween,
        crossAxisAlignment: .start,
        children: [
          SizedBox(
            height: 20.h,
            width: 134.w,
            child: Row(
              children: [
                Container(
                  height: 12.h,
                  width: 12.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: typeColor,
                  ),
                ),
                Gap(8.w),
                Text(
                  title,
                  style: FeatureTheme.exExplainDetail.copyWith(
                    color: Color(0xff4B5563),
                  ),
                ),
              ],
            ),
          ),
          Text(bodyStr, style: HomeTheme.featureScoreTextStyle),
        ],
      ),
    );
  }

  Widget _sleepGraphContainer(SleepDtlState state) {
    return Container(
      width: 343.w,
      height: 338.h,
      padding: EdgeInsets.symmetric(vertical: 17.h, horizontal: 17.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: .spaceBetween,
        crossAxisAlignment: .start,
        children: [
          Text(
            '수면 타임라인',
            style: FeatureTheme.hrMdText.copyWith(color: Colors.black),
          ),
          SizedBox(
            height: 260.h,
            width: 309.w,
            child: SleepStageGraph(
              stages: state.stages,
              startTime: state.startDate,
            ),
          ),
        ],
      ),
    );
  }

  Widget _stageSummaryContainer(SleepSummary? summary) {
    return Container(
      height: 222.h,
      width: 343.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(vertical: 17.h, horizontal: 17.w),
      child: Column(
        mainAxisAlignment: .spaceBetween,
        crossAxisAlignment: .start,
        children: [
          Text(
            '수면 단계',
            style: FeatureTheme.hrMdText.copyWith(color: Colors.black),
          ),
          Container(
            height: 144.h,
            width: 309.w,
            child: Column(
              mainAxisAlignment: .spaceBetween,
              children: [
                _stageInfo(
                  Color(0xffF87171),
                  '깨어있음',
                  TimeUtil.durationToTmStr(summary?.awakeDuration ?? 0),
                ),
                _stageInfo(
                  Color(0xffFACC15),
                  '얕은 수면',
                  TimeUtil.durationToTmStr(summary?.lightDuration ?? 0),
                ),
                _stageInfo(
                  Color(0xffA855F7),
                  '깊은 수면',
                  TimeUtil.durationToTmStr(summary?.deepDuration ?? 0),
                ),
                _stageInfo(
                  Color(0xff22C55E),
                  '렘수면',
                  TimeUtil.durationToTmStr(summary?.remDuration ?? 0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _stageInfo(Color typeColor, String title, String timeStr) {
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: typeColor,
                  ),
                ),
                Gap(12.w),
                Text(
                  title,
                  style: HomeTheme.titleTextStyle.copyWith(
                    color: Color(0xff374151),
                  ),
                ),
              ],
            ),
          ),
          Text(
            timeStr,
            style: HomeTheme.titleTextStyle.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sleepAnalysisContainer(SleepAnalysis analysis) {
    return Container(
      width: 343.w,
      height: 266.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(vertical: 17.h, horizontal: 17.w),
      child: Column(
        mainAxisAlignment: .spaceBetween,
        crossAxisAlignment: .start,
        children: [
          Text(
            '수면 분석',
            style: FeatureTheme.hrMdText.copyWith(color: Colors.black),
          ),
          Container(
            height: 188.h,
            width: 309.w,
            child: Column(
              mainAxisAlignment: .spaceBetween,
              children: [
                _sleepAnalysisItem(
                  analysis.sleepTimeGrade.iconPath,
                  analysis.sleepTimeAnalysis,
                  analysis.sleepTimeGrade.backGroundColor,
                ),
                _sleepAnalysisItem(
                  analysis.sleepRatioGrade.iconPath,
                  analysis.sleepRatioAnalysis,
                  analysis.sleepTimeGrade.backGroundColor,
                ),
                _sleepAnalysisItem(
                  analysis.sleepCareGrade.iconPath,
                  analysis.sleepCareAnalysis,
                  analysis.sleepTimeGrade.backGroundColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sleepAnalysisItem(
    String iconPath,
    String body,
    Color backgroundColor,
  ) {
    return Container(
      height: 50.h,
      width: 309.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: backgroundColor,
      ),
      child: Row(
        crossAxisAlignment: .center,
        children: [
          SvgPicture.asset(iconPath),
          Text(
            body,
            style: FeatureTheme.exExplainText.copyWith(
              color: Color(0xff374151),
            ),
          ),
        ],
      ),
    );
  }
}
