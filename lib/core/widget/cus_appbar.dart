import 'package:bodymind/const/theme/global_theme.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final Color? backgroundColor;
  final Widget? leading;
  final List<Widget> actions;
  final String? title;

  const CustomAppBar({super.key, this.title, this.backgroundColor, this.leading, this.actions = const []});

  @override
  Widget build(BuildContext context) {
   return AppBar(
     title: title != null ? Text(title!, style: GlobalTheme.customText,) : null,
     leading: leading,
     actions: actions,
     backgroundColor: backgroundColor,
   );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}