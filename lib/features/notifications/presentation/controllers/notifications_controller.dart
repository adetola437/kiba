import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/contract.dart';

part '../contracts/notifications_contract.dart';
part '../views/notifications_view.dart';
part '../widgets/notification_tile.dart';

class NotificationsScreen extends StatefulWidget {
  static const String route = 'notifications';

  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    implements NotificationsControllerContract {
  late final NotificationsViewContract view;
  late List<NotificationData> _notifications;

  @override
  void initState() {
    super.initState();
    view = NotificationsView(controller: this);
    _notifications = _seedNotifications;
  }

  @override
  List<NotificationData> get notifications => _notifications;

  @override
  bool get hasUnread => _notifications.any((item) => !item.isRead);

  @override
  Map<String, List<NotificationData>> get groupedNotifications {
    final groups = <String, List<NotificationData>>{};

    for (final notification in _notifications) {
      final label = _groupLabel(notification.createdAt);
      groups.putIfAbsent(label, () => []).add(notification);
    }

    return groups;
  }

  @override
  void onBack() => context.pop();

  @override
  void onMarkAllRead() {
    setState(() {
      _notifications = _notifications
          .map((item) => item.copyWith(isRead: true))
          .toList(growable: false);
    });
  }

  @override
  void onNotificationTap(NotificationData notification) {
    if (notification.isRead) return;

    setState(() {
      _notifications = _notifications
          .map(
            (item) =>
                item.id == notification.id ? item.copyWith(isRead: true) : item,
          )
          .toList(growable: false);
    });
  }

  @override
  Widget build(BuildContext context) => view.build(context);

  String _groupLabel(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final itemDate = DateTime(date.year, date.month, date.day);

    if (itemDate == today) return 'Today';
    if (itemDate == today.subtract(const Duration(days: 1))) {
      return 'Yesterday';
    }

    return DateFormat('d MMMM yyyy').format(date);
  }
}

class NotificationData {
  const NotificationData({
    required this.id,
    required this.title,
    required this.message,
    required this.createdAt,
    required this.type,
    this.isRead = false,
  });

  final String id;
  final String title;
  final String message;
  final DateTime createdAt;
  final NotificationType type;
  final bool isRead;

  NotificationData copyWith({
    String? id,
    String? title,
    String? message,
    DateTime? createdAt,
    NotificationType? type,
    bool? isRead,
  }) {
    return NotificationData(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
    );
  }
}

enum NotificationType {
  investment,
  wallet,
  kyc,
  security,
}

List<NotificationData> get _seedNotifications {
  final now = DateTime.now();

  return [
    NotificationData(
      id: 'investment-payout',
      title: 'Investment payout received',
      message: 'Your PMPS investment payout of ₦23,044 has been credited.',
      createdAt: now.subtract(const Duration(minutes: 18)),
      type: NotificationType.investment,
    ),
    NotificationData(
      id: 'kyc-approved',
      title: 'Tier 2 verification approved',
      message: 'You can now access higher wallet and investment limits.',
      createdAt: now.subtract(const Duration(hours: 2)),
      type: NotificationType.kyc,
    ),
    NotificationData(
      id: 'wallet-funded',
      title: 'Wallet funded successfully',
      message: '₦50,000 was added to your KIBA wallet.',
      createdAt: now.subtract(const Duration(days: 1, hours: 1)),
      type: NotificationType.wallet,
      isRead: true,
    ),
    NotificationData(
      id: 'new-login',
      title: 'New sign-in detected',
      message: 'We noticed a sign-in to your account from a new device.',
      createdAt: now.subtract(const Duration(days: 2, hours: 4)),
      type: NotificationType.security,
      isRead: true,
    ),
  ];
}
