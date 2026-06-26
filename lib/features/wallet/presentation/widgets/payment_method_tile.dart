part of '../controllers/fund_wallet_controller.dart';

class _PaymentMethodTile extends StatelessWidget {
  const _PaymentMethodTile({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    this.badge,
    required this.onTap,
  });

  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String? badge;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Material(
      color: colorScheme.surface,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: REdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: colorScheme.outline),
          ),
          child: Row(
            children: [
              Container(
                width: 44.r,
                height: 44.r,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 22.r,
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: textTheme.titleMedium,
                        ),
                        if (badge != null) ...[
                          SizedBox(width: 8.w),
                          Container(
                            padding: REdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              badge!,
                              style: textTheme.labelSmall?.copyWith(
                                color: colorScheme.onPrimaryContainer,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      subtitle,
                      style: textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: colorScheme.onSurfaceVariant,
                size: 20.r,
              ),
            ],
          ),
        ),
      ),
    );
  }
}