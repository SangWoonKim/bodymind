import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationView extends StatelessWidget {
  final StatefulNavigationShell navShell;

  const BottomNavigationView({
    super.key,
    required this.navShell,
  });

  void _routeBranch(int idx) {
    navShell.goBranch(
      idx,
      initialLocation: idx == navShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    const selectedColor = Color(0xff4F46E5);
    const unselectedColor = Color(0xff9ca3af); // 원하는 회색으로 바꿔도 됨

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: navShell,
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: const Color(0xffe5e7eb),
                width: 1,
              ),
            ),
            child: MediaQuery.removePadding(
              context: context,
              removeBottom: true,
              removeTop: true,
              removeLeft: true,
              removeRight: true,
              child: NavigationBarTheme(
                data: NavigationBarThemeData(
                  // 선택/비선택 라벨 색상
                  labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
                    final selected = states.contains(WidgetState.selected);
                    return TextStyle(
                      fontSize: 12.sp,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                      color: selected ? selectedColor : unselectedColor,
                    );
                  }),
                  // 선택/비선택 아이콘 색상 (라벨과 동일하게)
                  iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
                    final selected = states.contains(WidgetState.selected);
                    return IconThemeData(
                      size: 24.sp,
                      color: selected ? selectedColor : unselectedColor,
                    );
                  }),
                  // (선택) 인디케이터/배경도 여기서 통제 가능
                  indicatorColor: Colors.transparent, // 원하면 선택 배경 제거
                ),
                child: NavigationBar(
                  height: 65.h,
                  selectedIndex: navShell.currentIndex,
                  onDestinationSelected: _routeBranch,
                  backgroundColor: Colors.white,
                  indicatorColor: Colors.transparent, // 위 테마와 통일
                  labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.home_rounded),
                      label: '홈',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.bar_chart_rounded),
                      label: '분석',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.chat_bubble_rounded),
                      label: '채팅',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.settings),
                      label: '설정',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
