part of '../controllers/beige_club_review_controller.dart';

class BeigeClubReviewView extends StatelessWidget
    implements BeigeClubReviewViewContract {
  const BeigeClubReviewView({super.key, required this.controller});

  final BeigeClubReviewControllerContract controller;

  String _fmt(double v) =>
      '₦${NumberFormat('#,##0.00', 'en_US').format(v)}';

  // Compute payout month from position & start month
  String _payoutMonth() {
    final startIdx =
        data.kMonths.indexOf(controller.startMonth);
    final payoutIdx =
        (startIdx + controller.positionInRotation - 1) % 12;
    final year = DateTime.now().year +
        ((startIdx + controller.positionInRotation - 1) >= 12 ? 1 : 0);
    return '${data.kMonths[payoutIdx]} $year';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
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
            title: Text('Beige Club',
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

                      Text(
                        'Review & Confirm',
                        style: AppTextStyles.headlineSmall.copyWith(
                          fontFamily: 'BWGradual',
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Review your club setup before joining.',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // ── Your position card ──────────────────────
                      Container(
                        padding: REdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.limeGreen.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(14.r),
                          border: Border.all(
                            color: AppColors.limeGreen.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 44.r, height: 44.r,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '#${controller.positionInRotation}',
                                  style: AppTextStyles.titleSmall.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 14.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'You are member #${controller.positionInRotation}',
                                    style: AppTextStyles.titleSmall
                                        .copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 3.h),
                                  Text(
                                    'Your payout month: ${_payoutMonth()}',
                                    style: AppTextStyles.bodySmall
                                        .copyWith(
                                      color: AppColors.primary
                                          .withOpacity(0.7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // ── Summary card ────────────────────────────
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          children: [
                            // Header
                            Container(
                              padding: REdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16.r),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40.r, height: 40.r,
                                    decoration: BoxDecoration(
                                      color: AppColors.white
                                          .withOpacity(0.12),
                                      borderRadius:
                                          BorderRadius.circular(10.r),
                                    ),
                                    child: Icon(
                                        Icons.people_rounded,
                                        size: 18.r,
                                        color: AppColors.limeGreen),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Beige Club',
                                          style: AppTextStyles
                                              .titleMedium
                                              .copyWith(
                                            color: AppColors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          '${data.kClubRate}% p.a. · 12-month cycle',
                                          style: AppTextStyles.bodySmall
                                              .copyWith(
                                            color: AppColors.white
                                                .withOpacity(0.65),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: REdgeInsets.all(16),
                              child: Column(
                                children: [
                                  _ReviewRow(
                                    label: 'Monthly Contribution',
                                    value: _fmt(controller.amount),
                                    isBold: true,
                                  ),
                                  _divider(),
                                  _ReviewRow(
                                    label: 'Start Month',
                                    value: controller.startMonth,
                                  ),
                                  _divider(),
                                  _ReviewRow(
                                    label: 'Contribution Mode',
                                    value: controller.contributionMode ==
                                            ContributionMode.manual
                                        ? 'Manual'
                                        : 'Auto-Debit',
                                  ),
                                  _divider(),
                                  _ReviewRow(
                                    label: 'Total Contributed (12mo)',
                                    value: _fmt(
                                        controller.totalContributed),
                                  ),
                                  _divider(),
                                  _ReviewRow(
                                    label:
                                        'Projected Interest (${data.kClubRate}%)',
                                    value: '+${_fmt(controller.projectedInterest)}',
                                    valueColor: AppColors.primary,
                                  ),
                                  _divider(),
                                  _ReviewRow(
                                    label: 'Daily Accrual',
                                    value:
                                        '${_fmt(controller.dailyAccrual)}/day',
                                    valueColor: AppColors.primary,
                                  ),
                                ],
                              ),
                            ),

                            // Year-end payout footer
                            Container(
                              padding: REdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppColors.limeGreen
                                    .withOpacity(0.12),
                                borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(16.r),
                                ),
                                border: Border(
                                  top: BorderSide(
                                      color: AppColors.divider),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Year-End Payout',
                                    style: AppTextStyles.titleSmall
                                        .copyWith(
                                      color: AppColors.textPrimary,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    _fmt(controller.yearEndPayout),
                                    style: AppTextStyles.titleMedium
                                        .copyWith(
                                      color: AppColors.primary,
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

                      // ── Features list ───────────────────────────
                      Text('What\'s Included',
                          style: AppTextStyles.titleSmall.copyWith(
                              color: AppColors.textPrimary)),
                      SizedBox(height: 12.h),

                      ...data.kClubFeatures.map((f) => Padding(
                        padding: REdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Container(
                              width: 32.r, height: 32.r,
                              decoration: BoxDecoration(
                                color: AppColors.limeGreen
                                    .withOpacity(0.2),
                                borderRadius:
                                    BorderRadius.circular(8.r),
                              ),
                              child: Icon(f.icon,
                                  size: 15.r,
                                  color: AppColors.primary),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Text(f.label,
                                  style: AppTextStyles.bodySmall
                                      .copyWith(
                                    color: AppColors.textPrimary,
                                  )),
                            ),
                          ],
                        ),
                      )),

                      SizedBox(height: 20.h),

                      // ── Terms checkbox ──────────────────────────
                      GestureDetector(
                        onTap: controller.onToggleTerms,
                        behavior: HitTestBehavior.opaque,
                        child: Row(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            AnimatedContainer(
                              duration:
                                  const Duration(milliseconds: 200),
                              width: 22.r, height: 22.r,
                              decoration: BoxDecoration(
                                color: controller.termsAccepted
                                    ? AppColors.primary
                                    : Colors.transparent,
                                borderRadius:
                                    BorderRadius.circular(6.r),
                                border: Border.all(
                                  color: controller.termsAccepted
                                      ? AppColors.primary
                                      : AppColors.buttonBorder,
                                  width: 1.5,
                                ),
                              ),
                              child: controller.termsAccepted
                                  ? Icon(Icons.check_rounded,
                                      size: 14.r,
                                      color: AppColors.white)
                                  : null,
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: AppTextStyles.bodySmall
                                      .copyWith(
                                    color: AppColors.textSecondary,
                                    height: 1.5,
                                  ),
                                  children: [
                                    const TextSpan(
                                        text:
                                            'I understand the group savings structure, the rotation order, and agree to the '),
                                    TextSpan(
                                      text: 'Beige Club Terms',
                                      style: AppTextStyles.bodySmall
                                          .copyWith(
                                        color: AppColors.primary,
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

              // ── CTA ──────────────────────────────────────────────
              Container(
                padding: REdgeInsets.fromLTRB(20, 12, 20, 32),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  border: Border(
                      top: BorderSide(color: AppColors.divider)),
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
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Text(
                        'Join Beige Club',
                        style: AppTextStyles.labelLarge
                            .copyWith(color: AppColors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Loading overlay
        if (controller.isLoading)
          Container(
            color: Colors.black.withOpacity(0.55),
            child: Center(
              child: Container(
                width: 220.w,
                padding: REdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 40.r, height: 40.r,
                      child: CircularProgressIndicator(
                        color: AppColors.primary, strokeWidth: 3),
                    ),
                    SizedBox(height: 16.h),
                    Text('Setting up your\nBeige Club...',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.titleSmall.copyWith(
                            color: AppColors.textPrimary, height: 1.4)),
                    SizedBox(height: 6.h),
                    Text('Please do not close the app',
                        style: AppTextStyles.bodySmall
                            .copyWith(color: AppColors.textDisabled)),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _divider() => Padding(
      padding: REdgeInsets.symmetric(vertical: 10),
      child: Divider(color: AppColors.divider, height: 1));
}

class _ReviewRow extends StatelessWidget {
  const _ReviewRow({
    required this.label,
    required this.value,
    this.isBold = false,
    this.valueColor,
  });
  final String label;
  final String value;
  final bool isBold;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: AppTextStyles.bodySmall
                .copyWith(color: AppColors.textSecondary)),
        Text(value,
            style: AppTextStyles.bodySmall.copyWith(
              color: valueColor ?? AppColors.textPrimary,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            )),
      ],
    );
  }
}