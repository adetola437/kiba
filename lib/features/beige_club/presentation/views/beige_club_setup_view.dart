part of '../controllers/beige_club_setup_controller.dart';

class BeigeClubSetupView extends StatelessWidget
    implements BeigeClubSetupViewContract {
  const BeigeClubSetupView({super.key, required this.controller});

  final BeigeClubSetupControllerContract controller;

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
        title: Text('Set Up Your Club',
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

                  // ── Monthly Contribution ──────────────────────────
                  Text('Monthly Contribution',
                      style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.textSecondary,
                          letterSpacing: 0.4)),
                  SizedBox(height: 10.h),

                  // Big amount display
                  Text(
                    _fmt(controller.selectedAmount),
                    style: AppTextStyles.displaySmall.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  SizedBox(height: 14.h),

                  // Amount chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: data.kContributionOptions.map((amount) {
                        final isSelected =
                            controller.selectedAmount == amount;
                        return Padding(
                          padding: REdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: () =>
                                controller.onAmountSelected(amount),
                            child: AnimatedContainer(
                              duration:
                                  const Duration(milliseconds: 200),
                              padding: REdgeInsets.symmetric(
                                  horizontal: 16, vertical: 9),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary
                                    : Colors.transparent,
                                borderRadius:
                                    BorderRadius.circular(20.r),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.buttonBorder,
                                  width: 1.5,
                                ),
                              ),
                              child: Text(
                                _fmtShort(amount),
                                style: AppTextStyles.labelMedium
                                    .copyWith(
                                  color: isSelected
                                      ? AppColors.white
                                      : AppColors.textSecondary,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // ── Start Month ───────────────────────────────────
                  Text('Start Month',
                      style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.textSecondary,
                          letterSpacing: 0.4)),
                  SizedBox(height: 10.h),

                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: data.kMonths.map((month) {
                      final isSelected =
                          controller.selectedMonth == month;
                      return GestureDetector(
                        onTap: () =>
                            controller.onMonthSelected(month),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: REdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary
                                : Colors.transparent,
                            borderRadius:
                                BorderRadius.circular(20.r),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.buttonBorder,
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            month,
                            style: AppTextStyles.labelMedium.copyWith(
                              color: isSelected
                                  ? AppColors.white
                                  : AppColors.textSecondary,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  SizedBox(height: 24.h),

                  // ── Contribution Mode ─────────────────────────────
                  Text('Contribution Mode',
                      style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.textSecondary,
                          letterSpacing: 0.4)),
                  SizedBox(height: 10.h),

                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: REdgeInsets.all(4),
                    child: Row(
                      children: [
                        _ModeTab(
                          label: 'Manual',
                          isSelected: controller.contributionMode ==
                              ContributionMode.manual,
                          onTap: () => controller
                              .onModeChanged(ContributionMode.manual),
                        ),
                        _ModeTab(
                          label: 'Auto-Debit',
                          isSelected: controller.contributionMode ==
                              ContributionMode.autoDebit,
                          onTap: () => controller.onModeChanged(
                              ContributionMode.autoDebit),
                        ),
                      ],
                    ),
                  ),

                  if (controller.contributionMode ==
                      ContributionMode.autoDebit) ...[
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Icon(Icons.info_outline_rounded,
                            size: 13.r,
                            color: AppColors.textDisabled),
                        SizedBox(width: 5.w),
                        Expanded(
                          child: Text(
                            'Auto-Debit will charge your wallet on the 1st of each month.',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textDisabled,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],

                  SizedBox(height: 24.h),

                  // ── Projected Year-End Value ──────────────────────
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: REdgeInsets.fromLTRB(18, 16, 18, 14),
                          child: Row(
                            children: [
                              Icon(Icons.bar_chart_rounded,
                                  size: 18.r,
                                  color: AppColors.limeGreen),
                              SizedBox(width: 8.w),
                              Text(
                                'Projected Year-End Value',
                                style: AppTextStyles.titleSmall
                                    .copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
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
                              _ProjectionRow(
                                label: 'Total Contributed',
                                value: _fmt(
                                    controller.totalContributed),
                              ),
                              SizedBox(height: 10.h),
                              _ProjectionRow(
                                label:
                                    'Interest (${data.kClubRate}% p.a.)',
                                value: '+${_fmt(controller.projectedInterest)}',
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
                                  Text(
                                    'Year-End Payout',
                                    style: AppTextStyles.titleSmall
                                        .copyWith(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    _fmt(controller.yearEndPayout),
                                    style: AppTextStyles.titleMedium
                                        .copyWith(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              _ProjectionRow(
                                label: 'Daily Accrual',
                                value:
                                    '${_fmt(controller.dailyAccrual)}/day',
                                valueColor:
                                    AppColors.white.withOpacity(0.65),
                                icon: Icons.trending_up_rounded,
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

          // ── CTA ────────────────────────────────────────────────────
          Container(
            padding: REdgeInsets.fromLTRB(20, 12, 20, 32),
            decoration: BoxDecoration(
              color: AppColors.background,
              border:
                  Border(top: BorderSide(color: AppColors.divider)),
            ),
            child: GestureDetector(
              onTap: controller.canContinue
                  ? controller.onContinue
                  : null,
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
                    Text(
                      'Continue',
                      style: AppTextStyles.labelLarge.copyWith(
                          color: AppColors.white),
                    ),
                    SizedBox(width: 6.w),
                    Icon(Icons.arrow_forward_rounded,
                        size: 18.r, color: AppColors.white),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Mode toggle tab ────────────────────────────────────────────────────────────
class _ModeTab extends StatelessWidget {
  const _ModeTab({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 40.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Text(
            label,
            style: AppTextStyles.labelMedium.copyWith(
              color: isSelected ? AppColors.white : AppColors.textSecondary,
              fontWeight:
                  isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

// ── Projection row ─────────────────────────────────────────────────────────────
class _ProjectionRow extends StatelessWidget {
  const _ProjectionRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.icon,
  });
  final String label;
  final String value;
  final Color? valueColor;
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
                  color: valueColor ??
                      AppColors.white.withOpacity(0.85),
                  fontWeight: FontWeight.w600,
                )),
          ],
        ),
      ],
    );
  }
}