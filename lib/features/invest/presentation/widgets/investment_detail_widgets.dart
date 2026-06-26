part of '../controllers/investment_details_controller.dart';

// ── Stat box ───────────────────────────────────────────────────────────────────
class _StatBox extends StatelessWidget {
  const _StatBox({required this.label, required this.value, this.valueColor});

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: REdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.38),
              letterSpacing: 0.5,
              fontSize: 9.sp,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            value,
            style: AppTextStyles.titleMedium.copyWith(
              color: valueColor ?? colorScheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Feature row ────────────────────────────────────────────────────────────────
class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.feature});

  final ProductFeature feature;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: REdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36.r,
            height: 36.r,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              feature.icon,
              size: 16.r,
              color: colorScheme.primary,
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feature.title,
                  style: AppTextStyles.titleSmall.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  feature.body,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Transaction row ────────────────────────────────────────────────────────────
class _TxRow extends StatelessWidget {
  const _TxRow({required this.tx, required this.isLast});

  final InvestmentTx tx;
  final bool isLast;

  String _fmt(double v) {
    final sign = tx.isCredit ? '+' : '-';
    if (v >= 1000000) return '$sign₦${(v / 1000000).toStringAsFixed(1)}M';
    if (v >= 1000) return '$sign₦${(v / 1000).toStringAsFixed(1)}K';
    return '$sign₦${v.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 16, vertical: 13),
          child: Row(
            children: [
              Container(
                width: 38.r,
                height: 38.r,
                decoration: BoxDecoration(
                  color: tx.isCredit
                      ? colorScheme.primaryContainer.withValues(alpha: 0.2)
                      : colorScheme.surfaceVariant,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  tx.icon,
                  size: 16.r,
                  color: tx.isCredit
                      ? colorScheme.primary
                      : colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tx.title,
                      style: AppTextStyles.titleSmall.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      tx.subtitle,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.38),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                _fmt(tx.amount),
                style: AppTextStyles.titleSmall.copyWith(
                  color: tx.isCredit
                      ? colorScheme.primary
                      : colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          Divider(
            height: 1,
            color: colorScheme.outline,
            indent: 66.w,
          ),
      ],
    );
  }
}

// ── Summary row (for dark/primary surfaces) ───────────────────────────────────
class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
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