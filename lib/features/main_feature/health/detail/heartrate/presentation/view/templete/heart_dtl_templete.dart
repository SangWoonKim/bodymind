import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeartProgressBar extends StatefulWidget {
  final double targetValue; // 0~1
  final Duration duration;
  final Curve curve;
  final Duration delay;

  final double height;
  final Color trackColor;
  final List<Color> gradientColors;

  const HeartProgressBar({
    super.key,
    required this.targetValue,
    this.duration = const Duration(milliseconds: 900),
    this.curve = Curves.easeOutCubic,
    this.delay = Duration.zero,
    this.height = 8,
    this.trackColor = const Color(0xFFE5E7EB),
    this.gradientColors = const [
      Color(0xFFA855F7),
      Color(0xFF6366F1),
    ],
  });

  @override
  State<HeartProgressBar> createState() =>
      _HeartProgressBarState();
}

class _HeartProgressBarState
    extends State<HeartProgressBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);

    _anim = CurvedAnimation(parent: _controller, curve: widget.curve)
        .drive(Tween<double>(begin: 0.0, end: widget.targetValue.clamp(0.0, 1.0)));

    _playOnce();
  }

  Future<void> _playOnce() async {
    if (widget.delay > Duration.zero) {
      await Future.delayed(widget.delay);
      if (!mounted) return;
    }
    _controller.forward(); // ✅ 한 번만 실행
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final v = widget.targetValue.clamp(0.0, 1.0);

    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) {
        return ClipRRect(
          // 트랙도 알약 형태
          borderRadius: BorderRadius.circular(8.h / 2),
          child: SizedBox(
            height: 8.h,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final fullW = constraints.maxWidth;
                final fillW = fullW * v;

                // 오버플로우/라운드 깨짐 방지:
                // 아주 짧게 채워질 때는 "전체를 둥글게" 처리 (시각적 깨짐 방지)
                final r = 8.h / 2;
                final smallCapRadius = (fillW / 2).clamp(0.0, r);

                final fillRadius = fillW < r * 2
                    ? BorderRadius.circular(smallCapRadius)
                    : BorderRadius.only(
                  topRight: Radius.circular(r),
                  bottomRight: Radius.circular(r),
                  // 요청대로 "끝만 둥글게": 시작(왼쪽)은 각지게
                  topLeft: Radius.circular(0),
                  bottomLeft: Radius.circular(0),
                );

                return Stack(
                  fit: StackFit.expand,
                  children: [
                    // Track
                    ColoredBox(color: widget.trackColor),

                    // Fill
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: fillW,
                        height: 8.h,
                        child: ClipRRect(
                          borderRadius: fillRadius,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: widget.gradientColors,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      }
      );
    }
  }