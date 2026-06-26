part of '../controllers/splash.dart';

const Color _kBrand = AppColors.africanGreen;

class SplashView extends StatelessWidget implements SplashViewContract {
  const SplashView({super.key, required this.controller});

  final SplashControllerContract controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: FadeTransition(
        opacity: controller.exitFade,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // ── Decorative dot grids ─────────────────────────────────
            Positioned(
              top: 24.h,
              right: 16.w,
              child: const _DotGrid(rows: 3, cols: 3),
            ),
            Positioned(
              bottom: 40.h,
              left: 16.w,
              child: const _DotGrid(rows: 3, cols: 3),
            ),

            // ── Centre content ───────────────────────────────────────
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FadeTransition(
                    opacity: controller.logoOpacity,
                    child: ScaleTransition(
                      scale: controller.logoScale,
                      child: _AnimatedLogo(
                        lineProgress: controller.logoLineProgress,
                      ),
                    ),
                  ),

                  SizedBox(height: 24.h),

                  SlideTransition(
                    position: controller.kibaSlide,
                    child: FadeTransition(
                      opacity: controller.kibaOpacity,
                      child: Text(
                        'KIBA',
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w700,
                          color: _kBrand,
                          letterSpacing: 8,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 8.h),

                  FadeTransition(
                    opacity: controller.byBeigeOpacity,
                    child: AnimatedBuilder(
                      animation: controller.byBeigeLetterCount,
                      builder: (_, __) {
                        final text = 'by Beige Africa';
                        final count = controller.byBeigeLetterCount.value;
                        final display = count > 0
                            ? text.substring(0, count.clamp(0, text.length))
                            : '';
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              display,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: _kBrand.withOpacity(0.55),
                                letterSpacing: 1.5,
                              ),
                            ),
                            if (count < text.length && count > 0)
                              _BlinkingCursor(),
                          ],
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 20.h),

                  FadeTransition(
                    opacity: controller.taglineOpacity,
                    child: AnimatedBuilder(
                      animation: controller.taglineLetterCount,
                      builder: (_, __) {
                        final text = '...designed to match you';
                        final count = controller.taglineLetterCount.value;
                        final display = count > 0
                            ? text.substring(0, count.clamp(0, text.length))
                            : '';
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              display,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: _kBrand.withOpacity(0.35),
                                letterSpacing: 0.5,
                              ),
                            ),
                            if (count < text.length && count > 0)
                              _BlinkingCursor(),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Animated Logo ──────────────────────────────────────────────────────
class _AnimatedLogo extends StatelessWidget {
  final Animation<double> lineProgress;

  const _AnimatedLogo({required this.lineProgress});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: lineProgress,
      builder: (context, child) {
        return Container(
          width: 80.r,
          height: 80.r,
          decoration: BoxDecoration(
            color: _kBrand,                          // solid dark green, no border
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: CustomPaint(
            size: Size(80.r, 80.r),
            painter: _FanLinesPainter(progress: lineProgress.value),
          ),
        );
      },
    );
  }
}

// ── Blinking cursor ────────────────────────────────────────────────────
class _BlinkingCursor extends StatefulWidget {
  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 530),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Container(
        width: 2.w,
        height: 14.h,
        color: _kBrand.withOpacity(0.5),            // dark green cursor, not white
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// ── Decorative dot grid ────────────────────────────────────────────────
class _DotGrid extends StatelessWidget {
  final int rows;
  final int cols;

  const _DotGrid({required this.rows, required this.cols});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(rows, (r) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(cols, (c) {
            return Container(
              margin: EdgeInsets.all(5.r),
              width: 6.r,
              height: 6.r,
              decoration: BoxDecoration(
                color: _kBrand.withOpacity(0.12),   // dark green dots, subtle
                shape: BoxShape.circle,
              ),
            );
          }),
        );
      }),
    );
  }
}

// ── Custom painter for the fanning V animation ─────────────────────────
// ── Custom painter for the fanning V animation (4 lines) ──────────────
class _FanLinesPainter extends CustomPainter {
  final double progress;

  _FanLinesPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.white
      ..strokeWidth = 4.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final centerX = size.width / 2;
    final tipY = size.height * 0.72;   // Bottom tip (all lines meet here)
    final topY = size.height * 0.18;   // Top of container

    // Phase 1 (0.0 - 0.25): Single center line grows upward from tip
    if (progress <= 0.25) {
      final lineProgress = progress / 0.25;
      final currentTop = tipY - (tipY - topY) * lineProgress;
      canvas.drawLine(
        Offset(centerX, tipY),
        Offset(centerX, currentTop),
        paint,
      );
      return;
    }

    // Phase 2 (0.25 - 0.65): Two inner lines fan outward
    // Phase 3 (0.65 - 1.0): Outer V arms sweep outward

    final innerFanProgress = progress < 0.65
        ? (progress - 0.25) / 0.40
        : 1.0;

    final outerFanProgress = progress < 0.65
        ? 0.0
        : (progress - 0.65) / 0.35;

    // 4 lines evenly spaced by angle from vertical
    // Line 1 (outer left):  +maxAngle
    // Line 2 (inner left):  +maxAngle/3
    // Line 3 (inner right): -maxAngle/3
    // Line 4 (outer right): -maxAngle
    final maxAngle = 0.55;  // ~31.5 degrees from vertical

    final currentInnerAngle = (maxAngle / 3) * _easeOutCubic(innerFanProgress);
    final currentOuterAngle = maxAngle * _easeOutCubic(outerFanProgress);

    final tip = Offset(centerX, tipY);
    final lineLength = tipY - topY;

    // Helper: draw line from tip upward at angle from vertical
    // positive angle = leans left, negative = leans right
    void drawLine(double angleFromVertical) {
      final angleRad = -math.pi / 2 + angleFromVertical;
      final endX = tip.dx + math.cos(angleRad) * lineLength;
      final endY = tip.dy + math.sin(angleRad) * lineLength;
      canvas.drawLine(tip, Offset(endX, endY), paint);
    }

    // ── Outer left ───────────────────────────────────────────────
    if (outerFanProgress > 0) {
      drawLine(currentOuterAngle);
    }

    // ── Inner left ───────────────────────────────────────────────
    if (innerFanProgress > 0) {
      drawLine(currentInnerAngle);
    }

    // ── Inner right ──────────────────────────────────────────────
    if (innerFanProgress > 0) {
      drawLine(-currentInnerAngle);
    }

    // ── Outer right ──────────────────────────────────────────────
    if (outerFanProgress > 0) {
      drawLine(-currentOuterAngle);
    }
  }

  double _easeOutCubic(double t) {
    return 1.0 - math.pow(1.0 - t, 3).toDouble();
  }

  @override
  bool shouldRepaint(covariant _FanLinesPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

