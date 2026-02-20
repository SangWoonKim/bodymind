import 'package:bodymind/const/theme/global_theme.dart';
import 'package:bodymind/features/user/presentation/theme/user_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserRegisterToggleWidget extends StatefulWidget {
  final List<String> buttonsText;
  final int initialIndex;
  final Function(int) onSelectIdx;

  const UserRegisterToggleWidget({
    super.key,
    required this.buttonsText,
    required this.initialIndex,
    required this.onSelectIdx
  });

  @override
  State<UserRegisterToggleWidget> createState() => _UserRegisterToggleWidgetState();
}

class _UserRegisterToggleWidgetState extends State<UserRegisterToggleWidget> {
  int selectedIndex = 0;

  @override
  void initState() {
    selectedIndex = widget.initialIndex;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(widget.buttonsText.length, (idx) =>
        _toggleButton(text: widget.buttonsText[idx], index: idx)
      ),
    );
  }

  Widget _toggleButton({required String text, required int index}) {
    final isActive = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          widget.onSelectIdx(index);
        });
      },
      child: AnimatedContainer(
        height: 48.h,
        width: 106.w,
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromRGBO(229, 231, 235, 1)),
          color: isActive ? GlobalTheme.customBlue : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            style: UserTheme.titleCustomText.copyWith(color: isActive ? Colors.white : Colors.black54),
          ),
        ),
      ),
    );
  }
}