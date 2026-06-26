part of '../controllers/notifications_controller.dart';

class NotificationsView extends StatelessWidget
    implements NotificationsViewContract {
  const NotificationsView({super.key, required this.controller});

  final NotificationsControllerContract controller;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final grouped = controller.groupedNotifications;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        leading: GestureDetector(
          onTap: controller.onBack,
          child: Icon(
            Icons.arrow_back_rounded,
            size: 22.r,
            color: colorScheme.onSurface,
          ),
        ),
        title: Text(
          'Notifications',
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          if (controller.hasUnread)
            GestureDetector(
              onTap: controller.onMarkAllRead,
              child: Padding(
                padding: REdgeInsets.only(right: 20),
                child: Center(
                  child: Text(
                    'Mark all read',
                    style: textTheme.labelMedium?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            )
          else
            SizedBox(width: 20.w),
        ],
      ),
      body: grouped.isEmpty
          ? const _EmptyNotifications()
          : ListView(
              padding: REdgeInsets.fromLTRB(20, 8, 20, 32),
              children: grouped.entries.map((entry) {
                final label = entry.key;
                final items = entry.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: REdgeInsets.only(top: 16, bottom: 10),
                      child: Text(
                        label.toUpperCase(),
                        style: textTheme.labelSmall?.copyWith(
                          letterSpacing: 1.1,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: colorScheme.outline),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: Column(
                          children: items
                              .asMap()
                              .entries
                              .map(
                                (entry) => NotificationTile(
                                  data: entry.value,
                                  isLast: entry.key == items.length - 1,
                                  onTap: () =>
                                      controller.onNotificationTap(entry.value),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
    );
  }
}

class _EmptyNotifications extends StatelessWidget {
  const _EmptyNotifications();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64.r,
              height: 64.r,
              decoration: BoxDecoration(
                color: colorScheme.primary.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications_none_rounded,
                size: 30.r,
                color: colorScheme.primary,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'No notifications yet',
              textAlign: TextAlign.center,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Updates about your wallet, investments, and account will appear here.',
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}