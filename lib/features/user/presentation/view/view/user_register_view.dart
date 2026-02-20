import 'package:bodymind/core/widget/cus_appbar.dart';
import 'package:bodymind/core/widget/cus_button.dart';
import 'package:bodymind/core/widget/cus_text_field.dart';
import 'package:bodymind/features/user/presentation/provider/user_provider.dart';
import 'package:bodymind/features/user/presentation/view/templete/user_register_footer_widget.dart';
import 'package:bodymind/features/user/presentation/view/templete/user_register_toggle_widget.dart';
import 'package:bodymind/features/user/presentation/view/templete/uset_register_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../const/theme/global_theme.dart';
import '../../theme/user_theme.dart';

class UserRegisterView extends ConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageModelState = ref.watch(userViewModelProvider);

   return Container(
     decoration: BoxDecoration(
         gradient: LinearGradient(
             begin: Alignment.topCenter,
             end: Alignment.bottomCenter,
             colors: [
               Color.fromRGBO(249, 250, 251, 1),
               Colors.white
             ]
         )
     ),
     child: Scaffold(
       backgroundColor: Colors.transparent,
       appBar: CustomAppBar(
         backgroundColor: Colors.transparent,
         leading: Container(color: Colors.transparent,
           child: GestureDetector(
             onTap: (){
                if(pageModelState.isComplete){
                  ref.read(userViewModelProvider.notifier).routeUserPage(context);
                }
             },
             child: Text(pageModelState.isComplete ? '정보입력':'다음',
               style: GlobalTheme.leadCustomText,
             ),
           ),
        ),
       ),
       body: Stack(
         children: [
           Positioned.fill(
             child: Container(
               color: Colors.transparent,
               child: Align(
                 alignment: Alignment.topCenter,
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     topArea(),
                     Gap(32.h),
                     Expanded(
                         child: SingleChildScrollView(
                           keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                           padding: EdgeInsets.only(bottom: 120.h),
                             child: writeInfoArea(ref)
                         )
                     ),
                   ],
                 ),
               ),
             ),
           ),
           completeFooter(context, pageModelState.isComplete,ref)
         ],
       ),
     ),
   );
  }


  Widget topArea(){
    return Container(
      height: 130.h,
      width: 345.w,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xff6366f1),
                Color(0xff9333ea)
              ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: Color(0xffe5e7eb),

          )
      ),
      child: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 34.h, 0, 34.h),
              child: Container(
                height: 61.h,
                width: 260.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('점수를 더 정확하게 만들어요', style: GlobalTheme.titleCustomText.copyWith(color: Colors.white, fontWeight: FontWeight.w600),),
                    Text('나이·성별·키·몸무게는 점수 계산에만 사용돼요.',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        height: 23.sp / 14.sp,
                        letterSpacing: -0.5.sp,
                        color: Color(0xffa5b4fc)
                      ),
                    )
                  ],
                )),
      )
      
      ,
    );
  }

  Widget writeInfoArea(WidgetRef ref){
    return Container(
      height: 560.h,
      width: 345.w,
      color: Colors.transparent,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          UserRegisterTextWidget(title: '닉네임', caption: '2~10자', config: KeyboardConfig.text, onChanged: (input){
            ref.read(userViewModelProvider.notifier).appendUserInfo(nickName: input);
            },),
          Gap(24.h),
          toggleGenderArea(ref),
          Gap(24.h),
          UserRegisterTextWidget(title: '나이', leading: '세', config: KeyboardConfig.digit, onChanged: (input){
            ref.read(userViewModelProvider.notifier).appendUserInfo(age: int.tryParse(input));
          }),
          Gap(24.h),
          UserRegisterTextWidget(title: '키', leading: 'cm', config: KeyboardConfig.decimal, onChanged: (input){
            ref.read(userViewModelProvider.notifier).appendUserInfo(height: double.tryParse(input));
          }),
          Gap(24.h),
          UserRegisterTextWidget(title: '몸무게', caption: '소수점 입력 가능', leading: 'kg', config: KeyboardConfig.decimal, onChanged: (input){
            ref.read(userViewModelProvider.notifier).appendUserInfo(weight: double.tryParse(input));
          })
        ],
      ),
    );
  }

  Widget toggleGenderArea(WidgetRef ref){
    return Container(
      color: Colors.transparent,
      height: 80.h,
      width: 345.w,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('성별', style:UserTheme.titleCustomText),
            UserRegisterToggleWidget(
              buttonsText: ['남성', '여성', '선택 안 함'],
              initialIndex: 2,
              onSelectIdx: (idx){
                switch(idx){
                  case 0:
                    ref.read(userViewModelProvider.notifier).appendUserInfo(gender: 'M');
                    break;
                  case 1:
                    ref.read(userViewModelProvider.notifier).appendUserInfo(gender: 'F');
                    break;
                  case 2:
                    ref.read(userViewModelProvider.notifier).appendUserInfo(gender: null);
                    break;
                }
              },
            )
          ]
      ),);
  }

  Widget completeFooter(BuildContext context,bool isComplete, WidgetRef ref ){
    return Align(
      alignment: Alignment.bottomCenter,
      child: UserRegisterFooterWidget(
          visible: isComplete,
          height: 110.h,
          child: Center(
            child: Column(
              children: [
                CommonButton(onTap: (){
                  ref.read(userViewModelProvider.notifier).insertUserInfo(context);
                }, text: '완료하고 시작하기', textColor: Colors.white,),
                Gap(9.h),
                Text('입력한 정보는 언제든 수정할 수 있어요', style: UserTheme.captionCustomText.copyWith(color: Color(0xff9ca3af)),)
              ],
            ),
          )),
    );
  }

}