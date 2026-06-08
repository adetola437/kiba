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
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: controller.onBack,
          child: Icon(Icons.arrow_back_rounded,
              size: 22.r, color: AppColors.textPrimary),
        ),
        title: Text('Top Up Investment',
            style: AppTextStyles.titleLarge
                .copyWith(color: AppColors.textPrimary)),
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
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              controller.productName,
                              style: AppTextStyles.titleSmall.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              padding: REdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.limeGreen
                                    .withOpacity(0.2),
                                borderRadius:
                                    BorderRadius.circular(20.r),
                              ),
                              child: Text('ACTIVE',
                                  style: AppTextStyles.labelSmall
                                      .copyWith(
                                    color: AppColors.limeGreen,
                                    letterSpacing: 0.4,
                                  )),
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
                                valueColor: AppColors.white,
                              ),
                              VerticalDivider(
                                color: AppColors.white.withOpacity(0.15),
                                width: 1, thickness: 1,
                              ),
                              _TopUpStat(
                                label: 'ANNUAL RATE',
                                value:
                                    '+${controller.annualRate}%',
                                valueColor: AppColors.limeGreen,
                              ),
                              VerticalDivider(
                                color: AppColors.white.withOpacity(0.15),
                                width: 1, thickness: 1,
                              ),
                              _TopUpStat(
                                label: 'DAYS LEFT',
                                value:
                                    '${controller.daysRemaining}d',
                                valueColor: AppColors.white,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Icon(Icons.calendar_today_outlined,
                                size: 11.r,
                                color: AppColors.white.withOpacity(0.5)),
                            SizedBox(width: 4.w),
                            Text(
                              'Matures ${DateFormat('MMM d, y').format(controller.maturityDate)}',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.white.withOpacity(0.55),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // ── Amount input ───────────────────────────────
                  Text('Add Amount',
                      style: AppTextStyles.headlineSmall.copyWith(
                        fontFamily: 'BWGradual',
                        color: AppColors.textPrimary,
                      )),
                  SizedBox(height: 4.h),
                  Text(
                    'Minimum top up is ₦10,000.',
                    style: AppTextStyles.bodySmall
                        .copyWith(color: AppColors.textSecondary),
                  ),

                  SizedBox(height: 14.h),

                  Container(
                    padding: REdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(
                        color: controller.topUpAmount > 0
                            ? AppColors.primary.withOpacity(0.35)
                            : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ENTER AMOUNT',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.textDisabled,
                              letterSpacing: 0.8,
                              fontSize: 9.sp,
                            )),
                        SizedBox(height: 6.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('₦',
                                style: AppTextStyles.displaySmall
                                    .copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 28.sp,
                                )),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: TextField(
                                controller: controller.amountController,
                                onChanged: controller.onAmountChanged,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                style: AppTextStyles.displaySmall
                                    .copyWith(
                                  color: AppColors.textPrimary,
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                  hintText: '0',
                                  hintStyle: AppTextStyles.displaySmall
                                      .copyWith(
                                    color: AppColors.textDisabled,
                                    fontSize: 28.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Icon(
                                  Icons.account_balance_wallet_outlined,
                                  size: 12.r,
                                  color: AppColors.textDisabled),
                              SizedBox(width: 4.w),
                              Text('Wallet Balance',
                                  style: AppTextStyles.bodySmall
                                      .copyWith(
                                          color: AppColors.textDisabled)),
                            ]),
                            Text(
                              _fmt(controller.walletBalance),
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textSecondary,
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
                        'Insufficient wallet balance.',
                        actionLabel: 'Fund Wallet →',
                        onAction: () => context.pushNamed('fund_wallet')),
                  ] else if (controller.topUpAmount > 0 &&
                      controller.topUpAmount < 10000) ...[
                    SizedBox(height: 8.h),
                    _errorRow('Minimum top up amount is ₦10,000.'),
                  ],

                  SizedBox(height: 14.h),

                  // Quick amount chips
                  Row(
                    children:
                        _kTopUpQuickAmounts.asMap().entries.map((e) {
                      final amount = e.value;
                      final isSelected =
                          controller.topUpAmount == amount;
                      final isLast =
                          e.key == _kTopUpQuickAmounts.length - 1;
                      return Expanded(
                        child: Padding(
                          padding: REdgeInsets.only(
                              right: isLast ? 0 : 8.w),
                          child: GestureDetector(
                            onTap: () =>
                                controller.onQuickAmount(amount),
                            child: AnimatedContainer(
                              duration:
                                  const Duration(milliseconds: 200),
                              height: 34.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary.withOpacity(0.08)
                                    : AppColors.surfaceVariant,
                                borderRadius:
                                    BorderRadius.circular(8.r),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primary
                                      : Colors.transparent,
                                  width: 1.5,
                                ),
                              ),
                              child: Text(
                                _fmtShort(amount),
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.textSecondary,
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
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              REdgeInsets.fromLTRB(18, 16, 18, 14),
                          child: Row(
                            children: [
                              Icon(Icons.bar_chart_rounded,
                                  size: 18.r,
                                  color: AppColors.limeGreen),
                              SizedBox(width: 8.w),
                              Text('Updated Projections',
                                  style: AppTextStyles.titleSmall
                                      .copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w700,
                                  )),
                            ],
                          ),
                        ),
                        Divider(
                            color: AppColors.white.withOpacity(0.1),
                            height: 1),
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
                                value:
                                    '+ ${_fmt(controller.topUpAmount)}',
                                valueColor: AppColors.limeGreen,
                              ),
                              SizedBox(height: 10.h),
                              _ProjRow(
                                label: 'New Principal',
                                value: _fmt(
                                    controller.revisedPrincipal),
                                valueColor: AppColors.white,
                                isBold: true,
                              ),
                              SizedBox(height: 10.h),
                              _ProjRow(
                                label:
                                    'Additional Interest (${controller.daysRemaining}d)',
                                value:
                                    '+${_fmt(controller.additionalInterest)}',
                                valueColor: AppColors.limeGreen,
                              ),
                              SizedBox(height: 14.h),
                              Divider(
                                  color:
                                      AppColors.white.withOpacity(0.15),
                                  height: 1),
                              SizedBox(height: 14.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Revised Total at Maturity',
                                      style: AppTextStyles.titleSmall
                                          .copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w700,
                                      )),
                                  Text(
                                    _fmt(controller
                                        .revisedTotalAtMaturity),
                                    style: AppTextStyles.titleMedium
                                        .copyWith(
                                      color: AppColors.white,
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
                                  color:
                                      AppColors.white.withOpacity(0.06),
                                  borderRadius:
                                      BorderRadius.circular(8.r),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.info_outline_rounded,
                                        size: 12.r,
                                        color: AppColors.white
                                            .withOpacity(0.5)),
                                    SizedBox(width: 6.w),
                                    Expanded(
                                      child: Text(
                                        'Interest on the top up is calculated on the ${controller.daysRemaining} days remaining until maturity.',
                                        style: AppTextStyles.bodySmall
                                            .copyWith(
                                          color: AppColors.white
                                              .withOpacity(0.55),
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
              color: AppColors.background,
              border:
                  Border(top: BorderSide(color: AppColors.divider)),
            ),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: controller.canProceed ? 1.0 : 0.45,
              child: GestureDetector(
                onTap:
                    controller.canProceed ? controller.onProceed : null,
                child: Container(
                  width: double.infinity,
                  height: 56.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Review Top Up',
                          style: AppTextStyles.labelLarge
                              .copyWith(color: AppColors.white)),
                      SizedBox(width: 6.w),
                      Icon(Icons.arrow_forward_rounded,
                          size: 18.r, color: AppColors.white),
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

  Widget _errorRow(String message,
      {String? actionLabel, VoidCallback? onAction}) {
    return Row(
      children: [
        Icon(Icons.warning_amber_rounded,
            size: 13.r, color: Colors.red),
        SizedBox(width: 4.w),
        Text(message,
            style:
                AppTextStyles.bodySmall.copyWith(color: Colors.red)),
        if (actionLabel != null && onAction != null) ...[
          SizedBox(width: 4.w),
          GestureDetector(
            onTap: onAction,
            child: Text(actionLabel,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                )),
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
    return Expanded(
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.white.withOpacity(0.5),
                  fontSize: 8.sp,
                  letterSpacing: 0.6,
                )),
            SizedBox(height: 3.h),
            Text(value,
                style: AppTextStyles.bodySmall.copyWith(
                  color: valueColor ?? AppColors.white,
                  fontWeight: FontWeight.w600,
                )),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: AppTextStyles.bodySmall
                .copyWith(color: AppColors.white.withOpacity(0.55))),
        Row(
          children: [
            if (icon != null) ...[
              Icon(icon, size: 11.r,
                  color: AppColors.white.withOpacity(0.5)),
              SizedBox(width: 4.w),
            ],
            Text(value,
                style: AppTextStyles.bodySmall.copyWith(
                  color:
                      valueColor ?? AppColors.white.withOpacity(0.85),
                  fontWeight:
                      isBold ? FontWeight.w700 : FontWeight.w500,
                )),
          ],
        ),
      ],
    );
  }
}