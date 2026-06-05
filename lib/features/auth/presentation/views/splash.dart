part of '../controllers/splash.dart';


// African Green from brand guidelines
const Color _kBrand = Color(0xFF0C3934);

class SplashView extends StatelessWidget implements SplashViewContract {
  const SplashView({super.key, required this.controller});

  final SplashControllerContract controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBrand,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── Decorative dot grid top-right ──────────────────────────────
          Positioned(
            top: 24.h,
            right: 16.w,
            child: const _DotGrid(rows: 3, cols: 3),
          ),

          // ── Decorative dot grid bottom-left ────────────────────────────
          Positioned(
            bottom: 40.h,
            left: 16.w,
            child: const _DotGrid(rows: 3, cols: 3),
          ),

          // ── Centre content ─────────────────────────────────────────────
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // App icon
                FadeTransition(
                  opacity: controller.iconOpacity,
                  child: ScaleTransition(
                    scale: controller.iconScale,
                    child: const _KibaIcon(),
                  ),
                ),

                SizedBox(height: 28.h),

                // Wordmark
                SlideTransition(
                  position: controller.wordmarkSlide,
                  child: FadeTransition(
                    opacity: controller.wordmarkOpacity,
                    child: Column(
                      children: [
                        Text(
                          'KIBA',
                          style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 6,
                          ),
                        ),

                        SizedBox(height: 10.h),

                        // Expanding underline
                        AnimatedBuilder(
                          animation: controller.lineWidth,
                          builder: (_, __) => Container(
                            width: 40.w * controller.lineWidth.value,
                            height: 2.h,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.45),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── App icon ───────────────────────────────────────────────────────────────────
class _KibaIcon extends StatelessWidget {
  const _KibaIcon();

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/kiba_icon.svg',
      width: 80.r,
      height: 80.r,
      fit: BoxFit.contain,
    );
  }
}

// ── Decorative dot grid ────────────────────────────────────────────────────────
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
                color: Colors.white.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
            );
          }),
        );
      }),
    );
  }
}