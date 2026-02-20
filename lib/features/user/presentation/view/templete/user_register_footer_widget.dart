import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserRegisterFooterWidget extends StatelessWidget {
  final bool visible;
  final Widget child;
  final double height;

  const UserRegisterFooterWidget({
    super.key,
    required this.visible,
    required this.child,
    required this.height
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      offset: visible ? Offset.zero : const Offset(0, 1),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 180),
        opacity: visible ? 1 : 0,
        child: SafeArea(
          top: false,
          child: Container(
            padding: EdgeInsets.only(top: 16.h, bottom: 16.h),
            height: height,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xfff3f4f6))
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}