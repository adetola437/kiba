part of '../controllers/new_investment_controller.dart';

class _ProjectedReturnsCard extends StatelessWidget {
  const _ProjectedReturnsCard({required this.controller});

  final NewInvestmentControllerContract controller;

  String _fmt(double v) =>
      '₦${NumberFormat('#,##0.00', 'en_US').format(v)}';

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM d, y');

    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: REdgeInsets.fromLTRB(18, 16, 18, 14),
            child: Row(
              children: [
                Icon(
                  Icons.bar_chart_rounded,
                  size: 18.r,
                  color: AppColors.limeGreen,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Projected Returns',
                  style: AppTextStyles.titleSmall.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.trending_up_rounded,
                  size: 16.r,
                  color: AppColors.limeGreen,
                ),
              ],
            ),
          ),

          Divider(color: AppColors.white.withOpacity(0.1), height: 1),

          Padding(
            padding: REdgeInsets.all(18),
            child: Column(
              children: [
                _ReturnRow(
                  label: 'Principal',
                  value: _fmt(controller.enteredAmount),
                  isLight: true,
                ),
                SizedBox(height: 10.h),
                _ReturnRow(
                  label: 'Tenor',
                  value: '${controller.selectedTenor.days} Days',
                  isLight: true,
                ),
                SizedBox(height: 10.h),
                _ReturnRow(
                  label: 'Annual Rate',
                  value: '+${controller.selectedTenor.rate}%',
                  isLight: true,
                  valueColor: AppColors.limeGreen,
                ),
                SizedBox(height: 10.h),
                _ReturnRow(
                  label: 'Projected Interest',
                  value: _fmt(controller.projectedInterest),
                  isLight: true,
                  valueColor: AppColors.limeGreen,
                ),

                SizedBox(height: 14.h),
                Divider(color: AppColors.white.withOpacity(0.15), height: 1),
                SizedBox(height: 14.h),

                // Total at maturity — highlighted
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total at Maturity',
                      style: AppTextStyles.titleSmall.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      _fmt(controller.totalAtMaturity),
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10.h),

                _ReturnRow(
                  label: 'Maturity Date',
                  value: dateFormat.format(controller.maturityDate),
                  isLight: true,
                  icon: Icons.calendar_today_outlined,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReturnRow extends StatelessWidget {
  const _ReturnRow({
    required this.label,
    required this.value,
    this.isLight = false,
    this.valueColor,
    this.icon,
  });

  final String label;
  final String value;
  final bool isLight;
  final Color? valueColor;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (icon != null) ...[
              Icon(icon, size: 12.r,
                  color: AppColors.white.withOpacity(0.5)),
              SizedBox(width: 4.w),
            ],
            Text(
              label,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.white.withOpacity(0.55),
              ),
            ),
          ],
        ),
        Text(
          value,
          style: AppTextStyles.bodySmall.copyWith(
            color: valueColor ?? AppColors.white.withOpacity(0.85),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}