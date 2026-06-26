part of '../controllers/investment_details_controller.dart';

class InvestmentDetailActiveView extends StatelessWidget
    implements InvestmentDetailViewContract {
  const InvestmentDetailActiveView({super.key, required this.controller});

  final InvestmentDetailControllerContract controller;

  String _fmt(double v) =>
      '₦${NumberFormat('#,##0.00', 'en_US').format(v)}';

  String _mask(String v) =>
      controller.balanceVisible ? v : '••••••••';

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final inv = controller.activeInvestment!;
    final dateFormat = DateFormat('d MMM y');
    final isMatured = controller.isMatured;
    final isNear = controller.isNearMaturity;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: colorScheme.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: controller.onBack,
          child: Icon(
            Icons.arrow_back_rounded,
            size: 22.r,
            color: colorScheme.onBackground,
          ),
        ),
        title: Text(
          controller.product.name,
          style: AppTextStyles.titleLarge.copyWith(
            color: colorScheme.onBackground,
          ),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: controller.onContactSupport,
            child: Padding(
              padding: REdgeInsets.only(right: 16),
              child: Icon(
                Icons.headset_mic_outlined,
                size: 20.r,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.fromLTRB(20, 8, 20, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Maturity notice banner ────────────────────────────
            if (isMatured || isNear) ...[
              Container(
                padding: REdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: isMatured
                      ? colorScheme.primaryContainer.withValues(alpha: 0.15)
                      : colorScheme.secondary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: isMatured
                        ? colorScheme.primaryContainer.withValues(alpha: 0.3)
                        : colorScheme.secondary.withValues(alpha: 0.4),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      isMatured
                          ? Icons.check_circle_outline_rounded
                          : Icons.timer_outlined,
                      size: 16.r,
                      color: isMatured
                          ? colorScheme.primary
                          : colorScheme.onSecondary,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        isMatured
                            ? 'Your investment has matured! Choose to roll over or withdraw.'
                            : 'Matures in ${inv.daysRemaining} days on ${dateFormat.format(inv.maturityDate)}.',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: isMatured
                              ? colorScheme.primary
                              : colorScheme.onSecondary,
                          fontWeight: FontWeight.w500,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14.h),
            ],

            // ── Hero value card ───────────────────────────────────
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
                      width: 120.r,
                      height: 120.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorScheme.onPrimary.withValues(alpha: 0.04),
                      ),
                    ),
                  ),
                  Padding(
                    padding: REdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${controller.product.name} PLAN',
                              style: AppTextStyles.labelSmall.copyWith(
                                color: colorScheme.onPrimary.withValues(alpha: 0.55),
                                letterSpacing: 0.8,
                                fontSize: 9.sp,
                              ),
                            ),
                            GestureDetector(
                              onTap: controller.onToggleBalance,
                              child: Icon(
                                controller.balanceVisible
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                size: 18.r,
                                color: colorScheme.onPrimary.withValues(alpha: 0.55),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          child: Text(
                            _mask(_fmt(inv.currentValue)),
                            key: ValueKey(controller.balanceVisible),
                            style: TextStyle(
                              fontFamily: 'EuclidCircularA',
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w700,
                              color: colorScheme.onPrimary,
                              letterSpacing: -0.5,
                            ),
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
                              _mask('+${_fmt(inv.accruedInterest)}'),
                              style: AppTextStyles.bodySmall.copyWith(
                                color: colorScheme.primaryContainer,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              '(Accrued)',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: colorScheme.primaryContainer.withValues(alpha: 0.7),
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

            SizedBox(height: 16.h),

            // ── Maturity progress ─────────────────────────────────
            Container(
              padding: REdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: colorScheme.outline),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'MATURITY PROGRESS',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: colorScheme.onSurface.withValues(alpha: 0.38),
                          letterSpacing: 0.8,
                          fontSize: 9.sp,
                        ),
                      ),
                      Text(
                        '${(inv.progressPercent * 100).toInt()}%',
                        style: AppTextStyles.titleSmall.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.r),
                    child: LinearProgressIndicator(
                      value: inv.progressPercent,
                      minHeight: 8.h,
                      backgroundColor: colorScheme.surfaceVariant,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isMatured
                            ? colorScheme.primaryContainer
                            : colorScheme.primary,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isMatured
                            ? 'Matured on ${dateFormat.format(inv.maturityDate)}'
                            : '${inv.daysRemaining} days remaining until completion',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        dateFormat.format(inv.maturityDate),
                        style: AppTextStyles.bodySmall.copyWith(
                          color: colorScheme.onSurface.withValues(alpha: 0.38),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 14.h),

            // ── Stats grid ────────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: _StatBox(
                    label: 'PRINCIPAL',
                    value: _mask(_fmt(inv.principal)),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: _StatBox(
                    label: 'ANNUAL RATE',
                    value: '${inv.annualRate}%',
                    valueColor: colorScheme.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(
                  child: _StatBox(
                    label: 'TENOR',
                    value: '${inv.tenorDays} Days',
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: _StatBox(
                    label: 'MATURITY DATE',
                    value: dateFormat.format(inv.maturityDate),
                  ),
                ),
              ],
            ),

            SizedBox(height: 28.h),

            // ── Recent transactions ───────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Transactions',
                  style: AppTextStyles.titleLarge.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                GestureDetector(
                  onTap: controller.onSeeAllTransactions,
                  child: Text(
                    'See All',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: colorScheme.primary,
                    ),
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
                children: inv.recentTransactions
                    .asMap()
                    .entries
                    .map((e) => _TxRow(
                          tx: e.value,
                          isLast: e.key == inv.recentTransactions.length - 1,
                        ))
                    .toList(),
              ),
            ),

            SizedBox(height: 28.h),

            // ── Actions ───────────────────────────────────────────
            if (!isMatured && !isNear) ...[
              GestureDetector(
                onTap: controller.onTopUp,
                child: Container(
                  width: double.infinity,
                  height: 56.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_rounded,
                        size: 18.r,
                        color: colorScheme.onPrimary,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'Top Up Investment',
                        style: AppTextStyles.labelLarge.copyWith(
                          color: colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ] else ...[
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: controller.onRollOver,
                      child: Container(
                        height: 56.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: Text(
                          'Roll Over',
                          style: AppTextStyles.labelLarge.copyWith(
                            color: colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: controller.onWithdraw,
                      child: Container(
                        height: 56.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(14.r),
                          border: Border.all(
                            color: colorScheme.primary,
                            width: 1.5,
                          ),
                        ),
                        child: Text(
                          'Withdraw',
                          style: AppTextStyles.labelLarge.copyWith(
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],

            // Need help link
            SizedBox(height: 16.h),
            Center(
              child: GestureDetector(
                onTap: controller.onContactSupport,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.headset_mic_outlined,
                      size: 14.r,
                      color: colorScheme.onSurface.withValues(alpha: 0.38),
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      'Need help with this investment?',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.38),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}