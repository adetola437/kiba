part of '../controllers/topup_investment_controller.dart';

class TopUpInvestmentView extends StatelessWidget
    implements TopUpInvestmentViewContract {
  const TopUpInvestmentView({super.key, required this.controller});

  final TopUpInvestmentControllerContract controller;

  String _fmt(double v) =>
      '₦${NumberFormat('#,##0.00', 'en_US').format(v)}';

  String _fmtShort(double v) {
    if (v >= 1000000) return '₦${(v / 1000000).toStringAsFixed(0)}M';
    if (v >= 1000) return '₦${(v / 1000).toStringAsFixed(0)}K';
    return '₦${v.toStringAsFixed(0)}';
  }

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
          onTap: controller.onBack,
          child: Icon(
            Icons.arrow_back_rounded,
            size: 22.r,
            color: colorScheme.onBackground,
          ),
        ),
        title: Text(
          'Top Up Investment',
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
                  // ── Current investment summary ─────────────────
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              controller.productName,
                              style: AppTextStyles.titleSmall.copyWith(
                                color: colorScheme.onPrimary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              padding: REdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: colorScheme.primaryContainer
                                    .withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Text(
                                'ACTIVE',
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: colorScheme.primaryContainer,
                                  letterSpacing: 0.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 14.h),
                        // Stats row
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              _TopUpStat(
                                label: 'CURRENT VALUE',
                                value: _fmt(controller.currentValue),
                                valueColor: colorScheme.onPrimary,
                              ),
                              VerticalDivider(
                                color: colorScheme.onPrimary
                                    .withValues(alpha: 0.15),
                                width: 1,
                                thickness: 1,
                              ),
                              _TopUpStat(
                                label: 'ANNUAL RATE',
                                value: '+${controller.annualRate}%',
                                valueColor: colorScheme.primaryContainer,
                              ),
                              VerticalDivider(
                                color: colorScheme.onPrimary
                                    .withValues(alpha: 0.15),
                                width: 1,
                                thickness: 1,
                              ),
                              _TopUpStat(
                                label: 'DAYS LEFT',
                                value: '${controller.daysRemaining}d',
                                valueColor: colorScheme.onPrimary,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              size: 11.r,
                              color: colorScheme.onPrimary
                                  .withValues(alpha: 0.5),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              'Matures ${DateFormat('MMM d, y').format(controller.maturityDate)}',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: colorScheme.onPrimary
                                    .withValues(alpha: 0.55),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // ── Amount input ───────────────────────────────
                  Text(
                    'Add Amount',
                    style: AppTextStyles.headlineSmall.copyWith(
                      color: colorScheme.onBackground,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Minimum top up is ₦10,000.',
                    style: AppTextStyles.bodySmall
                        .copyWith(color: colorScheme.onSurfaceVariant),
                  ),

                  SizedBox(height: 14.h),

                  Container(
                    padding: REdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(
                        color: controller.topUpAmount > 0
                            ? colorScheme.primary.withValues(alpha: 0.35)
                            : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ENTER AMOUNT',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: colorScheme.onSurface
                                .withValues(alpha: 0.38),
                            letterSpacing: 0.8,
                            fontSize: 9.sp,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '₦',
                              style: AppTextStyles.displaySmall.copyWith(
                                color: colorScheme.onSurface,
                                fontWeight: FontWeight.w300,
                                fontSize: 28.sp,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: TextField(
                                controller: controller.amountController,
                                onChanged: controller.onAmountChanged,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                style: AppTextStyles.displaySmall.copyWith(
                                  color: colorScheme.onSurface,
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                  hintText: '0',
                                  hintStyle: AppTextStyles.displaySmall
                                      .copyWith(
                                    color: colorScheme.onSurface
                                        .withValues(alpha: 0.38),
                                    fontSize: 28.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Icon(
                                Icons.account_balance_wallet_outlined,
                                size: 12.r,
                                color: colorScheme.onSurface
                                    .withValues(alpha: 0.38),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                'Wallet Balance',
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: colorScheme.onSurface
                                      .withValues(alpha: 0.38),
                                ),
                              ),
                            ]),
                            Text(
                              _fmt(controller.walletBalance),
                              style: AppTextStyles.bodySmall.copyWith(
                                color: colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Error states
                  if (controller.topUpAmount > controller.walletBalance) ...[
                    SizedBox(height: 8.h),
                    _errorRow(
                      colorScheme,
                      'Insufficient wallet balance.',
                      actionLabel: 'Fund Wallet →',
                      onAction: () => context.pushNamed('fund_wallet'),
                    ),
                  ] else if (controller.topUpAmount > 0 &&
                      controller.topUpAmount < 10000) ...[
                    SizedBox(height: 8.h),
                    _errorRow(colorScheme, 'Minimum top up amount is ₦10,000.'),
                  ],

                  SizedBox(height: 14.h),

                  // Quick amount chips
                  Row(
                    children: _kTopUpQuickAmounts.asMap().entries.map((e) {
                      final amount = e.value;
                      final isSelected = controller.topUpAmount == amount;
                      final isLast = e.key == _kTopUpQuickAmounts.length - 1;
                      return Expanded(
                        child: Padding(
                          padding: REdgeInsets.only(
                              right: isLast ? 0 : 8.w),
                          child: GestureDetector(
                            onTap: () => controller.onQuickAmount(amount),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              height: 34.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? colorScheme.primary
                                        .withValues(alpha: 0.08)
                                    : colorScheme.surfaceVariant,
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  color: isSelected
                                      ? colorScheme.primary
                                      : Colors.transparent,
                                  width: 1.5,
                                ),
                              ),
                              child: Text(
                                _fmtShort(amount),
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: isSelected
                                      ? colorScheme.primary
                                      : colorScheme.onSurfaceVariant,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  SizedBox(height: 24.h),

                  // ── Live projection card ───────────────────────
                  Container(
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: REdgeInsets.fromLTRB(18, 16, 18, 14),
                          child: Row(
                            children: [
                              Icon(
                                Icons.bar_chart_rounded,
                                size: 18.r,
                                color: colorScheme.primaryContainer,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Updated Projections',
                                style: AppTextStyles.titleSmall.copyWith(
                                  color: colorScheme.onPrimary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: colorScheme.onPrimary
                              .withValues(alpha: 0.1),
                          height: 1,
                        ),
                        Padding(
                          padding: REdgeInsets.all(18),
                          child: Column(
                            children: [
                              _ProjRow(
                                label: 'Current Principal',
                                value: _fmt(controller.currentPrincipal),
                              ),
                              SizedBox(height: 10.h),
                              _ProjRow(
                                label: 'Top Up Amount',
                                value: '+ ${_fmt(controller.topUpAmount)}',
                                valueColor: colorScheme.primaryContainer,
                              ),
                              SizedBox(height: 10.h),
                              _ProjRow(
                                label: 'New Principal',
                                value: _fmt(controller.revisedPrincipal),
                                valueColor: colorScheme.onPrimary,
                                isBold: true,
                              ),
                              SizedBox(height: 10.h),
                              _ProjRow(
                                label:
                                    'Additional Interest (${controller.daysRemaining}d)',
                                value:
                                    '+${_fmt(controller.additionalInterest)}',
                                valueColor: colorScheme.primaryContainer,
                              ),
                              SizedBox(height: 14.h),
                              Divider(
                                color: colorScheme.onPrimary
                                    .withValues(alpha: 0.15),
                                height: 1,
                              ),
                              SizedBox(height: 14.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Revised Total at Maturity',
                                    style: AppTextStyles.titleSmall.copyWith(
                                      color: colorScheme.onPrimary,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    _fmt(controller.revisedTotalAtMaturity),
                                    style: AppTextStyles.titleMedium.copyWith(
                                      color: colorScheme.onPrimary,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              _ProjRow(
                                label: 'Maturity Date',
                                value: DateFormat('MMM d, y')
                                    .format(controller.maturityDate),
                                icon: Icons.calendar_today_outlined,
                              ),
                              SizedBox(height: 6.h),
                              // Note about days remaining
                              Container(
                                padding: REdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: colorScheme.onPrimary
                                      .withValues(alpha: 0.06),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.info_outline_rounded,
                                      size: 12.r,
                                      color: colorScheme.onPrimary
                                          .withValues(alpha: 0.5),
                                    ),
                                    SizedBox(width: 6.w),
                                    Expanded(
                                      child: Text(
                                        'Interest on the top up is calculated on the ${controller.daysRemaining} days remaining until maturity.',
                                        style: AppTextStyles.bodySmall.copyWith(
                                          color: colorScheme.onPrimary
                                              .withValues(alpha: 0.55),
                                          fontSize: 10.sp,
                                          height: 1.4,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
              border: Border(
                top: BorderSide(color: colorScheme.outline),
              ),
            ),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: controller.canProceed ? 1.0 : 0.45,
              child: GestureDetector(
                onTap: controller.canProceed ? controller.onProceed : null,
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
                      Text(
                        'Review Top Up',
                        style: AppTextStyles.labelLarge.copyWith(
                          color: colorScheme.onPrimary,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 18.r,
                        color: colorScheme.onPrimary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _errorRow(
    ColorScheme colorScheme,
    String message, {
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    return Row(
      children: [
        Icon(
          Icons.warning_amber_rounded,
          size: 13.r,
          color: colorScheme.error,
        ),
        SizedBox(width: 4.w),
        Text(
          message,
          style: AppTextStyles.bodySmall.copyWith(color: colorScheme.error),
        ),
        if (actionLabel != null && onAction != null) ...[
          SizedBox(width: 4.w),
          GestureDetector(
            onTap: onAction,
            child: Text(
              actionLabel,
              style: AppTextStyles.bodySmall.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

// ── Shared widgets ─────────────────────────────────────────────────────────────

class _TopUpStat extends StatelessWidget {
  const _TopUpStat({
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

class _ProjRow extends StatelessWidget {
  const _ProjRow({
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
            color: colorScheme.onPrimary.withValues(alpha: 0.55),
          ),
        ),
        Row(
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 11.r,
                color: colorScheme.onPrimary.withValues(alpha: 0.5),
              ),
              SizedBox(width: 4.w),
            ],
            Text(
              value,
              style: AppTextStyles.bodySmall.copyWith(
                color: valueColor ?? colorScheme.onPrimary.withValues(alpha: 0.85),
                fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}