import 'package:bodymind/core/widget/cus_text_field.dart';
import 'package:bodymind/features/user/presentation/theme/user_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../const/theme/global_theme.dart';

class UserRegisterTextWidget extends StatelessWidget {
  final String title;
  final String? hint;
  final String? caption;
  final String? leading; // '세', 'cm', 'kg'
  final TextEditingController? controller;
  final KeyboardConfig config;
  final ValueChanged<String> onChanged;

  const UserRegisterTextWidget({
    super.key,
    required this.title,
    this.hint,
    this.caption,
    this.leading,
    this.controller,
    required this.config,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: caption == null ? 76.h : 100.h,
      width: 345.w,
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: UserTheme.titleCustomText.copyWith(color: const Color(0xff111827)),
          ),

          // ✅ 입력 + 단위(세/cm/kg)
          Container(
            height: 56.h, // 48보다 56이 커서/표시 안정적
            width: 345.w,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              border: Border.all(color: const Color.fromRGBO(231, 233, 237, 1)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: controller,
                    hintStr: hint,
                    config: config,
                    onChange: onChanged,
                  ),
                ),
                if (leading != null) ...[
                  SizedBox(width: 8.w),
                  Text(
                    leading!,
                    style: GlobalTheme.leadCustomText.copyWith(
                      color: const Color(0xff9ca3af),
                    ),
                  ),
                ],
              ],
            ),
          ),

          if (caption != null)
            Text(
              caption!,
              style: UserTheme.captionCustomText.copyWith(color: const Color(0xff6b7280)),
            ),
        ],
      ),
    );
  }
}