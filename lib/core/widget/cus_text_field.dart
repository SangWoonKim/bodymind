import 'package:bodymind/const/theme/global_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
enum KeyboardConfig { decimal, digit, text }

class CustomTextField extends StatefulWidget {
  final String? hintStr;
  final KeyboardConfig config;
  final ValueChanged<String> onChange;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    this.hintStr,
    required this.config,
    required this.onChange,
    this.controller,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = FocusNode();

    // 포커스 해제 시 최종 값 반영 (원하면 제거 가능)
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        widget.onChange(_controller.text);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextInputType keyboardType = TextInputType.text;
    List<TextInputFormatter>? formatters;

    switch (widget.config) {
      case KeyboardConfig.decimal:
        keyboardType = const TextInputType.numberWithOptions(decimal: true);
        // decimal 입력 안정적인 formatter (점 1개)
        formatters = [
          TextInputFormatter.withFunction((oldV, newV) {
            final t = newV.text;
            if (!RegExp(r'^[0-9.]*$').hasMatch(t)) return oldV;
            if ('.'.allMatches(t).length > 1) return oldV;
            return newV;
          }),
        ];
        break;

      case KeyboardConfig.digit:
        keyboardType = TextInputType.number;
        formatters = [FilteringTextInputFormatter.digitsOnly];
        break;

      case KeyboardConfig.text:
        keyboardType = TextInputType.text;
        formatters = null;
        break;
    }

    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      keyboardType: keyboardType,
      inputFormatters: formatters,
      textInputAction: TextInputAction.done,
      onSubmitted: (_) => _focusNode.unfocus(),
      onChanged: widget.onChange,

      // 입력 표시 안정화
      textAlignVertical: TextAlignVertical.center,
      style: const TextStyle(
        fontFamily: 'Pretendard',
        fontFamilyFallback: ['Roboto', 'Noto Sans', 'Noto Sans KR'],
        fontSize: 16,
        height: 1.2,
        letterSpacing: 0,
        color: Color(0xff111827),
      ),

      decoration: InputDecoration(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        hintText: widget.hintStr,
        isDense: true,
        // Row/Container에서 패딩을 주니까 여기서는 0이 가장 깔끔
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
