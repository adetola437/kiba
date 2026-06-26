part of '../controllers/notifications_controller.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    required this.data,
    required this.isLast,
    required this.onTap,
  });

  final NotificationData data;
  final bool isLast;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final accent = _accentColor(data.type);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        color: data.isRead
            ? colorScheme.surface
            : colorScheme.surfaceVariant.withOpacity(0.35),
        child: Column(
          children: [
            Padding(
              padding: REdgeInsets.all(14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40.r,
                    height: 40.r,
                    decoration: BoxDecoration(
                      color: accent.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _icon(data.type),
                      size: 20.r,
                      color: accent,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                data.title,
                                style: textTheme.titleSmall?.copyWith(
                                  fontWeight: data.isRead
                                      ? FontWeight.w600
                                      : FontWeight.w700,
                                ),
                              ),
                            ),
                            if (!data.isRead) ...[
                              SizedBox(width: 8.w),
                              Container(
                                width: 8.r,
                                height: 8.r,
                                margin: REdgeInsets.only(top: 5),
                                decoration: BoxDecoration(
                                  color: colorScheme.primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          data.message,
                          style: textTheme.bodySmall?.copyWith(
                            height: 1.45,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          _timeLabel(data.createdAt),
                          style: textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            letterSpacing: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (!isLast)
              Divider(
                height: 1,
                indent: 66.w,
                color: colorScheme.outline.withOpacity(0.5),
              ),
          ],
        ),
      ),
    );
  }

  Color _accentColor(NotificationType type) {
    switch (type) {
      case NotificationType.investment:
        return AppColors.primary;
      case NotificationType.wallet:
        return AppColors.moodyBlue;
      case NotificationType.kyc:
        return AppColors.charcoalGrey;
      case NotificationType.security:
        return AppColors.error;
    }
  }

  IconData _icon(NotificationType type) {
    switch (type) {
      case NotificationType.investment:
        return Icons.trending_up_rounded;
      case NotificationType.wallet:
        return Icons.account_balance_wallet_rounded;
      case NotificationType.kyc:
        return Icons.verified_outlined;
      case NotificationType.security:
        return Icons.shield_outlined;
    }
  }

  String _timeLabel(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) return 'Just now';
    if (difference.inHours < 1) return '${difference.inMinutes}m ago';
    if (difference.inDays < 1) return '${difference.inHours}h ago';

    return DateFormat('h:mm a').format(date);
  }
}