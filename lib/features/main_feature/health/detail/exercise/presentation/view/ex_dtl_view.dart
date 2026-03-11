import 'package:bodymind/const/theme/global_theme.dart';
import 'package:bodymind/core/widget/cus_appbar.dart';
import 'package:bodymind/features/main_feature/health/detail/exercise/domain/entity/ex_daily_dto.dart';
import 'package:bodymind/features/main_feature/health/detail/exercise/domain/entity/ex_element_dto.dart';
import 'package:bodymind/features/main_feature/health/detail/exercise/presentation/view/templete/ex_dtl_calendar.dart';
import 'package:bodymind/features/main_feature/health/detail/exercise/presentation/viewmodel/ex_dtl_viewmodel.dart';
import 'package:bodymind/features/main_feature/health/detail/util/feature_theme.dart';
import 'package:bodymind/features/main_feature/home/presentation/theme/home_theme.dart';
import 'package:bodymind/features/user/presentation/theme/user_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ExDtlView extends ConsumerStatefulWidget{
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ExDtlViewState();
}

class ExDtlViewState extends ConsumerState<ExDtlView>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '운동 기록',
      ),
      body: ,
    );
  }


  Widget _dateSelector(ExDtlState state){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      height: 75.h,
      width: 375.w,
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

            },
          ),

          Text('${state.currentDate.year}년 ${state.currentDate.month}월', style: HomeTheme.evaluationTextStyle,),
          GestureDetector(
            child: SizedBox(
              height: 40.h,
              width: 26.w,
              child: Icon(Icons.arrow_forward_ios_rounded),
            ),
            onTap: (){},
          )
        ],
      ),
    );
  }

  Widget _calenderSelector(ExDtlState state){
    return SizedBox(
      height: 324.h,
      width: 343.w,
      child: ExDtlCalendar(initialDate: state.selectedDate, onDateSelected: (){}, exDatas: state.exDatas),
    );
  }

  Widget _summaryArea(ExDailyDto dailyData){
    return SizedBox(
      height: 45.h,
      child: Center(
        child: Text('3월 9일 운동 2회 420kcal', style: FeatureTheme.exSummaryText.copyWith(color: Color(0xff4B5563)),),//parameter
      ),
    );
  }

  Widget _exLstInfo(ExDailyDto dailyData){
    return Container(
      height: 53.h,
      padding: EdgeInsets.only(left: 16.w, top: 15.h),
      child: Text('3월 9일 운동 기록 (2)', style: FeatureTheme.hrMdText.copyWith(color: Color(0xff11827)),),// parameter
    );
  }

  Widget _dateExLst(ExDtlState state){
    final List<ExDailyDto> datas = state.exDatas.where((e) => e.day == state.selectedDate.days).toList();
    return ListView.builder(
      itemCount: datas.first.element.length,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h ),
        itemBuilder: (ctx, idx){
          return _exLstCreator(datas.first.element[idx]);
        });
  }

  Widget _exLstCreator(ExElementDto dtlData){
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      width: 343.w,
      height: 166.h,
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
                    child: SvgPicture.asset('assets/images/icon/ex/runner.svg',colorFilter: ColorFilter.mode(Color(0xff2563eb), BlendMode.srcIn),),//parameter
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
                                    text: '러닝',//parameter
                                    style: HomeTheme.titleTextStyle
                                ),
                                TextSpan(
                                    text: '\n19:10~19:42',//parameter
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
                              text: '\n32분',//parameter
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
                              text: '\n3.4km', //parameter
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
                              text: '\n240kcal', //parameter
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
            child: Text('점수: ${30}'), //parameter
          )
        ],
      ),
    );
  }



}