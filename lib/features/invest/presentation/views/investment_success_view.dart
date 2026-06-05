part of '../controllers/investment_success_controller.dart';

class InvestmentSuccessView extends StatelessWidget
    implements InvestmentSuccessViewContract {
  const InvestmentSuccessView({super.key, required this.controller});

  final InvestmentSuccessControllerContract controller;

  String _fmt(double v) =>
      '₦${NumberFormat('#,##0.00', 'en_US').format(v)}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Stack(
          children: [
            // Confetti particles
            AnimatedBuilder(
              animation: controller.particleController,
              builder: (_, __) => CustomPaint(
                painter: _ConfettiPainter(
                  progress: controller.particleController.value,
                ),
                size: Size(MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height),
              ),
            ),

            // Dot grid top-right
            Positioned(
              top: 20.h,
              right: 16.w,
              child: _DotGrid(),
            ),

            // Dot grid bottom-left
            Positioned(
              bottom: 40.h,
              left: 16.w,
              child: _DotGrid(),
            ),

            // Main content
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 28),
              child: Column(
                children: [
                  const Spacer(),

                  // Check animation
                  AnimatedBuilder(
                    animation: controller.checkController,
                    builder: (_, __) => SizedBox(
                      width: 160.r,
                      height: 160.r,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Ripple ring
                          Transform.scale(
                            scale: controller.ringScale.value,
                            child: Opacity(
                              opacity: controller.ringOpacity.value,
                              child: Container(
                                width: 160.r,
                                height: 160.r,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.limeGreen,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Check circle
                          Transform.scale(
                            scale: controller.checkScale.value,
                            child: Opacity(
                              opacity: controller.checkOpacity.value,
                              child: Container(
                                width: 100.r,
                                height: 100.r,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.limeGreen,
                                ),
                                child: Icon(
                                  Icons.check_rounded,
                                  size: 52.r,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 36.h),

                  // Content
                  SlideTransition(
                    position: controller.contentSlide,
                    child: FadeTransition(
                      opacity: controller.contentOpacity,
                      child: Column(
                        children: [
                          Text(
                            'Investment\nConfirmed!',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.displaySmall.copyWith(
                              fontFamily: 'BWGradual',
                              color: AppColors.white,
                              height: 1.2,
                            ),
                          ),

                          SizedBox(height: 10.h),

                          Text(
                            'Your money is now working for you.',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.white.withOpacity(0.6),
                            ),
                          ),

                          SizedBox(height: 28.h),

                          // Investment summary card
                          Container(
                            width: double.infinity,
                            padding: REdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: AppColors.white.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                color: AppColors.white.withOpacity(0.12),
                              ),
                            ),
                            child: Column(
                              children: [
                                _SuccessRow(
                                  label: 'Product',
                                  value: controller.productName,
                                ),
                                SizedBox(height: 12.h),
                                _SuccessRow(
                                  label: 'Amount Invested',
                                  value: _fmt(controller.amount),
                                  valueColor: AppColors.limeGreen,
                                  isBold: true,
                                ),
                                SizedBox(height: 12.h),
                                _SuccessRow(
                                  label: 'Tenor',
                                  value: '${controller.tenorDays} Days',
                                ),
                                SizedBox(height: 12.h),
                                Divider(
                                  color: AppColors.white.withOpacity(0.1),
                                  height: 1,
                                ),
                                SizedBox(height: 12.h),
                                _SuccessRow(
                                  label: 'Expected at Maturity',
                                  value: _fmt(controller.totalAtMaturity),
                                  valueColor: AppColors.white,
                                  isBold: true,
                                ),
                                SizedBox(height: 12.h),
                                _SuccessRow(
                                  label: 'Maturity Date',
                                  value: DateFormat('MMM d, y')
                                      .format(controller.maturityDate),
                                  icon: Icons.calendar_today_outlined,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Bottom buttons
                  FadeTransition(
                    opacity: controller.contentOpacity,
                    child: Column(
                      children: [
                        // View Portfolio
                        GestureDetector(
                          onTap: controller.onViewPortfolio,
                          child: Container(
                            width: double.infinity,
                            height: 54.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.limeGreen,
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                            child: Text(
                              'View Portfolio',
                              style: AppTextStyles.labelLarge.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 12.h),

                        // Invest More
                        GestureDetector(
                          onTap: controller.onInvestMore,
                          child: Container(
                            width: double.infinity,
                            height: 54.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(14.r),
                              border: Border.all(
                                color: AppColors.white.withOpacity(0.25),
                              ),
                            ),
                            child: Text(
                              'Invest More',
                              style: AppTextStyles.labelLarge.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 24.h),
                      ],
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

// ── Success row ────────────────────────────────────────────────────────────────
class _SuccessRow extends StatelessWidget {
  const _SuccessRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.isBold = false,
    this.icon,
  });

  final String label;
  final String value;
  final Color? valueColor;
  final bool isBold;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.white.withOpacity(0.55),
          ),
        ),
        Row(
          children: [
            if (icon != null) ...[
              Icon(icon, size: 11.r,
                  color: AppColors.white.withOpacity(0.5)),
              SizedBox(width: 4.w),
            ],
            Text(
              value,
              style: AppTextStyles.bodySmall.copyWith(
                color: valueColor ?? AppColors.white.withOpacity(0.85),
                fontWeight:
                    isBold ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ── Dot grid decoration ────────────────────────────────────────────────────────
class _DotGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (r) => Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(3, (c) => Container(
          margin: EdgeInsets.all(5.r),
          width: 5.r,
          height: 5.r,
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.12),
            shape: BoxShape.circle,
          ),
        )),
      )),
    );
  }
}

// ── Confetti painter ───────────────────────────────────────────────────────────
class _ConfettiPainter extends CustomPainter {
  final double progress;

  _ConfettiPainter({required this.progress});

  static final _particles = List.generate(20, (i) => _Particle(i));

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in _particles) {
      final y = (p.startY + progress * size.height * p.speed) % size.height;
      final x = p.startX * size.width +
          20 * (0.5 - p.wobble) * progress;

      final paint = Paint()
        ..color = p.color.withOpacity(0.6 * (1 - progress * 0.3))
        ..style = PaintingStyle.fill;

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(progress * p.rotation);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
              center: Offset.zero, width: p.size, height: p.size * 0.5),
          const Radius.circular(2),
        ),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_ConfettiPainter old) => old.progress != progress;
}

class _Particle {
  final double startX;
  final double startY;
  final double speed;
  final double size;
  final double wobble;
  final double rotation;
  final Color color;

  _Particle(int seed)
      : startX = ((seed * 1.618) % 1.0),
        startY = ((seed * 2.718) % 1.0) * -0.5,
        speed = 0.4 + (seed % 5) * 0.12,
        size = 6.0 + (seed % 4) * 3.0,
        wobble = (seed % 10) / 10.0,
        rotation = (seed % 7) * 0.9,
        color = _confettiColors[seed % _confettiColors.length];

  static const _confettiColors = [
    AppColors.limeGreen,
    AppColors.beigePink,
    AppColors.cloudyBlue,
    Colors.white,
  ];
}