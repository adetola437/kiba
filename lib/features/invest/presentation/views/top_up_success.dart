part of '../controllers/topup_investment_controller.dart';

class TopUpSuccessScreen extends StatefulWidget {
  static const String route = 'topup_success';

  final String productName;
  final double topUpAmount;
  final double revisedPrincipal;
  final double revisedTotalAtMaturity;
  final DateTime maturityDate;

  const TopUpSuccessScreen({
    super.key,
    required this.productName,
    required this.topUpAmount,
    required this.revisedPrincipal,
    required this.revisedTotalAtMaturity,
    required this.maturityDate,
  });

  @override
  State<TopUpSuccessScreen> createState() => _TopUpSuccessScreenState();
}

class _TopUpSuccessScreenState extends State<TopUpSuccessScreen>
    with TickerProviderStateMixin {
  late final AnimationController _checkController;
  late final AnimationController _contentController;
  late final AnimationController _particleController;

  late final Animation<double> _checkScale;
  late final Animation<double> _checkOpacity;
  late final Animation<double> _ringScale;
  late final Animation<double> _ringOpacity;
  late final Animation<double> _contentOpacity;
  late final Animation<Offset> _contentSlide;

  String _fmt(double v) =>
      '₦${NumberFormat('#,##0.00', 'en_US').format(v)}';

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startFlow();
  }

  void _setupAnimations() {
    _checkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _checkScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _checkController,
        curve: const Interval(0.0, 0.65, curve: Curves.elasticOut),
      ),
    );
    _checkOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _checkController,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );
    _ringScale = Tween<double>(begin: 0.6, end: 2.0).animate(
      CurvedAnimation(
        parent: _checkController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );
    _ringOpacity = Tween<double>(begin: 0.5, end: 0.0).animate(
      CurvedAnimation(
        parent: _checkController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );

    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _contentOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeOut),
    );
    _contentSlide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeOut),
    );

    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
  }

  Future<void> _startFlow() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _checkController.forward();
    _particleController.forward();
    await Future.delayed(const Duration(milliseconds: 500));
    _contentController.forward();
  }

  @override
  void dispose() {
    _checkController.dispose();
    _contentController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Stack(
          children: [
            // Confetti
            AnimatedBuilder(
              animation: _particleController,
              builder: (_, __) => CustomPaint(
                painter: _TopUpConfettiPainter(
                    progress: _particleController.value),
                size: Size(MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height),
              ),
            ),

            // Dot grids
            Positioned(
              top: 20.h, right: 16.w,
              child: _buildDotGrid(),
            ),
            Positioned(
              bottom: 40.h, left: 16.w,
              child: _buildDotGrid(),
            ),

            Padding(
              padding: REdgeInsets.symmetric(horizontal: 28),
              child: Column(
                children: [
                  const Spacer(),

                  // ── Check animation ────────────────────────────
                  AnimatedBuilder(
                    animation: _checkController,
                    builder: (_, __) => SizedBox(
                      width: 160.r, height: 160.r,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Ripple ring
                          Transform.scale(
                            scale: _ringScale.value,
                            child: Opacity(
                              opacity: _ringOpacity.value,
                              child: Container(
                                width: 160.r, height: 160.r,
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
                            scale: _checkScale.value,
                            child: Opacity(
                              opacity: _checkOpacity.value,
                              child: Container(
                                width: 100.r, height: 100.r,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.limeGreen,
                                ),
                                child: Icon(
                                  Icons.add_rounded,
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

                  SizedBox(height: 32.h),

                  // ── Content ────────────────────────────────────
                  SlideTransition(
                    position: _contentSlide,
                    child: FadeTransition(
                      opacity: _contentOpacity,
                      child: Column(
                        children: [
                          Text(
                            'Top Up\nSuccessful!',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.displaySmall.copyWith(
                              fontFamily: 'BWGradual',
                              color: AppColors.white,
                              height: 1.2,
                            ),
                          ),

                          SizedBox(height: 8.h),

                          Text(
                            '${_fmt(widget.topUpAmount)} has been added\nto your investment.',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.white.withOpacity(0.6),
                              height: 1.5,
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
                                  label: 'Product',
                                  value: widget.productName,
                                ),
                                SizedBox(height: 10.h),
                                _SuccessRow(
                                  label: 'Amount Added',
                                  value: _fmt(widget.topUpAmount),
                                  valueColor: AppColors.limeGreen,
                                  isBold: true,
                                ),
                                SizedBox(height: 10.h),
                                _SuccessRow(
                                  label: 'New Principal',
                                  value: _fmt(widget.revisedPrincipal),
                                ),
                                SizedBox(height: 10.h),
                                Divider(
                                  color: AppColors.white.withOpacity(0.1),
                                  height: 1,
                                ),
                                SizedBox(height: 10.h),
                                _SuccessRow(
                                  label: 'Revised Total at Maturity',
                                  value: _fmt(
                                      widget.revisedTotalAtMaturity),
                                  valueColor: AppColors.white,
                                  isBold: true,
                                ),
                                SizedBox(height: 10.h),
                                _SuccessRow(
                                  label: 'Maturity Date',
                                  value: DateFormat('MMM d, y')
                                      .format(widget.maturityDate),
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

                  // ── Bottom buttons ─────────────────────────────
                  FadeTransition(
                    opacity: _contentOpacity,
                    child: Column(
                      children: [
                        // View Investment
                        GestureDetector(
                          onTap: () => context.goNamed('portfolio'),
                          child: Container(
                            width: double.infinity,
                            height: 54.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.limeGreen,
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                            child: Text(
                              'View Investment',
                              style: AppTextStyles.labelLarge.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 12.h),

                        // Back to Home
                        GestureDetector(
                          onTap: () => context.goNamed('home'),
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
                              'Back to Home',
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

  Widget _buildDotGrid() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        3,
        (_) => Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            3,
            (_) => Container(
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
                fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ── Confetti painter ───────────────────────────────────────────────────────────
class _TopUpConfettiPainter extends CustomPainter {
  final double progress;
  _TopUpConfettiPainter({required this.progress});

  static const _colors = [
    AppColors.limeGreen,
    AppColors.beigePink,
    AppColors.cloudyBlue,
    Colors.white,
  ];

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < 20; i++) {
      final x = ((i * 1.618) % 1.0) * size.width +
          20 * ((i % 10) / 10.0 - 0.5) * progress;
      final y = (((i * 2.718) % 1.0) * -0.5 * size.height +
              progress * size.height * (0.4 + (i % 5) * 0.12)) %
          size.height;
      final paint = Paint()
        ..color = _colors[i % _colors.length]
            .withOpacity(0.6 * (1 - progress * 0.3));
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(progress * (i % 7) * 0.9);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset.zero,
            width: 6.0 + (i % 4) * 3.0,
            height: (6.0 + (i % 4) * 3.0) * 0.5,
          ),
          const Radius.circular(2),
        ),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_TopUpConfettiPainter old) =>
      old.progress != progress;
}