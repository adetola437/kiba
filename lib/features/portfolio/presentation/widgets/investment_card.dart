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
    final colorScheme = Theme.of(context).colorScheme;
    final dateFormat = DateFormat('d MMM yyyy');

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: colorScheme.outline),
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16.r),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16.r),
            splashColor: colorScheme.primary.withValues(alpha: 0.04),
            highlightColor: colorScheme.primary.withValues(alpha: 0.02),
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
                              ? colorScheme.surfaceVariant
                              : colorScheme.primaryContainer.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Icon(
                          Icons.trending_up_rounded,
                          size: 16.r,
                          color: data.isMatured
                              ? colorScheme.onSurface.withValues(alpha: 0.38)
                              : colorScheme.primary,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          data.name,
                          style: AppTextStyles.titleSmall.copyWith(
                            color: colorScheme.onSurface,
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
                              ? colorScheme.secondaryContainer.withValues(alpha: 0.4)
                              : colorScheme.primaryContainer.withValues(alpha: 0.35),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          data.isMatured ? 'MATURED' : 'ACTIVE',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: data.isMatured
                                ? colorScheme.onSecondaryContainer
                                : colorScheme.onPrimaryContainer,
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
                                color: colorScheme.onSurface.withValues(alpha: 0.38),
                                letterSpacing: 0.6,
                                fontSize: 9.sp,
                              ),
                            ),
                            SizedBox(height: 3.h),
                            Text(
                              _mask(_fmtFull(data.principal)),
                              style: AppTextStyles.titleMedium.copyWith(
                                color: data.isMatured
                                    ? colorScheme.onSurface.withValues(alpha: 0.38)
                                    : colorScheme.onSurface,
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
                              color: colorScheme.onSurface.withValues(alpha: 0.38),
                              letterSpacing: 0.6,
                              fontSize: 9.sp,
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Text(
                            _mask('+${_fmtFull(data.returns)}'),
                            style: AppTextStyles.titleMedium.copyWith(
                              color: colorScheme.primary,
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
                      backgroundColor: colorScheme.surfaceVariant,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        data.isMatured
                            ? colorScheme.onSurface.withValues(alpha: 0.38)
                            : colorScheme.primary,
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
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Container(
                        padding: REdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: data.isMatured
                              ? colorScheme.surfaceVariant
                              : colorScheme.primary,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          '${(data.progressPercent * 100).toInt()}%',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: data.isMatured
                                ? colorScheme.onSurface.withValues(alpha: 0.38)
                                : colorScheme.onPrimary,
                          ),
                        ),
                      ),
                      Text(
                        dateFormat.format(data.maturityDate),
                        style: AppTextStyles.bodySmall.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 14.h),
                  Divider(color: colorScheme.outline, height: 1),
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
                                ? colorScheme.onSurface.withValues(alpha: 0.38)
                                : colorScheme.primary,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            '+${data.roiPercent}% p.a.',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: data.isMatured
                                  ? colorScheme.onSurface.withValues(alpha: 0.38)
                                  : colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        data.tenor,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: colorScheme.onSurfaceVariant,
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