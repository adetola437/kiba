part of '../controllers/confirm_investment_controller.dart';

class ConfirmInvestmentView extends StatelessWidget
    implements ConfirmInvestmentViewContract {
  const ConfirmInvestmentView({super.key, required this.controller});

  final ConfirmInvestmentControllerContract controller;

  String _fmt(double v) =>
      '₦${NumberFormat('#,##0.00', 'en_US').format(v)}';

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final dateFormat = DateFormat('MMM d, y');

    return Stack(
      children: [
        Scaffold(
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
              'New Investment',
              style: AppTextStyles.titleLarge.copyWith(
                color: colorScheme.onBackground,
              ),
            ),
            centerTitle: true,
          ),

          body: Column(
            children: [
              // Step indicator
              Padding(
                padding: REdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 3.h,
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Container(
                        height: 3.h,
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4.h),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: REdgeInsets.only(right: 20),
                  child: Text(
                    'Step 2 of 2',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: colorScheme.onBackground.withValues(alpha: 0.38),
                    ),
                  ),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: REdgeInsets.fromLTRB(20, 20, 20, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Review & Confirm',
                        style: AppTextStyles.headlineSmall.copyWith(
                          color: colorScheme.onBackground,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Please review your investment details before confirming.',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          height: 1.5,
                        ),
                      ),

                      SizedBox(height: 24.h),

                      // ── Investment summary card ─────────────────────
                      Container(
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(color: colorScheme.outline),
                        ),
                        child: Column(
                          children: [
                            // Product header
                            Container(
                              padding: REdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: colorScheme.primary,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16.r),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40.r,
                                    height: 40.r,
                                    decoration: BoxDecoration(
                                      color: colorScheme.onPrimary
                                          .withValues(alpha: 0.12),
                                      borderRadius:
                                          BorderRadius.circular(10.r),
                                    ),
                                    child: Icon(
                                      Icons.trending_up_rounded,
                                      size: 18.r,
                                      color: colorScheme.primaryContainer,
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.productName,
                                          style: AppTextStyles.titleMedium
                                              .copyWith(
                                            color: colorScheme.onPrimary,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          '${controller.tenorDays}-day tenor · ${controller.annualRate}% p.a.',
                                          style: AppTextStyles.bodySmall
                                              .copyWith(
                                            color: colorScheme.onPrimary
                                                .withValues(alpha: 0.65),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Summary rows
                            Padding(
                              padding: REdgeInsets.all(16),
                              child: Column(
                                children: [
                                  _SummaryRow(
                                    label: 'Investment Amount',
                                    value: _fmt(controller.amount),
                                    isBold: true,
                                  ),
                                  _divider(colorScheme),
                                  _SummaryRow(
                                    label: 'Tenor',
                                    value: '${controller.tenorDays} Days',
                                  ),
                                  _divider(colorScheme),
                                  _SummaryRow(
                                    label: 'Annual Rate',
                                    value: '+${controller.annualRate}%',
                                    valueColor: colorScheme.primary,
                                  ),
                                  _divider(colorScheme),
                                  _SummaryRow(
                                    label: 'Projected Interest',
                                    value: _fmt(
                                        controller.projectedInterest),
                                    valueColor: colorScheme.primary,
                                  ),
                                  _divider(colorScheme),
                                  _SummaryRow(
                                    label: 'Maturity Date',
                                    value: dateFormat
                                        .format(controller.maturityDate),
                                    icon: Icons.calendar_today_outlined,
                                  ),
                                ],
                              ),
                            ),

                            // Total at maturity — highlighted footer
                            Container(
                              padding: REdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: colorScheme.primaryContainer
                                    .withValues(alpha: 0.12),
                                borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(16.r),
                                ),
                                border: Border(
                                  top: BorderSide(
                                      color: colorScheme.outline),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total at Maturity',
                                    style: AppTextStyles.titleSmall
                                        .copyWith(
                                      color: colorScheme.onSurface,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    _fmt(controller.totalAtMaturity),
                                    style: AppTextStyles.titleMedium
                                        .copyWith(
                                      color: colorScheme.primary,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // ── Wallet deduction notice ────────────────────
                      Container(
                        padding: REdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: colorScheme.secondaryContainer
                              .withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: colorScheme.tertiary
                                .withValues(alpha: 0.15),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.account_balance_wallet_outlined,
                              size: 16.r,
                              color: colorScheme.tertiary,
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: AppTextStyles.bodySmall
                                      .copyWith(
                                    color: colorScheme.tertiary,
                                    height: 1.5,
                                  ),
                                  children: [
                                    const TextSpan(
                                        text: 'By confirming, '),
                                    TextSpan(
                                      text: _fmt(controller.amount),
                                      style: AppTextStyles.bodySmall
                                          .copyWith(
                                        color: colorScheme.tertiary,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const TextSpan(
                                        text:
                                            ' will be deducted from your wallet balance.'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // ── Terms checkbox ─────────────────────────────
                      GestureDetector(
                        onTap: controller.onToggleTerms,
                        behavior: HitTestBehavior.opaque,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 22.r,
                              height: 22.r,
                              decoration: BoxDecoration(
                                color: controller.termsAccepted
                                    ? colorScheme.primary
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(6.r),
                                border: Border.all(
                                  color: controller.termsAccepted
                                      ? colorScheme.primary
                                      : colorScheme.outline,
                                  width: 1.5,
                                ),
                              ),
                              child: controller.termsAccepted
                                  ? Icon(
                                      Icons.check_rounded,
                                      size: 14.r,
                                      color: colorScheme.onPrimary,
                                    )
                                  : null,
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: AppTextStyles.bodySmall
                                      .copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                    height: 1.5,
                                  ),
                                  children: [
                                    const TextSpan(
                                        text:
                                            'I understand that this investment is '),
                                    TextSpan(
                                      text:
                                          'non-withdrawable before maturity',
                                      style: AppTextStyles.bodySmall
                                          .copyWith(
                                        color: colorScheme.onSurface,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const TextSpan(
                                        text:
                                            ' and I agree to the '),
                                    TextSpan(
                                      text: 'Terms & Conditions',
                                      style: AppTextStyles.bodySmall
                                          .copyWith(
                                        color: colorScheme.primary,
                                        fontWeight: FontWeight.w600,
                                        decoration:
                                            TextDecoration.underline,
                                      ),
                                    ),
                                    const TextSpan(text: '.'),
                                  ],
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

              // ── Bottom CTA ─────────────────────────────────────────
              Container(
                padding: REdgeInsets.fromLTRB(20, 12, 20, 32),
                decoration: BoxDecoration(
                  color: colorScheme.background,
                  border:
                      Border(top: BorderSide(color: colorScheme.outline)),
                ),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: controller.termsAccepted ? 1.0 : 0.45,
                  child: GestureDetector(
                    onTap: controller.termsAccepted
                        ? controller.onConfirm
                        : null,
                    child: Container(
                      width: double.infinity,
                      height: 56.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Text(
                        'Confirm Investment',
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

        // ── Full-screen loading overlay ────────────────────────────────
        if (controller.isLoading)
          Container(
            color: Colors.black.withValues(alpha: 0.55),
            child: Center(
              child: Container(
                width: 220.w,
                padding: REdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 40.r,
                      height: 40.r,
                      child: CircularProgressIndicator(
                        color: colorScheme.primary,
                        strokeWidth: 3,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Processing your\ninvestment...',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.titleSmall.copyWith(
                        color: colorScheme.onSurface,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Please do not close the app',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.38),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _divider(ColorScheme colorScheme) => Padding(
        padding: REdgeInsets.symmetric(vertical: 10),
        child: Divider(color: colorScheme.outline, height: 1),
      );
}

// ── Summary row ────────────────────────────────────────────────────────────────
class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.isBold = false,
    this.valueColor,
    this.icon,
  });

  final String label;
  final String value;
  final bool isBold;
  final Color? valueColor;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        Row(
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 12.r,
                color: colorScheme.onSurface.withValues(alpha: 0.38),
              ),
              SizedBox(width: 4.w),
            ],
            Text(
              value,
              style: AppTextStyles.bodyMedium.copyWith(
                color: valueColor ?? colorScheme.onSurface,
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