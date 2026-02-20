import 'package:bodymind/const/theme/global_theme.dart';
import 'package:bodymind/features/main_feature/home/presentation/theme/home_theme.dart';
import 'package:bodymind/features/main_feature/home/presentation/view/enum/feature_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class HomeFeatureInfoWidget extends StatelessWidget {
  final FeatureContent content;
  final int featureScore;
  final String evaluationSummery;
  final String onRoute;

  const HomeFeatureInfoWidget({
    super.key,
    required this.content,
    required this.featureScore,
    required this.evaluationSummery,
    required this.onRoute
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 152.h,
      width: 162.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: content.background
        )
      ),
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 32.h,
            width: 66.w,
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 32.h,
                  width: 32.w,
                  decoration: BoxDecoration(
                      color: content.iconColor,
                      borderRadius: BorderRadius.circular(100)),
                  child: Center(
                    child: SvgPicture.asset(content.svgPath,fit: BoxFit.contain,),
                  ),
                ),
                Text(content.featureName, style: GlobalTheme.leadCustomText,)
              ],
            ),
          ),
          Gap(10.h),
          Text(featureScore.toString(), style: HomeTheme.featureScoreTextStyle,),
          Gap(5.h),
          Text(evaluationSummery, style: HomeTheme.infoTextStyle,),
          Gap(9.h),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => context.push(onRoute),
            child: Text('상세보기 >', style: HomeTheme.leadingTextStyle.copyWith(color: content.textColor), ),
          )


        ],
      ),
    );
  }

}