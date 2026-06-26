import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';

class NotificationSettingsScreen extends StatefulWidget {
  static const String route = 'notification_settings';

  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _smsNotifications = false;
  bool _investmentUpdates = true;
  bool _walletActivity = true;
  bool _beigeClubUpdates = true;
  bool _securityAlerts = true;
  bool _promotions = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Container(
            margin: REdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: colorScheme.outline),
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 16.r,
              color: colorScheme.onSurface,
            ),
          ),
        ),
        title: Text(
          'Notification Settings',
          style: textTheme.titleMedium,
        ),
      ),
      body: ListView(
        padding: REdgeInsets.fromLTRB(20, 20, 20, 32),
        children: [
          _NotificationSummaryCard(
            pushEnabled: _pushNotifications,
            emailEnabled: _emailNotifications,
            smsEnabled: _smsNotifications,
          ),
          SizedBox(height: 22.h),
          _SettingsSection(
            title: 'CHANNELS',
            children: [
              _SettingsSwitchTile(
                icon: Icons.notifications_active_outlined,
                title: 'Push Notifications',
                subtitle: 'Instant updates on this device',
                value: _pushNotifications,
                onChanged: (value) =>
                    setState(() => _pushNotifications = value),
              ),
              _SettingsSwitchTile(
                icon: Icons.mail_outline_rounded,
                title: 'Email Notifications',
                subtitle: 'Account updates sent to your inbox',
                value: _emailNotifications,
                onChanged: (value) =>
                    setState(() => _emailNotifications = value),
              ),
              _SettingsSwitchTile(
                icon: Icons.sms_outlined,
                title: 'SMS Notifications',
                subtitle: 'Critical alerts by text message',
                value: _smsNotifications,
                onChanged: (value) => setState(() => _smsNotifications = value),
              ),
            ],
          ),
          SizedBox(height: 22.h),
          _SettingsSection(
            title: 'ACTIVITY',
            children: [
              _SettingsSwitchTile(
                icon: Icons.trending_up_rounded,
                title: 'Investment Updates',
                subtitle: 'Maturities, top ups, and interest activity',
                value: _investmentUpdates,
                onChanged: (value) =>
                    setState(() => _investmentUpdates = value),
              ),
              _SettingsSwitchTile(
                icon: Icons.account_balance_wallet_outlined,
                title: 'Wallet Activity',
                subtitle: 'Deposits, withdrawals, and transaction status',
                value: _walletActivity,
                onChanged: (value) => setState(() => _walletActivity = value),
              ),
              _SettingsSwitchTile(
                icon: Icons.groups_2_outlined,
                title: 'Beige Club Updates',
                subtitle: 'Contribution reminders and club progress',
                value: _beigeClubUpdates,
                onChanged: (value) => setState(() => _beigeClubUpdates = value),
              ),
            ],
          ),
          SizedBox(height: 22.h),
          _SettingsSection(
            title: 'ACCOUNT',
            children: [
              _SettingsSwitchTile(
                icon: Icons.shield_outlined,
                title: 'Security Alerts',
                subtitle: 'Login, password, and verification alerts',
                value: _securityAlerts,
                onChanged: (value) => setState(() => _securityAlerts = value),
              ),
              _SettingsSwitchTile(
                icon: Icons.local_offer_outlined,
                title: 'Promotions',
                subtitle: 'Offers, rewards, and product announcements',
                value: _promotions,
                onChanged: (value) => setState(() => _promotions = value),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NotificationSummaryCard extends StatelessWidget {
  const _NotificationSummaryCard({
    required this.pushEnabled,
    required this.emailEnabled,
    required this.smsEnabled,
  });

  final bool pushEnabled;
  final bool emailEnabled;
  final bool smsEnabled;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final enabledCount = [pushEnabled, emailEnabled, smsEnabled]
        .where((isEnabled) => isEnabled)
        .length;

    return Container(
      width: double.infinity,
      padding: REdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Row(
        children: [
          Container(
            width: 48.r,
            height: 48.r,
            decoration: BoxDecoration(
              color: AppColors.beigePink.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Icon(
              Icons.notifications_none_rounded,
              size: 24.r,
              color: AppColors.beigePink,
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$enabledCount channels active',
                  style: textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Security alerts stay visible so your account remains protected.',
                  style: textTheme.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.78),
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

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({
    required this.title,
    required this.children,
  });

  final String title;
  final List<_SettingsSwitchTile> children;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: REdgeInsets.only(left: 4, bottom: 10),
          child: Text(
            title,
            style: textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
              letterSpacing: 1.1,
              fontSize: 10.sp,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: colorScheme.outline),
          ),
          child: Column(
            children: children.asMap().entries.map((entry) {
              return _SettingsTileContainer(
                showDivider: entry.key != children.length - 1,
                child: entry.value,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _SettingsTileContainer extends StatelessWidget {
  const _SettingsTileContainer({
    required this.child,
    required this.showDivider,
  });

  final Widget child;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        child,
        if (showDivider)
          Divider(
            height: 1,
            color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
            indent: 78.w,
          ),
      ],
    );
  }
}

class _SettingsSwitchTile extends StatelessWidget {
  const _SettingsSwitchTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () => onChanged(!value),
      splashColor: colorScheme.primary.withValues(alpha: 0.04),
      highlightColor: colorScheme.primary.withValues(alpha: 0.02),
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 46.r,
              height: 46.r,
              decoration: BoxDecoration(
                color: colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                size: 22.r,
                color: colorScheme.primary,
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    subtitle,
                    style: textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Switch.adaptive(
              value: value,
              activeColor: colorScheme.primary,
              activeTrackColor: colorScheme.primary.withValues(alpha: 0.24),
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}