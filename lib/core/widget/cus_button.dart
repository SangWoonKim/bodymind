import 'package:bodymind/const/theme/global_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonButton extends StatelessWidget{

  final void Function() onTap;
  final String text;
  final Color? background;
  final Color? textColor;

  const CommonButton({super.key, required this.onTap, required this.text, this.background, this.textColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 345.w,
        height: 50.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: background ?? GlobalTheme.customBlue,
        ),
        child: Center(
          child: Text(
              style: GlobalTheme.customText.copyWith(color: textColor),
              text
          ),
        )
      ),
    );
  }

}