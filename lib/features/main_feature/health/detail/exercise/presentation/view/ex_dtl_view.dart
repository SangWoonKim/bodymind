import 'package:bodymind/core/widget/cus_appbar.dart';
import 'package:bodymind/features/main_feature/health/detail/exercise/presentation/viewmodel/ex_dtl_viewmodel.dart';
import 'package:bodymind/features/main_feature/home/presentation/theme/home_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  }



}