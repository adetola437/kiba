part of '../controllers/home_controller.dart';

class _ActiveInvestmentCard extends StatelessWidget {
  const _ActiveInvestmentCard();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: REdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colorScheme.outline),
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
                  color: colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.trending_up_rounded,
                  size: 18.r,
                  color: colorScheme.primary,
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
                        color: colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      'Fixed Income',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: REdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  'ACTIVE',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: colorScheme.onPrimaryContainer,
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
                valueColor: colorScheme.primary,
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
              backgroundColor: colorScheme.surfaceVariant,
              valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
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
                      style: AppTextStyles.labelSmall.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.38),
                      )),
                  Text('1 Jan 2026',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      )),
                ],
              ),
              Container(
                padding: REdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  '31%',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('MATURITY',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.38),
                      )),
                  Text('25 Sept 2026',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      )),
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
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: AppTextStyles.labelSmall.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.38),
              fontSize: 9.sp,
            )),
        SizedBox(height: 2.h),
        Text(value,
            style: AppTextStyles.titleSmall.copyWith(
              color: valueColor ?? colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            )),
      ],
    );
  }
}