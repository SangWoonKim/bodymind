import 'package:bodymind/const/theme/global_theme.dart';
import 'package:bodymind/core/util/bodymind_core_util.dart';
import 'package:bodymind/core/widget/cus_appbar.dart';
import 'package:bodymind/features/main_feature/health/detail/exercise/domain/entity/ex_daily_dto.dart';
import 'package:bodymind/features/main_feature/health/detail/exercise/domain/entity/ex_element_dto.dart';
import 'package:bodymind/features/main_feature/health/detail/exercise/presentation/provider/ex_dtl_provider.dart';
import 'package:bodymind/features/main_feature/health/detail/exercise/presentation/view/templete/ex_dtl_calendar.dart';
import 'package:bodymind/features/main_feature/health/detail/exercise/presentation/viewmodel/ex_dtl_viewmodel.dart';
import 'package:bodymind/features/main_feature/health/detail/util/feature_theme.dart';
import 'package:bodymind/features/main_feature/home/presentation/theme/home_theme.dart';
import 'package:bodymind/features/main_feature/home/presentation/viewmodel/injector/home_exercise_injector.dart';
import 'package:bodymind/features/user/presentation/theme/user_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class HealthExDtlView extends ConsumerStatefulWidget{
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => HealthExDtlViewState();
}

class HealthExDtlViewState extends ConsumerState<HealthExDtlView>{

  @override
  Widget build(BuildContext context) {
    
    final exState = ref.watch(exDtlViewModelProvider);
    final whereData = exState.exDatas.dailyData.where((e) => e.day == exState.selectedDate.day).elementAtOrNull(0);
    final targetDailyData = whereData ?? ExDailyDto.init(exState.selectedDate) ;
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: '운동 기록',
        ),
        body:
          Column(
            crossAxisAlignment: .center,
            children: [
              _dateSelector(exState, ref),
              Gap(20.h),
              _calenderSelector(exState, ref),
              Gap(20.h),
              _summaryArea(targetDailyData),
              _exLstInfo(targetDailyData),
              Expanded(
                child: _dateExLst(exState, context),
              )
            ],
          ),
      ),
    );
  }


  Widget _dateSelector(ExDtlState state, WidgetRef ref){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      height: 73.h,
      width: 375.w,
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xffE5E7EB)))),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          GestureDetector(
            child: SizedBox(
              height: 40.h,
              width: 26.w,
              child: Icon(Icons.arrow_back_ios_new_rounded),
            ),
            onTap: (){
              ref.read(exDtlViewModelProvider.notifier).selectDate(DateTime(state.selectedDate.year, state.selectedDate.month - 1));
            },
          ),

          Text('${state.selectedDate.year}년 ${state.selectedDate.month}월', style: HomeTheme.evaluationTextStyle,),
          GestureDetector(
            child: SizedBox(
              height: 40.h,
              width: 26.w,
              child: Icon(Icons.arrow_forward_ios_rounded),
            ),
            onTap: (){
              ref.read(exDtlViewModelProvider.notifier).selectDate(DateTime(state.selectedDate.year, state.selectedDate.month + 1));
            },
          )
        ],
      ),
    );
  }

  Widget _calenderSelector(ExDtlState state, WidgetRef ref){
    return SizedBox(
      height: 308.h,
      width: 375.w,
      child: ExDtlCalendar(initialDate: state.selectedDate, onDateSelected: (selectedDate){
        ref.read(exDtlViewModelProvider.notifier).selectDate(selectedDate);
      }, exDatas: state.exDatas),
    );
  }

  Widget _summaryArea(ExDailyDto dailyData){
    return Container(
      decoration: BoxDecoration(border: Border(top: BorderSide(color: Color(0xffE5E7EB)))),
      height: 45.h,
      child: Center(
        child: Text('${TimeUtil.yyyyMMddToDtMdString(dailyData.strtYmd)} 운동 ${dailyData.element.length}회 ${dailyData.dailyCalories.round()}kcal', style: FeatureTheme.exSummaryText.copyWith(color: Color(0xff4B5563)),),//parameter
      ),
    );
  }

  Widget _exLstInfo(ExDailyDto dailyData){
    return Container(
      width: double.infinity,
      height: 53.h,
      padding: EdgeInsets.only(left: 16.w, top: 15.h),
      child: Text('${TimeUtil.yyyyMMddToDtMdString(dailyData.strtYmd)} 운동 기록 (${dailyData.element.length})', style: FeatureTheme.hrMdText.copyWith(color: Color(0xff111827)),),// parameter
    );
  }

  Widget _dateExLst(ExDtlState state, BuildContext ctx){
    final List<ExDailyDto> datas = state.exDatas.dailyData.where((e) => e.day == state.selectedDate.day).toList();

    return datas.isEmpty ? Container(
      color: Color(0xfff9fafb),
    ) : Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
          color: Color(0xfff9fafb),
          child: ListView.builder(
                  itemCount: datas.isEmpty ? 0 : datas.first.element.length,
                  itemBuilder: (ctx, idx){
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: _exLstCreator(datas.first.element[idx], ctx),
                    );
                }),
        );
  }

  Widget _exLstCreator(ExElementDto dtlData, BuildContext ctx){
    final endTime = dtlData.strtDt.add(Duration(minutes: dtlData.duration));
    return Container(
      padding: EdgeInsets.symmetric(vertical: 17.h, horizontal: 17.w),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white),
      width: 343.w,
      height: 166.h,
      child: InkWell(
        onTap: (){
          ctx.push('/feature/exercise/daily',extra: [dtlData.strtDt, dtlData]);
        },
        child: Column(
          mainAxisAlignment: .spaceBetween,
          children: [
            //아이콘 및 시간 화살표 영역
            SizedBox(
              width: 310.w,
              height: 44.h,
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Color(0xffDBEAFE)
                    ),
                    height: 40.h,
                    width: 40.w,
                    child: Center(
                      child: SvgPicture.asset('assets/images/icon/runner.svg',colorFilter: ColorFilter.mode(Color(0xff2563eb), BlendMode.srcIn),),//parameter
                    ),
                  ),
                  Container(
                    width: 257.w,
                    height: 44.h,
                    child: Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Container(
                          width: 80.w,
                          height: 76.h,
                          child: RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: dtlData.exName,//parameter
                                      style: HomeTheme.titleTextStyle.copyWith(color: Colors.black)
                                  ),
                                  TextSpan(
                                      text: '\n${dtlData.strtDt.hour}:${dtlData.strtDt.minute}~${endTime.hour}:${endTime.minute}',//parameter
                                      style: FeatureTheme.exExplainText.copyWith(color: Color(0xff6B7280))
                                  )
                                ]
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 24.h,
                          width: 10.w,
                          child: Icon(Icons.arrow_forward_ios_rounded),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),

            SizedBox(
              width: 310.w,
              height: 40.w,
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                          children:[
                            TextSpan(
                                text: '시간',
                                style: FeatureTheme.exExplainText.copyWith(color: Color(0xff6B7280))
                            ),
                            TextSpan(
                                text: '\n${dtlData.duration}분',//parameter
                                style: FeatureTheme.exExplainDetail.copyWith(color: Color(0xff111827))
                            )
                          ]
                      ),
                    ),
                  ),

                  Flexible(
                    flex: 1,
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                          children:[
                            TextSpan(
                                text: '거리',
                                style: FeatureTheme.exExplainText.copyWith(color: Color(0xff6B7280))
                            ),
                            TextSpan(
                                text: '\n${(dtlData.distance/1000).toStringAsFixed(1)}km', //parameter
                                style: FeatureTheme.exExplainDetail.copyWith(color: Color(0xff111827))
                            )
                          ]
                      ),
                    ),
                  ),

                  Flexible(
                    flex: 1,
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                          children:[
                            TextSpan(
                                text: '칼로리',
                                style: FeatureTheme.exExplainText.copyWith(color: Color(0xff6B7280))
                            ),
                            TextSpan(
                                text: '\n${dtlData.activeCalorie.round()}kcal', //parameter
                                style: FeatureTheme.exExplainDetail.copyWith(color: Color(0xff111827))
                            )
                          ]
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 24.h,
              width: 310.w,
              child: Text('점수: ${dtlData.score}'), //parameter
            )
          ],
        ),
      ),
    );
  }



}