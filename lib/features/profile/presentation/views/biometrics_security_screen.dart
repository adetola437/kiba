import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class BiometricsSecurityScreen extends StatefulWidget {
  static const String route = 'biometrics';

  const BiometricsSecurityScreen({super.key});

  @override
  State<BiometricsSecurityScreen> createState() =>
      _BiometricsSecurityScreenState();
}

class _BiometricsSecurityScreenState extends State<BiometricsSecurityScreen> {
  bool _biometricLogin = true;
  bool _transactionBiometrics = true;
  bool _hideBalances = false;
  bool _newDeviceAlerts = true;
  String _sessionTimeout = '5 minutes';

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
          'Biometrics & Security',
          style: textTheme.titleMedium,
        ),
      ),
      body: ListView(
        padding: REdgeInsets.fromLTRB(20, 20, 20, 32),
        children: [
          const _SecurityStatusCard(),
          SizedBox(height: 22.h),
          _SecuritySection(
            title: 'BIOMETRICS',
            children: [
              _SecuritySwitchTile(
                icon: Icons.fingerprint_rounded,
                title: 'Biometric Login',
                subtitle: 'Use Face ID or fingerprint to sign in',
                value: _biometricLogin,
                onChanged: (value) => setState(() => _biometricLogin = value),
              ),
              _SecuritySwitchTile(
                icon: Icons.verified_user_outlined,
                title: 'Confirm Transactions',
                subtitle: 'Require biometrics before withdrawals and top ups',
                value: _transactionBiometrics,
                onChanged: (value) =>
                    setState(() => _transactionBiometrics = value),
              ),
            ],
          ),
          SizedBox(height: 22.h),
          _SecuritySection(
            title: 'PRIVACY',
            children: [
              _SecuritySwitchTile(
                icon: Icons.visibility_off_outlined,
                title: 'Hide Balances',
                subtitle: 'Mask account balances on app launch',
                value: _hideBalances,
                onChanged: (value) => setState(() => _hideBalances = value),
              ),
              _SecuritySwitchTile(
                icon: Icons.devices_other_outlined,
                title: 'New Device Alerts',
                subtitle: 'Notify me when a new device signs in',
                value: _newDeviceAlerts,
                onChanged: (value) => setState(() => _newDeviceAlerts = value),
              ),
            ],
          ),
          SizedBox(height: 18.h),
          Container(
            padding: REdgeInsets.all(14),
            decoration: BoxDecoration(
              color: colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  size: 18.r,
                  color: colorScheme.tertiary,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    'Security settings apply to this device. Some changes may require verification before they are saved.',
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.tertiary,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showComingSoon(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title setup will be available soon.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showTimeoutSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (context) {
        final colorScheme = Theme.of(context).colorScheme;
        final textTheme = Theme.of(context).textTheme;
        const options = ['1 minute', '5 minutes', '15 minutes', '30 minutes'];

        return SafeArea(
          child: Padding(
            padding: REdgeInsets.fromLTRB(20, 18, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Auto-lock',
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 12.h),
                ...options.map(
                  (option) => _TimeoutOptionTile(
                    label: option,
                    selected: option == _sessionTimeout,
                    onTap: () {
                      setState(() => _sessionTimeout = option);
                      context.pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SecurityStatusCard extends StatelessWidget {
  const _SecurityStatusCard();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

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
              color: colorScheme.onPrimary.withOpacity(0.18),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Icon(
              Icons.shield_outlined,
              size: 24.r,
              color: colorScheme.onPrimary,
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Protected',
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Biometric login and transaction checks are active on this device.',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onPrimary.withOpacity(0.78),
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

class _SecuritySection extends StatelessWidget {
  const _SecuritySection({
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

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
              return _SecurityTileContainer(
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

class _SecurityTileContainer extends StatelessWidget {
  const _SecurityTileContainer({
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
            indent: 78.w,
          ),
      ],
    );
  }
}

class _SecuritySwitchTile extends StatelessWidget {
  const _SecuritySwitchTile({
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

    return InkWell(
      onTap: () => onChanged(!value),
      splashColor: colorScheme.primary.withOpacity(0.04),
      highlightColor: colorScheme.primary.withOpacity(0.02),
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            _SecurityTileIcon(icon: icon),
            SizedBox(width: 14.w),
            Expanded(
                child: _SecurityTileCopy(title: title, subtitle: subtitle)),
            SizedBox(width: 12.w),
            Switch.adaptive(
              value: value,
              activeColor: colorScheme.primary,
              activeTrackColor: colorScheme.primary.withOpacity(0.24),
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}

class _SecurityActionTile extends StatelessWidget {
  const _SecurityActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      splashColor: colorScheme.primary.withOpacity(0.04),
      highlightColor: colorScheme.primary.withOpacity(0.02),
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            _SecurityTileIcon(icon: icon),
            SizedBox(width: 14.w),
            Expanded(
                child: _SecurityTileCopy(title: title, subtitle: subtitle)),
            SizedBox(width: 12.w),
            Icon(
              Icons.chevron_right_rounded,
              size: 22.r,
              color: colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}

class _SecurityValueTile extends StatelessWidget {
  const _SecurityValueTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      splashColor: colorScheme.primary.withOpacity(0.04),
      highlightColor: colorScheme.primary.withOpacity(0.02),
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            _SecurityTileIcon(icon: icon),
            SizedBox(width: 14.w),
            Expanded(
                child: _SecurityTileCopy(title: title, subtitle: subtitle)),
            SizedBox(width: 12.w),
            Text(
              value,
              style: textTheme.labelMedium?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(width: 4.w),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 20.r,
              color: colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}

class _SecurityTileIcon extends StatelessWidget {
  const _SecurityTileIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
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
    );
  }
}

class _SecurityTileCopy extends StatelessWidget {
  const _SecurityTileCopy({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
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
    );
  }
}

class _TimeoutOptionTile extends StatelessWidget {
  const _TimeoutOptionTile({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: REdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                ),
              ),
            ),
            if (selected)
              Icon(
                Icons.check_rounded,
                size: 20.r,
                color: colorScheme.primary,
              ),
          ],
        ),
      ),
    );
  }
}