import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../beige_club_data.dart';
import 'beige_contribute.dart';

class BeigeClubIntroScreen extends StatelessWidget {
  static const String route = 'beige_club';
  const BeigeClubIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: colorScheme.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Icon(
            Icons.arrow_back_rounded,
            size: 22.r,
            color: colorScheme.onBackground,
          ),
        ),
        title: Text(
          'Beige Club',
          style: AppTextStyles.titleLarge.copyWith(
            color: colorScheme.onBackground,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: REdgeInsets.fromLTRB(20, 8, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Hero banner ──────────────────────────────────
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: -30.r,
                          right: -30.r,
                          child: Container(
                            width: 140.r,
                            height: 140.r,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colorScheme.onPrimary
                                  .withValues(alpha: 0.05),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -20.r,
                          left: 40.r,
                          child: Container(
                            width: 80.r,
                            height: 80.r,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colorScheme.onPrimary
                                  .withValues(alpha: 0.04),
                            ),
                          ),
                        ),
                        Padding(
                          padding: REdgeInsets.all(22),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: REdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: colorScheme.onPrimary
                                      .withValues(alpha: 0.12),
                                  borderRadius:
                                      BorderRadius.circular(20.r),
                                ),
                                child: Text(
                                  'Contributory Investment Product',
                                  style: AppTextStyles.labelSmall.copyWith(
                                    color: colorScheme.onPrimary
                                        .withValues(alpha: 0.8),
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ),
                              SizedBox(height: 12.h),
                              Text(
                                'The Beige Club',
                                style: AppTextStyles.headlineLarge.copyWith(
                                  color: colorScheme.onPrimary,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                'Your exclusive path to financial growth & wealth building.',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: colorScheme.onPrimary
                                      .withValues(alpha: 0.65),
                                  height: 1.5,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              // Key stats row
                              Row(
                                children: [
                                  _HeroBadge(
                                    label: '19% p.a.',
                                    sublabel: 'Target Return',
                                    color: colorScheme.primaryContainer,
                                  ),
                                  SizedBox(width: 10.w),
                                  _HeroBadge(
                                    label: 'SEC',
                                    sublabel: 'Regulated',
                                    color: colorScheme.onPrimary,
                                  ),
                                  SizedBox(width: 10.w),
                                  _HeroBadge(
                                    label: 'Dec 31',
                                    sublabel: 'Maturity',
                                    color: colorScheme.onPrimary,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // ── How It Works ─────────────────────────────────
                  Text(
                    'How It Works',
                    style: AppTextStyles.titleLarge.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 14.h),

                  Row(
                    children: [
                      Expanded(
                        child: _HowItWorksCard(
                          step: '1',
                          icon: Icons.add_circle_outline_rounded,
                          title: 'Contribute',
                          body: 'Add funds anytime. Each contribution earns from the date it\'s made.',
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _HowItWorksCard(
                          step: '2',
                          icon: Icons.trending_up_rounded,
                          title: 'Earn 19%',
                          body: 'Your money earns 19% p.a., accruing daily until December 31.',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(
                        child: _HowItWorksCard(
                          step: '3',
                          icon: Icons.calendar_month_outlined,
                          title: 'Matures Dec 31',
                          body: 'All contributions mature at the end of the calendar year.',
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _HowItWorksCard(
                          step: '4',
                          icon: Icons.swap_horiz_rounded,
                          title: 'Choose Exit',
                          body: 'Roll over, withdraw interest only, or withdraw everything.',
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 24.h),

                  // ── Pro-rata example ──────────────────────────────
                  Container(
                    padding: REdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: colorScheme.outline),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.calculate_outlined,
                              size: 16.r,
                              color: colorScheme.primary,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              'Pro-Rata Example',
                              style: AppTextStyles.titleSmall.copyWith(
                                color: colorScheme.onSurface,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          'Contribute ₦1,000,000 on July 1 → earns interest for 184 days (to Dec 31)',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: 14.h),
                        _ExRow(
                          label: 'Amount Contributed',
                          value: '₦1,000,000',
                        ),
                        _divider(colorScheme),
                        _ExRow(
                          label: 'Days to Dec 31',
                          value: '184 days',
                        ),
                        _divider(colorScheme),
                        _ExRow(
                          label: 'Pro-Rated Interest (19%)',
                          value: '+₦95,616',
                          valueColor: colorScheme.primary,
                        ),
                        _divider(colorScheme),
                        _ExRow(
                          label: 'Year-End Payout',
                          value: '₦1,095,616',
                          isBold: true,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // ── Features ─────────────────────────────────────
                  Text(
                    'Features',
                    style: AppTextStyles.titleLarge.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 14.h),
                  Container(
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: colorScheme.outline),
                    ),
                    child: Column(
                      children: kBeigeClubFeatures
                          .asMap()
                          .entries
                          .map((e) {
                        final isLast =
                            e.key == kBeigeClubFeatures.length - 1;
                        return Column(
                          children: [
                            Padding(
                              padding: REdgeInsets.symmetric(
                                  horizontal: 16, vertical: 14),
                              child: Row(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 34.r,
                                    height: 34.r,
                                    decoration: BoxDecoration(
                                      color: colorScheme.primaryContainer
                                          .withValues(alpha: 0.2),
                                      borderRadius:
                                          BorderRadius.circular(10.r),
                                    ),
                                    child: Icon(
                                      e.value.icon,
                                      size: 16.r,
                                      color: colorScheme.primary,
                                    ),
                                  ),
                                  SizedBox(width: 14.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          e.value.title,
                                          style: AppTextStyles.titleSmall
                                              .copyWith(
                                            color: colorScheme.onSurface,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 3.h),
                                        Text(
                                          e.value.body,
                                          style: AppTextStyles.bodySmall
                                              .copyWith(
                                            color: colorScheme
                                                .onSurfaceVariant,
                                            height: 1.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (!isLast)
                              Divider(
                                height: 1,
                                color: colorScheme.outline,
                                indent: 64.w,
                              ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // ── Exit options ──────────────────────────────────
                  Text(
                    'At Year End, You Choose',
                    style: AppTextStyles.titleLarge.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 14.h),
                  ...[
                    (
                      icon: Icons.autorenew_rounded,
                      title: 'Roll Over Both',
                      body: 'Roll over both your capital and interest into the next investment year.',
                      color: colorScheme.primaryContainer,
                    ),
                    (
                      icon: Icons.savings_outlined,
                      title: 'Roll Over Capital, Withdraw Interest',
                      body: 'Keep your principal invested and receive your earned interest.',
                      color: colorScheme.secondary,
                    ),
                    (
                      icon: Icons.account_balance_wallet_outlined,
                      title: 'Withdraw Everything',
                      body: 'Receive both your capital and all accrued interest.',
                      color: colorScheme.tertiary,
                    ),
                  ].map((opt) => Padding(
                    padding: REdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: REdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: opt.color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: opt.color.withValues(alpha: 0.25),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 32.r,
                            height: 32.r,
                            decoration: BoxDecoration(
                              color: opt.color.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              opt.icon,
                              size: 15.r,
                              color: colorScheme.primary,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  opt.title,
                                  style: AppTextStyles.titleSmall
                                      .copyWith(
                                    color: colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 3.h),
                                Text(
                                  opt.body,
                                  style: AppTextStyles.bodySmall
                                      .copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),

                  SizedBox(height: 24.h),

                  // ── Performance ───────────────────────────────────
                  Container(
                    padding: REdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.bar_chart_rounded,
                              size: 16.r,
                              color: colorScheme.primaryContainer,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              'Club Performance',
                              style: AppTextStyles.titleSmall.copyWith(
                                color: colorScheme.onPrimary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 14.h),
                        _PerfRow(
                          label: 'Target Return',
                          value: '19% p.a.',
                          valueColor: colorScheme.primaryContainer,
                        ),
                        SizedBox(height: 8.h),
                        _PerfRow(
                          label: '2025 Actual Performance',
                          value: '~24% p.a.',
                          valueColor: colorScheme.primaryContainer,
                        ),
                        SizedBox(height: 8.h),
                        _PerfRow(
                          label: 'Benchmark',
                          value: '~10–11%',
                          valueColor: colorScheme.onPrimary
                              .withValues(alpha: 0.6),
                        ),
                        SizedBox(height: 12.h),
                        Container(
                          padding: REdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: colorScheme.primaryContainer
                                .withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            'The club has consistently outperformed the benchmark over the past 3 years.',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: colorScheme.primaryContainer,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),

          // ── CTA ──────────────────────────────────────────────────
          Container(
            padding: REdgeInsets.fromLTRB(20, 12, 20, 32),
            decoration: BoxDecoration(
              color: colorScheme.background,
              border: Border(top: BorderSide(color: colorScheme.outline)),
            ),
            child: GestureDetector(
              onTap: () => context.pushNamed(BeigeClubContributeScreen.route),
              child: Container(
                width: double.infinity,
                height: 56.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Text(
                  'Join Beige Club',
                  style: AppTextStyles.labelLarge.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider(ColorScheme colorScheme) => Padding(
        padding: REdgeInsets.symmetric(vertical: 10),
        child: Divider(color: colorScheme.outline, height: 1),
      );
}

// ── Reusable widgets ───────────────────────────────────────────────────────────

class _HeroBadge extends StatelessWidget {
  const _HeroBadge({
    required this.label,
    required this.sublabel,
    required this.color,
  });

  final String label;
  final String sublabel;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: REdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: AppTextStyles.labelMedium.copyWith(
              color: color == colorScheme.tertiary
                  ? colorScheme.onTertiary
                  : color == colorScheme.secondary
                      ? colorScheme.onSecondary
                      : colorScheme.primaryContainer,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            sublabel,
            style: AppTextStyles.labelSmall.copyWith(
              color: colorScheme.onPrimary.withValues(alpha: 0.6),
              fontSize: 9.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class _HowItWorksCard extends StatelessWidget {
  const _HowItWorksCard({
    required this.step,
    required this.icon,
    required this.title,
    required this.body,
  });

  final String step;
  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: REdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36.r,
                height: 36.r,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  icon,
                  size: 18.r,
                  color: colorScheme.primary,
                ),
              ),
              const Spacer(),
              Text(
                step,
                style: AppTextStyles.headlineSmall.copyWith(
                  color: colorScheme.primary.withValues(alpha: 0.15),
                  fontWeight: FontWeight.w900,
                  fontSize: 28.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            title,
            style: AppTextStyles.titleSmall.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            body,
            style: AppTextStyles.bodySmall.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExRow extends StatelessWidget {
  const _ExRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.isBold = false,
  });

  final String label;
  final String value;
  final Color? valueColor;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: AppTextStyles.bodySmall.copyWith(
            color: valueColor ?? colorScheme.onSurface,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _PerfRow extends StatelessWidget {
  const _PerfRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: colorScheme.onPrimary.withValues(alpha: 0.55),
          ),
        ),
        Text(
          value,
          style: AppTextStyles.bodySmall.copyWith(
            color: valueColor ?? colorScheme.onPrimary.withValues(alpha: 0.85),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}