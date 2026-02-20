import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class HomeProgressIndicator extends StatefulWidget {
  final double progress; // 0.0 ~ 1.0
  final Widget evaluation;
  final TextStyle progressStyle;

  const HomeProgressIndicator({
    super.key,
    required this.progress,
    required this.evaluation,
    required this.progressStyle,
  });

  @override
  State<HomeProgressIndicator> createState() => _HomeProgressIndicatorState();
}

class _HomeProgressIndicatorState extends State<HomeProgressIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<Color?> _colorTween;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _colorTween = controller.drive(
      ColorTween(begin: Colors.redAccent, end: Colors.greenAccent),
    );

    // 처음 값 반영 (초기에는 0일 수도 있음)
    controller.value = widget.progress.clamp(0.0, 1.0);
  }

  @override
  void didUpdateWidget(covariant HomeProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.progress != widget.progress) {
      controller.animateTo(
        widget.progress.clamp(controller.value, 1.0),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          return Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                strokeWidth: 10,
                value: controller.value,
                valueColor: _colorTween,
                backgroundColor: Colors.black,
              ),
              Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget.evaluation,
                      Gap(5.h),
                      Text(
                        '${(controller.value * 100).toInt()}',
                        style: widget.progressStyle,
                      )
                    ],
                  )),
            ],
          );
        },
      ),
    );
  }
}