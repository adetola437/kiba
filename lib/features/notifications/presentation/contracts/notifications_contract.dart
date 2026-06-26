part of '../controllers/notifications_controller.dart';

abstract class NotificationsControllerContract {
  List<NotificationData> get notifications;
  Map<String, List<NotificationData>> get groupedNotifications;
  bool get hasUnread;

  void onBack();
  void onMarkAllRead();
  void onNotificationTap(NotificationData notification);
}

abstract class NotificationsViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}
