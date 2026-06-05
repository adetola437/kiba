part of '../controllers/home_controller.dart';

class _ActiveInvestmentCard extends StatelessWidget {
  const _ActiveInvestmentCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                width: 36.r,
                height: 36.r,
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.trending_up_rounded,
                  size: 18.r,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PMPS — 180 Days',
                      style: AppTextStyles.titleSmall.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      'Fixed Income',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: REdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.limeGreen,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  'ACTIVE',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.primary,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Principal / Accrued
          Row(
            children: [
              _InvestStat(label: 'PRINCIPAL', value: '₦1,000,000'),
              SizedBox(width: 32.w),
              _InvestStat(
                label: 'ACCRUED',
                value: '+₦9,650',
                valueColor: AppColors.primary,
              ),
            ],
          ),

          SizedBox(height: 14.h),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: 0.31,
              minHeight: 6.h,
              backgroundColor: AppColors.surfaceVariant,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),

          SizedBox(height: 8.h),

          // Dates
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('START',
                      style: AppTextStyles.labelSmall
                          .copyWith(color: AppColors.textDisabled)),
                  Text('1 Jan 2026',
                      style: AppTextStyles.bodySmall
                          .copyWith(color: AppColors.textSecondary)),
                ],
              ),
              Container(
                padding: REdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  '31%',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('MATURITY',
                      style: AppTextStyles.labelSmall
                          .copyWith(color: AppColors.textDisabled)),
                  Text('25 Sept 2026',
                      style: AppTextStyles.bodySmall
                          .copyWith(color: AppColors.textSecondary)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InvestStat extends StatelessWidget {
  const _InvestStat({
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: AppTextStyles.labelSmall
                .copyWith(color: AppColors.textDisabled, fontSize: 9.sp)),
        SizedBox(height: 2.h),
        Text(value,
            style: AppTextStyles.titleSmall.copyWith(
              color: valueColor ?? AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            )),
      ],
    );
  }
}