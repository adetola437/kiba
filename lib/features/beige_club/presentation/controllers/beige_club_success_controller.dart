import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class BeigeClubSuccessScreen extends StatefulWidget {
  static const String route = 'beige_club_success';

  final double amount;
  final String startMonth;
  final int positionInRotation;
  final double yearEndPayout;
  final double dailyAccrual;

  const BeigeClubSuccessScreen({
    super.key,
    required this.amount,
    required this.startMonth,
    required this.positionInRotation,
    required this.yearEndPayout,
    required this.dailyAccrual,
  });

  @override
  State<BeigeClubSuccessScreen> createState() =>
      _BeigeClubSuccessScreenState();
}

class _BeigeClubSuccessScreenState extends State<BeigeClubSuccessScreen>
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

    _checkController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _checkScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _checkController,
          curve: const Interval(0.0, 0.65, curve: Curves.elasticOut)));
    _checkOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _checkController,
          curve: const Interval(0.0, 0.3, curve: Curves.easeOut)));
    _ringScale = Tween<double>(begin: 0.6, end: 2.0).animate(
      CurvedAnimation(parent: _checkController,
          curve: const Interval(0.3, 1.0, curve: Curves.easeOut)));
    _ringOpacity = Tween<double>(begin: 0.5, end: 0.0).animate(
      CurvedAnimation(parent: _checkController,
          curve: const Interval(0.3, 1.0, curve: Curves.easeOut)));

    _contentController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _contentOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeOut));
    _contentSlide = Tween<Offset>(
        begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeOut));

    _particleController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000))
      ..repeat();

    _startFlow();
  }

  Future<void> _startFlow() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _checkController.forward();
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
                painter: _SuccessConfettiPainter(
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

                  // Check animation
                  AnimatedBuilder(
                    animation: _checkController,
                    builder: (_, __) => SizedBox(
                      width: 160.r, height: 160.r,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Transform.scale(
                            scale: _ringScale.value,
                            child: Opacity(
                              opacity: _ringOpacity.value,
                              child: Container(
                                width: 160.r, height: 160.r,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: AppColors.beigePink, width: 2),
                                ),
                              ),
                            ),
                          ),
                          Transform.scale(
                            scale: _checkScale.value,
                            child: Opacity(
                              opacity: _checkOpacity.value,
                              child: Container(
                                width: 100.r, height: 100.r,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.beigePink,
                                ),
                                child: Icon(Icons.check_rounded,
                                    size: 52.r, color: AppColors.primary),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 28.h),

                  SlideTransition(
                    position: _contentSlide,
                    child: FadeTransition(
                      opacity: _contentOpacity,
                      child: Column(
                        children: [
                          Text(
                            "You're In\nthe Club!",
                            textAlign: TextAlign.center,
                            style: AppTextStyles.displaySmall.copyWith(
                              fontFamily: 'BWGradual',
                              color: AppColors.white,
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Welcome to the Beige Club family.',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.white.withOpacity(0.6),
                            ),
                          ),

                          SizedBox(height: 24.h),

                          // Summary card
                          Container(
                            width: double.infinity,
                            padding: REdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: AppColors.white.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                  color: AppColors.white.withOpacity(0.12)),
                            ),
                            child: Column(
                              children: [
                                _Row('Monthly Contribution',
                                    _fmt(widget.amount),
                                    valueColor: AppColors.beigePink,
                                    isBold: true),
                                SizedBox(height: 10.h),
                                _Row('Start Month', widget.startMonth),
                                SizedBox(height: 10.h),
                                _Row('Your Position',
                                    'Member #${widget.positionInRotation}'),
                                SizedBox(height: 10.h),
                                _Row('Daily Accrual',
                                    '${_fmt(widget.dailyAccrual)}/day',
                                    valueColor: AppColors.limeGreen),
                                SizedBox(height: 10.h),
                                Divider(
                                    color: AppColors.white.withOpacity(0.1),
                                    height: 1),
                                SizedBox(height: 10.h),
                                _Row('Year-End Payout',
                                    _fmt(widget.yearEndPayout),
                                    valueColor: AppColors.white,
                                    isBold: true),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),

                  FadeTransition(
                    opacity: _contentOpacity,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => context.goNamed('portfolio'),
                          child: Container(
                            width: double.infinity, height: 54.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.beigePink,
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                            child: Text('View Portfolio',
                                style: AppTextStyles.labelLarge.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w700)),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        GestureDetector(
                          onTap: () => context.goNamed('home'),
                          child: Container(
                            width: double.infinity, height: 54.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(14.r),
                              border: Border.all(
                                  color: AppColors.white.withOpacity(0.25)),
                            ),
                            child: Text('Back to Home',
                                style: AppTextStyles.labelLarge.copyWith(
                                    color: AppColors.white)),
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
      children: List.generate(3, (_) => Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(3, (_) => Container(
          margin: EdgeInsets.all(5.r),
          width: 5.r, height: 5.r,
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.12),
            shape: BoxShape.circle,
          ),
        )),
      )),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row(this.label, this.value,
      {this.valueColor, this.isBold = false});
  final String label;
  final String value;
  final Color? valueColor;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: AppTextStyles.bodySmall
                .copyWith(color: AppColors.white.withOpacity(0.55))),
        Text(value,
            style: AppTextStyles.bodySmall.copyWith(
              color: valueColor ?? AppColors.white.withOpacity(0.85),
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            )),
      ],
    );
  }
}

class _SuccessConfettiPainter extends CustomPainter {
  final double progress;
  _SuccessConfettiPainter({required this.progress});

  static const _colors = [
    AppColors.beigePink, AppColors.limeGreen,
    AppColors.cloudyBlue, Colors.white,
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
              height: (6.0 + (i % 4) * 3.0) * 0.5),
          const Radius.circular(2),
        ),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_SuccessConfettiPainter old) =>
      old.progress != progress;
}