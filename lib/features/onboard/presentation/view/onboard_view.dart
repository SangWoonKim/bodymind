import 'package:bodymind/const/theme/global_theme.dart';
import 'package:bodymind/core/widget/cus_appbar.dart';
import 'package:bodymind/features/onboard/presentation/provider/onboard_provider.dart';
import 'package:bodymind/features/onboard/presentation/theme/onboard_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/widget/cus_button.dart';
import '../enum/onboard_content.dart';

class OnboardView extends ConsumerWidget{

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageModelState = ref.watch(onboardViewModelProvider);

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                pageModelState.content!.backgroundColor,
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
                  ref.read(onboardViewModelProvider.notifier).routeUserRegister(context);
                },
                child: Text('건너뛰기',style: GlobalTheme.leadCustomText,
                ),
              ),
          )
        ),
        body: pageModelState.isLoading ?
            Center(child: CircularProgressIndicator(),)
            : Column(
              children: [
                infoImageArea(ref,pageModelState.content!, pageModelState.controller!, pageModelState.totalPage!),
                infoTextArea(ref,pageModelState.content!, pageModelState.controller!, pageModelState.totalPage!,context)
              ],
            ),
      ),
    );
  }


  Widget infoImageArea(WidgetRef ref, OnboardContent content, PageController ctrl, int pageSize){
    return Container(
      height: 328.h,
      width: 320.w,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
          controller: ctrl,
          itemCount: pageSize,
          itemBuilder: (ctx,idx){
            return Image.asset(OnboardContent.values[idx].path);
          },
          onPageChanged: (idx){
            ref.read(onboardViewModelProvider.notifier).onPageChanged(idx);
          },
      ),
    );
  }

  Widget infoTextArea(WidgetRef ref,OnboardContent content, PageController ctrl, int pageSize, BuildContext context){
    return Container(
      height: 368.h,
      width: 375.w,
      child: Column(
        children: [
          Gap(64.h,),
          SizedBox(height: 30.h,
            child: Text(content.title, style: OnboardTheme.titleText,),
          ),
          Gap(12.h,),
          SizedBox(height: 52.h,
            // child: RichText(
            //     text: TextSpan(
            //         children: InlineSpan())),
            child: Text(content.body, style: OnboardTheme.bodyText, textAlign: TextAlign.center,),
          ),
          Gap(8.h,),
          SizedBox(height: 16.h,
            child: content.caption == null ? null :Text(content.caption!, style: OnboardTheme.captionText),
          ),
          Gap(32.h,),
          SizedBox(height: 6.h,
            child: SmoothPageIndicator(
              controller: ctrl,
              count: pageSize,
            ),
          ),
          Gap(32.h,),
          CommonButton(onTap: (){
            if(content.buttonText == '시작하기'){
              ref.read(onboardViewModelProvider.notifier).routeUserRegister(context);
            }else{

            }

          }, text: content.buttonText)
        ],
      ),
    );
  }
}