part of '../controllers/withdraw_success_controller.dart';

class WithdrawSuccessView extends StatelessWidget
    implements WithdrawSuccessViewContract {
  const WithdrawSuccessView({super.key, required this.controller});

  final WithdrawSuccessControllerContract controller;

  String _fmt(double v) => '₦${NumberFormat('#,##0.00', 'en_US').format(v)}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Stack(
          children: [
            // ── Confetti particles ─────────────────────────────────
            AnimatedBuilder(
              animation: controller.particleController,
              builder: (_, __) => CustomPaint(
                painter: _WithdrawConfettiPainter(
                  progress: controller.particleController.value,
                ),
                size: Size(
                  MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height,
                ),
              ),
            ),

            // Dot grids
            Positioned(
              top: 20.h,
              right: 16.w,
              child: _DotGrid(),
            ),
            Positioned(
              bottom: 40.h,
              left: 16.w,
              child: _DotGrid(),
            ),

            // ── Main content ─────────────────────────────────────
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 28),
              child: Column(
                children: [
                  const Spacer(),

                  // Animated check circle
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
                                    color: AppColors.beigePink,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Check circle — beigePink for withdrawal
                          Transform.scale(
                            scale: controller.checkScale.value,
                            child: Opacity(
                              opacity: controller.checkOpacity.value,
                              child: Container(
                                width: 100.r,
                                height: 100.r,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.beigePink,
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

                  // Content slides in
                  SlideTransition(
                    position: controller.contentSlide,
                    child: FadeTransition(
                      opacity: controller.contentOpacity,
                      child: Column(
                        children: [
                          Text(
                            'Withdrawal\nSuccessful!',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.displaySmall.copyWith(
                              fontFamily: 'BWGradual',
                              color: AppColors.white,
                              height: 1.2,
                            ),
                          ),

                          SizedBox(height: 10.h),

                          Text(
                            'Your funds are on their way.',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.white.withOpacity(0.6),
                            ),
                          ),

                          SizedBox(height: 28.h),

                          // Summary card
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
                                  label: 'Amount',
                                  value: _fmt(controller.amount),
                                  valueColor: AppColors.beigePink,
                                  isBold: true,
                                ),
                                SizedBox(height: 12.h),
                                _SuccessRow(
                                  label: 'Destination',
                                  value: controller.account.bankName,
                                ),
                                SizedBox(height: 12.h),
                                _SuccessRow(
                                  label: 'Account',
                                  value: controller.account.maskedNumber,
                                ),
                                SizedBox(height: 12.h),
                                Divider(
                                  color: AppColors.white.withOpacity(0.1),
                                  height: 1,
                                ),
                                SizedBox(height: 12.h),
                                _SuccessRow(
                                  label: 'Reference',
                                  value: controller.reference,
                                  valueColor:
                                      AppColors.white.withOpacity(0.55),
                                ),
                                SizedBox(height: 8.h),
                                _SuccessRow(
                                  label: 'Arrival',
                                  value: 'Instant (2-5 mins)',
                                  icon: Icons.access_time_rounded,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Buttons
                  FadeTransition(
                    opacity: controller.contentOpacity,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: controller.onGoToWallet,
                          child: Container(
                            width: double.infinity,
                            height: 54.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.beigePink,
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                            child: Text(
                              'Back to Wallet',
                              style: AppTextStyles.labelLarge.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 12.h),

                        GestureDetector(
                          onTap: controller.onViewTransactions,
                          child: Container(
                            width: double.infinity,
                            height: 54.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14.r),
                              border: Border.all(
                                color: AppColors.white.withOpacity(0.25),
                              ),
                            ),
                            child: Text(
                              'View Transactions',
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
              Icon(icon, size: 11.r, color: AppColors.white.withOpacity(0.5)),
              SizedBox(width: 4.w),
            ],
            Text(
              value,
              style: AppTextStyles.bodySmall.copyWith(
                color: valueColor ?? AppColors.white.withOpacity(0.85),
                fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
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
      children: List.generate(
        3,
        (r) => Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            3,
            (c) => Container(
              margin: EdgeInsets.all(5.r),
              width: 5.r,
              height: 5.r,
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Confetti painter ───────────────────────────────────────────────────────────
class _WithdrawConfettiPainter extends CustomPainter {
  final double progress;
  _WithdrawConfettiPainter({required this.progress});

  static final _particles = List.generate(20, (i) => _Particle(i));

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in _particles) {
      final y = (p.startY + progress * size.height * p.speed) % size.height;
      final x =
          p.startX * size.width + 20 * (0.5 - p.wobble) * progress;
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
  bool shouldRepaint(_WithdrawConfettiPainter old) =>
      old.progress != progress;
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
        color = _colors[seed % _colors.length];

  static const _colors = [
    AppColors.beigePink,
    AppColors.limeGreen,
    AppColors.cloudyBlue,
    Colors.white,
  ];
}
