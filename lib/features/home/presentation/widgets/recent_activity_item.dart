part of '../controllers/home_controller.dart';

// ── Recent Activity Item ───────────────────────────────────────────────────────
class _RecentActivityItem extends StatelessWidget {
  const _RecentActivityItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.isCredit,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String amount;
  final bool isCredit;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: REdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 40.r,
            height: 40.r,
            decoration: BoxDecoration(
              color: colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, size: 18.r, color: colorScheme.primary),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.titleSmall.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.38),
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: AppTextStyles.titleSmall.copyWith(
              color: isCredit ? colorScheme.primary : colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Market Insight Card ────────────────────────────────────────────────────────
class _MarketInsightCard extends StatelessWidget {
  const _MarketInsightCard({
    required this.category,
    required this.headline,
    required this.timeAgo,
    required this.readTime,
  });

  final String category;
  final String headline;
  final String timeAgo;
  final String readTime;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 220.w,
      margin: REdgeInsets.only(right: 14),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Placeholder image area
          Container(
            height: 110.h,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer.withValues(alpha: 0.3),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14.r),
                topRight: Radius.circular(14.r),
              ),
            ),
            child: Center(
              child: Icon(
                Icons.bar_chart_rounded,
                size: 36.r,
                color: colorScheme.primary.withValues(alpha: 0.3),
              ),
            ),
          ),

          Padding(
            padding: REdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: colorScheme.primary,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  headline,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.titleSmall.copyWith(
                    color: colorScheme.onSurface,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  '$timeAgo · $readTime read',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.38),
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