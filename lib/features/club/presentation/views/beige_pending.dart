import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../beige_club_data.dart';
import 'beige_contribute.dart';

// ── Pending / Under Review Screen ──────────────────────────────────────────────

class BeigeClubPendingScreen extends StatelessWidget {
  static const String route = 'beige_club_pending';

  final double amount;
  final double yearEndValue;

  const BeigeClubPendingScreen({
    super.key,
    required this.amount,
    required this.yearEndValue,
  });

  String _fmt(double v) =>
      '₦${NumberFormat('#,##0.00', 'en_US').format(v)}';

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              const Spacer(),

              // Hourglass animation placeholder
              Container(
                width: 100.r,
                height: 100.r,
                decoration: BoxDecoration(
                  color: colorScheme.secondaryContainer
                      .withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.hourglass_top_rounded,
                  size: 48.r,
                  color: colorScheme.primary,
                ),
              ),

              SizedBox(height: 28.h),

              Text(
                'Payment Under\nReview',
                textAlign: TextAlign.center,
                style: AppTextStyles.displaySmall.copyWith(
                  color: colorScheme.onBackground,
                  height: 1.2,
                ),
              ),

              SizedBox(height: 12.h),

              Text(
                'Our compliance team is verifying your payment. This typically takes 24–48 business hours.',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.6,
                ),
              ),

              SizedBox(height: 32.h),

              // Summary card
              Container(
                width: double.infinity,
                padding: REdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: colorScheme.outline),
                ),
                child: Column(
                  children: [
                    _PendingRow(
                      label: 'Amount Submitted',
                      value: _fmt(amount),
                      valueColor: colorScheme.primary,
                      isBold: true,
                    ),
                    SizedBox(height: 10.h),
                    _PendingRow(
                      label: 'Expected Year-End Value',
                      value: _fmt(yearEndValue),
                    ),
                    SizedBox(height: 10.h),
                    _PendingRow(
                      label: 'Maturity Date',
                      value: 'December 31, ${DateTime.now().year}',
                      icon: Icons.calendar_today_outlined,
                    ),
                    SizedBox(height: 10.h),
                    _PendingRow(
                      label: 'Status',
                      value: 'Pending Verification',
                      valueColor: colorScheme.onSurface,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              // What happens next
              Container(
                padding: REdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colorScheme.secondaryContainer
                      .withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    color: colorScheme.tertiary
                        .withValues(alpha: 0.15),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'What happens next?',
                      style: AppTextStyles.titleSmall.copyWith(
                        color: colorScheme.tertiary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    ...[
                      'Our team verifies your payment receipt',
                      'Your contribution is confirmed and activated',
                      'You receive an email confirmation',
                      'Interest starts accruing from the confirmation date',
                    ].asMap().entries.map((e) => Padding(
                          padding: REdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 18.r,
                                height: 18.r,
                                decoration: BoxDecoration(
                                  color: colorScheme.tertiary
                                      .withValues(alpha: 0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '${e.key + 1}',
                                    style: AppTextStyles.labelSmall.copyWith(
                                      color: colorScheme.tertiary,
                                      fontSize: 9.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  e.value,
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: colorScheme.tertiary,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),

              const Spacer(),

              // Back to home
              GestureDetector(
                onTap: () => context.goNamed('home'),
                child: Container(
                  width: double.infinity,
                  height: 56.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Text(
                    'Back to Home',
                    style: AppTextStyles.labelLarge.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _PendingRow extends StatelessWidget {
  const _PendingRow({
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
        Row(
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 11.r,
                color: colorScheme.onSurface.withValues(alpha: 0.38),
              ),
              SizedBox(width: 4.w),
            ],
            Text(
              value,
              style: AppTextStyles.bodySmall.copyWith(
                color: valueColor ?? colorScheme.onSurface,
                fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ── Active Dashboard Screen ────────────────────────────────────────────────────

class BeigeClubDashboardScreen extends StatelessWidget {
  static const String route = 'beige_club_dashboard';
  const BeigeClubDashboardScreen({super.key});

  String _fmt(double v) =>
      '₦${NumberFormat('#,##0.00', 'en_US').format(v)}';

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final sub = kMockBeigeClubActive;
    final dateFormat = DateFormat('MMM d, y');
    final isNearMaturity = sub.daysToYearEnd <= 30;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
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
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: REdgeInsets.fromLTRB(20, 8, 20, 40),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // ── Near maturity banner ───────────────────────
                if (isNearMaturity) ...[
                  Container(
                    padding: REdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer
                          .withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: colorScheme.primaryContainer
                            .withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.celebration_rounded,
                          size: 16.r,
                          color: colorScheme.primary,
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            'Your investment matures in ${sub.daysToYearEnd} days on Dec 31. Choose your exit option.',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w500,
                              height: 1.4,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context
                              .pushNamed(BeigeClubMaturityScreen.route),
                          child: Container(
                            padding: REdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: colorScheme.primary,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              'Choose',
                              style: AppTextStyles.labelSmall
                                  .copyWith(color: colorScheme.onPrimary),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 14.h),
                ],

                // ── Stats card ─────────────────────────────────
                Container(
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
                          width: 120.r,
                          height: 120.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colorScheme.onPrimary
                                .withValues(alpha: 0.04),
                          ),
                        ),
                      ),
                      Padding(
                        padding: REdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'BEIGE CLUB',
                                  style: AppTextStyles.labelSmall.copyWith(
                                    color: colorScheme.onPrimary
                                        .withValues(alpha: 0.55),
                                    letterSpacing: 1.0,
                                    fontSize: 9.sp,
                                  ),
                                ),
                                Container(
                                  padding: REdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: colorScheme.primaryContainer
                                        .withValues(alpha: 0.2),
                                    borderRadius:
                                        BorderRadius.circular(20.r),
                                  ),
                                  child: Text(
                                    'ACTIVE',
                                    style: AppTextStyles.labelSmall
                                        .copyWith(
                                      color: colorScheme.primaryContainer,
                                      letterSpacing: 0.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              'TOTAL CONTRIBUTED',
                              style: AppTextStyles.labelSmall.copyWith(
                                color: colorScheme.onPrimary
                                    .withValues(alpha: 0.5),
                                fontSize: 9.sp,
                                letterSpacing: 0.8,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              _fmt(sub.totalContributed),
                              style: TextStyle(
                                fontFamily: 'EuclidCircularA',
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w700,
                                color: colorScheme.onPrimary,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Row(
                              children: [
                                Icon(
                                  Icons.trending_up_rounded,
                                  size: 12.r,
                                  color: colorScheme.primaryContainer,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  '+${_fmt(sub.accruedInterest)} accrued',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: colorScheme.primaryContainer,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            // Stats row
                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  _DashStat(
                                    label: 'RATE',
                                    value: '${kBeigeClubRate}% p.a.',
                                    valueColor: colorScheme.primaryContainer,
                                  ),
                                  VerticalDivider(
                                    color: colorScheme.onPrimary
                                        .withValues(alpha: 0.15),
                                    width: 1,
                                    thickness: 1,
                                  ),
                                  _DashStat(
                                    label: 'DAYS TO DEC 31',
                                    value: '${sub.daysToYearEnd}d',
                                  ),
                                  VerticalDivider(
                                    color: colorScheme.onPrimary
                                        .withValues(alpha: 0.15),
                                    width: 1,
                                    thickness: 1,
                                  ),
                                  _DashStat(
                                    label: 'DAILY ACCRUAL',
                                    value: _fmt(sub.dailyAccrual),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 14.h),
                            // Progress to Dec 31
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Year progress',
                                      style: AppTextStyles.bodySmall
                                          .copyWith(
                                        color: colorScheme.onPrimary
                                            .withValues(alpha: 0.6),
                                      ),
                                    ),
                                    Text(
                                      'Matures Dec 31',
                                      style: AppTextStyles.bodySmall
                                          .copyWith(
                                        color: colorScheme.onPrimary
                                            .withValues(alpha: 0.5),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 6.h),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4.r),
                                  child: LinearProgressIndicator(
                                    value: sub.progressPercent,
                                    minHeight: 5.h,
                                    backgroundColor: colorScheme.onPrimary
                                        .withValues(alpha: 0.15),
                                    valueColor: AlwaysStoppedAnimation(
                                      colorScheme.primaryContainer,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 14.h),

                // ── Projected year-end value ───────────────────
                Container(
                  padding: REdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: colorScheme.primaryContainer
                          .withValues(alpha: 0.25),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Projected Year-End Value',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            _fmt(sub.projectedYearEndValue),
                            style: AppTextStyles.titleLarge.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 20.r,
                        color: colorScheme.primary.withValues(alpha: 0.3),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),

                // ── Quick actions ──────────────────────────────
                Row(
                  children: [
                    Expanded(
                      child: _ActionCard(
                        icon: Icons.add_circle_outline_rounded,
                        label: 'Add\nContribution',
                        color: colorScheme.primary,
                        onTap: () => context.pushNamed(
                            'beige_club_contribute'),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _ActionCard(
                        icon: Icons.history_rounded,
                        label: 'Contribution\nHistory',
                        color: colorScheme.tertiary,
                        onTap: () => context.pushNamed(
                            BeigeClubHistoryScreen.route),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _ActionCard(
                        icon: Icons.swap_horiz_rounded,
                        label: 'Maturity\nOptions',
                        color: colorScheme.onSurface,
                        onTap: () => context.pushNamed(
                            BeigeClubMaturityScreen.route),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 28.h),

                // ── Contributions breakdown ────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Contributions',
                      style: AppTextStyles.titleLarge.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context
                          .pushNamed(BeigeClubHistoryScreen.route),
                      child: Text(
                        'View all',
                        style: AppTextStyles.labelMedium
                            .copyWith(color: colorScheme.primary),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 14.h),
                Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: colorScheme.outline),
                  ),
                  child: Column(
                    children: sub.contributions
                        .asMap()
                        .entries
                        .map((e) {
                      final c = e.value;
                      final isLast =
                          e.key == sub.contributions.length - 1;
                      return Column(
                        children: [
                          Padding(
                            padding: REdgeInsets.symmetric(
                                horizontal: 16, vertical: 13),
                            child: Row(
                              children: [
                                Container(
                                  width: 38.r,
                                  height: 38.r,
                                  decoration: BoxDecoration(
                                    color: colorScheme.primaryContainer
                                        .withValues(alpha: 0.15),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.add_rounded,
                                    size: 16.r,
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
                                        _fmt(c.amount),
                                        style: AppTextStyles.titleSmall
                                            .copyWith(
                                          color: colorScheme.onSurface,
                                        ),
                                      ),
                                      Text(
                                        dateFormat.format(c.date),
                                        style: AppTextStyles.bodySmall
                                            .copyWith(
                                          color: colorScheme.onSurface
                                              .withValues(alpha: 0.38),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '+${_fmt(c.projectedInterest)}',
                                      style: AppTextStyles.bodySmall
                                          .copyWith(
                                        color: colorScheme.primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      'est. interest',
                                      style: AppTextStyles.labelSmall
                                          .copyWith(
                                        color: colorScheme.onSurface
                                            .withValues(alpha: 0.38),
                                        fontSize: 9.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if (!isLast)
                            Divider(
                              height: 1,
                              color: colorScheme.outline,
                              indent: 66.w,
                            ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _DashStat extends StatelessWidget {
  const _DashStat({required this.label, required this.value, this.valueColor});

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Expanded(
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTextStyles.labelSmall.copyWith(
                color: colorScheme.onPrimary.withValues(alpha: 0.5),
                fontSize: 8.sp,
                letterSpacing: 0.6,
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              value,
              style: AppTextStyles.bodySmall.copyWith(
                color: valueColor ?? colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: REdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: color.withValues(alpha: 0.15)),
        ),
        child: Column(
          children: [
            Icon(icon, size: 22.r, color: color),
            SizedBox(height: 6.h),
            Text(
              label,
              textAlign: TextAlign.center,
              style: AppTextStyles.labelSmall.copyWith(
                color: color,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Maturity Options Screen ────────────────────────────────────────────────────

class BeigeClubMaturityScreen extends StatefulWidget {
  static const String route = 'beige_club_maturity';
  const BeigeClubMaturityScreen({super.key});

  @override
  State<BeigeClubMaturityScreen> createState() =>
      _BeigeClubMaturityScreenState();
}

class _BeigeClubMaturityScreenState
    extends State<BeigeClubMaturityScreen> {
  MaturityOption? _selected;
  bool _isLoading = false;

  String _fmt(double v) =>
      '₦${NumberFormat('#,##0.00', 'en_US').format(v)}';

  static final _options = [
    (
      option: MaturityOption.rollOverBoth,
      icon: Icons.autorenew_rounded,
      title: 'Roll Over Both Capital & Interest',
      description:
          'Your entire payout (₦297,500) rolls into next year\'s cycle, compounding your returns.',
      color: Colors.green,
      tag: 'RECOMMENDED',
    ),
    (
      option: MaturityOption.rollOverCapitalWithdrawInterest,
      icon: Icons.savings_outlined,
      title: 'Roll Over Capital, Withdraw Interest',
      description:
          'Keep your ₦250,000 principal invested and receive ₦47,500 earned interest to your wallet.',
      color: Colors.orange,
      tag: '',
    ),
    (
      option: MaturityOption.withdrawBoth,
      icon: Icons.account_balance_wallet_outlined,
      title: 'Withdraw Everything',
      description:
          'Receive your full ₦297,500 (capital + interest) to your wallet.',
      color: Colors.blue,
      tag: '',
    ),
  ];

  Future<void> _onConfirm() async {
    if (_selected == null || _isLoading) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 2000));
    if (!mounted) return;
    setState(() => _isLoading = false);
    // Show success and navigate home
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Your maturity preference has been saved.',
          style: AppTextStyles.bodySmall.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r)),
        duration: const Duration(seconds: 3),
      ),
    );
    context.goNamed('home');
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        Scaffold(
          backgroundColor: colorScheme.surface,
          appBar: AppBar(
            backgroundColor: colorScheme.surface,
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
              'Maturity Options',
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
                  padding: REdgeInsets.fromLTRB(20, 16, 20, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Choose Your Exit Option',
                        style: AppTextStyles.headlineSmall.copyWith(
                          color: colorScheme.onBackground,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Your investment matures on December 31. Select how you\'d like to proceed.',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          height: 1.5,
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // Year-end summary
                      Container(
                        padding: REdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Your Year-End Payout',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: colorScheme.onPrimary
                                        .withValues(alpha: 0.6),
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  _fmt(297500),
                                  style: AppTextStyles.titleLarge.copyWith(
                                    color: colorScheme.onPrimary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Principal',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: colorScheme.onPrimary
                                        .withValues(alpha: 0.55),
                                  ),
                                ),
                                Text(
                                  _fmt(250000),
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: colorScheme.onPrimary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  'Interest',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: colorScheme.onPrimary
                                        .withValues(alpha: 0.55),
                                  ),
                                ),
                                Text(
                                  '+${_fmt(47500)}',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: colorScheme.primaryContainer,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 24.h),
                      Text(
                        'Select an option',
                        style: AppTextStyles.titleSmall
                            .copyWith(color: colorScheme.onSurfaceVariant),
                      ),
                      SizedBox(height: 12.h),

                      // Options
                      ..._options.map((opt) {
                        final isSelected = _selected == opt.option;
                        return Padding(
                          padding: REdgeInsets.only(bottom: 14),
                          child: GestureDetector(
                            onTap: () => setState(
                                () => _selected = opt.option),
                            child: AnimatedContainer(
                              duration:
                                  const Duration(milliseconds: 200),
                              padding: REdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? colorScheme.primary
                                        .withValues(alpha: 0.04)
                                    : colorScheme.surface,
                                borderRadius:
                                    BorderRadius.circular(14.r),
                                border: Border.all(
                                  color: isSelected
                                      ? colorScheme.primary
                                      : colorScheme.outline,
                                  width: isSelected ? 2 : 1,
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 40.r,
                                    height: 40.r,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? colorScheme.primary
                                              .withValues(alpha: 0.1)
                                          : opt.color.withValues(alpha: 0.2),
                                      borderRadius:
                                          BorderRadius.circular(10.r),
                                    ),
                                    child: Icon(
                                      opt.icon,
                                      size: 18.r,
                                      color: colorScheme.primary,
                                    ),
                                  ),
                                  SizedBox(width: 14.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                opt.title,
                                                style: AppTextStyles
                                                    .titleSmall
                                                    .copyWith(
                                                  color: colorScheme
                                                      .onSurface,
                                                  fontWeight:
                                                      FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                            if (opt.tag.isNotEmpty)
                                              Container(
                                                padding: REdgeInsets
                                                    .symmetric(
                                                        horizontal: 7,
                                                        vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: colorScheme
                                                      .primaryContainer
                                                      .withValues(alpha: 0.2),
                                                  borderRadius:
                                                      BorderRadius
                                                          .circular(4.r),
                                                ),
                                                child: Text(
                                                  opt.tag,
                                                  style: AppTextStyles
                                                      .labelSmall
                                                      .copyWith(
                                                    color: colorScheme
                                                        .primary,
                                                    fontSize: 8.sp,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                        SizedBox(height: 5.h),
                                        Text(
                                          opt.description,
                                          style: AppTextStyles
                                              .bodySmall
                                              .copyWith(
                                            color: colorScheme
                                                .onSurfaceVariant,
                                            height: 1.4,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  AnimatedContainer(
                                    duration: const Duration(
                                        milliseconds: 200),
                                    width: 20.r,
                                    height: 20.r,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isSelected
                                          ? colorScheme.primary
                                          : Colors.transparent,
                                      border: Border.all(
                                        color: isSelected
                                            ? colorScheme.primary
                                            : colorScheme.outline,
                                        width: 2,
                                      ),
                                    ),
                                    child: isSelected
                                        ? Icon(
                                            Icons.check_rounded,
                                            size: 11.r,
                                            color: colorScheme.onPrimary,
                                          )
                                        : null,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),

              Container(
                padding: REdgeInsets.fromLTRB(20, 12, 20, 32),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  border: Border(
                    top: BorderSide(color: colorScheme.outline),
                  ),
                ),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _selected != null ? 1.0 : 0.45,
                  child: GestureDetector(
                    onTap: _selected != null ? _onConfirm : null,
                    child: Container(
                      width: double.infinity,
                      height: 56.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Text(
                        'Confirm Selection',
                        style: AppTextStyles.labelLarge.copyWith(
                          color: colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        if (_isLoading)
          Container(
            color: Colors.black.withValues(alpha: 0.55),
            child: Center(
              child: Container(
                width: 200.w,
                padding: REdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 36.r,
                      height: 36.r,
                      child: CircularProgressIndicator(
                        color: colorScheme.primary,
                        strokeWidth: 3,
                      ),
                    ),
                    SizedBox(height: 14.h),
                    Text(
                      'Saving preference...',
                      style: AppTextStyles.titleSmall
                          .copyWith(color: colorScheme.onSurface),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ── Contribution History Screen ────────────────────────────────────────────────

class BeigeClubHistoryScreen extends StatelessWidget {
  static const String route = 'beige_club_history';
  const BeigeClubHistoryScreen({super.key});

  String _fmt(double v) =>
      '₦${NumberFormat('#,##0.00', 'en_US').format(v)}';

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final sub = kMockBeigeClubActive;
    final dateFormat = DateFormat('MMM d, y');

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
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
          'Contribution History',
          style: AppTextStyles.titleLarge.copyWith(
            color: colorScheme.onBackground,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.fromLTRB(20, 12, 20, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary
            Container(
              padding: REdgeInsets.all(18),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Contributed',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: colorScheme.onPrimary
                                .withValues(alpha: 0.6),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          _fmt(sub.totalContributed),
                          style: AppTextStyles.titleLarge.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Est. Total Interest',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: colorScheme.onPrimary
                              .withValues(alpha: 0.6),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '+${_fmt(sub.contributions.fold(0.0, (s, c) => s + c.projectedInterest))}',
                        style: AppTextStyles.titleSmall.copyWith(
                          color: colorScheme.primaryContainer,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),
            Text(
              'All Contributions',
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
                children: sub.contributions.asMap().entries.map((e) {
                  final c = e.value;
                  final isLast =
                      e.key == sub.contributions.length - 1;
                  return Column(
                    children: [
                      Padding(
                        padding: REdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              width: 40.r,
                              height: 40.r,
                              decoration: BoxDecoration(
                                color: colorScheme.primaryContainer
                                    .withValues(alpha: 0.15),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.check_rounded,
                                size: 18.r,
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
                                    _fmt(c.amount),
                                    style: AppTextStyles.titleSmall
                                        .copyWith(
                                      color: colorScheme.onSurface,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    dateFormat.format(c.date),
                                    style: AppTextStyles.bodySmall
                                        .copyWith(
                                      color: colorScheme.onSurface
                                          .withValues(alpha: 0.38),
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    '${c.daysToYearEnd} days to Dec 31 · Est. +${_fmt(c.projectedInterest)}',
                                    style: AppTextStyles.labelSmall
                                        .copyWith(
                                      color: colorScheme.primary
                                          .withValues(alpha: 0.7),
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: REdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: colorScheme.primaryContainer
                                    .withValues(alpha: 0.2),
                                borderRadius:
                                    BorderRadius.circular(6.r),
                              ),
                              child: Text(
                                'VERIFIED',
                                style: AppTextStyles.labelSmall
                                    .copyWith(
                                  color: colorScheme.primary,
                                  fontSize: 9.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!isLast)
                        Divider(
                          height: 1,
                          color: colorScheme.outline,
                          indent: 68.w,
                        ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}