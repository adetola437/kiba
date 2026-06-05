part of '../controllers/portfolio_controller.dart';

class _InvestmentCard extends StatelessWidget {
  const _InvestmentCard({
    required this.data,
    required this.onTap,
    required this.balanceVisible,
  });

  final InvestmentData data;
  final VoidCallback onTap;
  final bool balanceVisible;

  String _mask(String value) => balanceVisible ? value : '••••••';

  String _fmt(double value) {
    if (value >= 1000000) {
      return '₦${(value / 1000000).toStringAsFixed(1)}M';
    } else if (value >= 1000) {
      return '₦${(value / 1000).toStringAsFixed(1)}K';
    }
    return '₦${value.toStringAsFixed(2)}';
  }

  String _fmtFull(double value) {
    final f = NumberFormat('#,##0.00', 'en_US');
    return '₦${f.format(value)}';
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('d MMM yyyy');

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.border),
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16.r),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16.r),
            splashColor: AppColors.primary.withOpacity(0.04),
            highlightColor: AppColors.primary.withOpacity(0.02),
            child: Padding(
              padding: REdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // ── Header row ──────────────────────────────────────
                  Row(
                    children: [
                      Container(
                        width: 34.r,
                        height: 34.r,
                        decoration: BoxDecoration(
                          color: data.isMatured
                              ? AppColors.surfaceVariant
                              : AppColors.limeGreen.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Icon(
                          Icons.trending_up_rounded,
                          size: 16.r,
                          color: data.isMatured
                              ? AppColors.textDisabled
                              : AppColors.primary,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          data.name,
                          style: AppTextStyles.titleSmall.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      // Status badge
                      Container(
                        padding: REdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: data.isMatured
                              ? AppColors.beigePink.withOpacity(0.4)
                              : AppColors.limeGreen.withOpacity(0.35),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          data.isMatured ? 'MATURED' : 'ACTIVE',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: data.isMatured
                                ? AppColors.charcoalGrey
                                : AppColors.primary,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  // ── Principal / Returns ─────────────────────────────
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'PRINCIPAL',
                              style: AppTextStyles.labelSmall.copyWith(
                                color: AppColors.textDisabled,
                                letterSpacing: 0.6,
                                fontSize: 9.sp,
                              ),
                            ),
                            SizedBox(height: 3.h),
                            Text(
                              _mask(_fmtFull(data.principal)),
                              style: AppTextStyles.titleMedium.copyWith(
                                color: data.isMatured
                                    ? AppColors.textDisabled
                                    : AppColors.textPrimary,
                                fontWeight: FontWeight.w700,
                                fontSize: 17.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'RETURNS',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.textDisabled,
                              letterSpacing: 0.6,
                              fontSize: 9.sp,
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Text(
                            _mask('+${_fmtFull(data.returns)}'),
                            style: AppTextStyles.titleMedium.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                              fontSize: 17.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 14.h),

                  // ── Progress bar ────────────────────────────────────
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.r),
                    child: LinearProgressIndicator(
                      value: data.progressPercent,
                      minHeight: 6.h,
                      backgroundColor: AppColors.surfaceVariant,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        data.isMatured
                            ? AppColors.textDisabled
                            : AppColors.primary,
                      ),
                    ),
                  ),

                  SizedBox(height: 8.h),

                  // ── Date row ────────────────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        dateFormat.format(data.startDate),
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Container(
                        padding: REdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: data.isMatured
                              ? AppColors.surfaceVariant
                              : AppColors.primary,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          '${(data.progressPercent * 100).toInt()}%',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: data.isMatured
                                ? AppColors.textDisabled
                                : AppColors.white,
                          ),
                        ),
                      ),
                      Text(
                        dateFormat.format(data.maturityDate),
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 14.h),
                  Divider(color: AppColors.divider, height: 1),
                  SizedBox(height: 12.h),

                  // ── ROI + Tenor ─────────────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            data.isMatured
                                ? Icons.check_circle_outline_rounded
                                : Icons.trending_up_rounded,
                            size: 14.r,
                            color: data.isMatured
                                ? AppColors.textDisabled
                                : AppColors.primary,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            '+${data.roiPercent}% p.a.',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: data.isMatured
                                  ? AppColors.textDisabled
                                  : AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        data.tenor,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}