import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';



// ─────────────────────────────────────────────────────────────────────────────
// AppEmptyWidget
//
// Inline empty state for lists and content areas with zero items.
// Use for:
//   - No investments yet
//   - No transactions
//   - No bank accounts linked
//   - No notifications
//   - Any empty collection
//
// Presets via AppEmptyPreset cover the common Beige cases.
// Or pass fully custom icon/title/message/action.
//
// Usage — preset:
//   AppEmptyWidget(preset: AppEmptyPreset.investments)
//
// Usage — custom:
//   AppEmptyWidget(
//     icon: Icons.receipt_long_outlined,
//     iconBg: AppColors.cloudyBlue,
//     iconColor: AppColors.moodyBlue,
//     title: 'No statements yet',
//     message: 'Your transaction statements will appear here.',
//   )
//
// Usage — with CTA:
//   AppEmptyWidget(
//     preset: AppEmptyPreset.bankAccounts,
//     actionLabel: 'Add Bank Account',
//     onAction: () => controller.onAddBankAccount(),
//   )
// ─────────────────────────────────────────────────────────────────────────────

enum AppEmptyPreset {
  investments,
  transactions,
  bankAccounts,
  notifications,
  statements,
  custom,
}

class AppEmptyWidget extends StatelessWidget {
  // Preset constructor
  const AppEmptyWidget({
    super.key,
    required this.preset,
    this.actionLabel,
    this.onAction,
  })  : icon = null,
        iconBg = null,
        iconColor = null,
        title = null,
        message = null;

  // Custom constructor
  const AppEmptyWidget.custom({
    super.key,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  }) : preset = AppEmptyPreset.custom;

  final AppEmptyPreset preset;
  final IconData? icon;
  final Color? iconBg;
  final Color? iconColor;
  final String? title;
  final String? message;
  final String? actionLabel;
  final VoidCallback? onAction;

  _EmptyConfig get _config => switch (preset) {
        AppEmptyPreset.investments => const _EmptyConfig(
            icon: Icons.show_chart_rounded,
            iconBg: AppColors.limeGreen,
            iconColor: AppColors.primary,
            title: 'No investments yet',
            message:
                'Start growing your money. Create your first investment today.',
          ),
        AppEmptyPreset.transactions => const _EmptyConfig(
            icon: Icons.receipt_long_outlined,
            iconBg: AppColors.cloudyBlue,
            iconColor: AppColors.moodyBlue,
            title: 'No transactions yet',
            message:
                'Your wallet activity will show up here once you fund or invest.',
          ),
        AppEmptyPreset.bankAccounts => const _EmptyConfig(
            icon: Icons.account_balance_outlined,
            iconBg: AppColors.beigePink,
            iconColor: AppColors.primary,
            title: 'No bank accounts linked',
            message:
                'Add a bank account to start making withdrawals.',
          ),
        AppEmptyPreset.notifications => const _EmptyConfig(
            icon: Icons.notifications_none_rounded,
            iconBg: AppColors.cloudyBlue,
            iconColor: AppColors.moodyBlue,
            title: 'All caught up',
            message: 'You have no notifications right now.',
          ),
        AppEmptyPreset.statements => const _EmptyConfig(
            icon: Icons.description_outlined,
            iconBg: AppColors.cloudyBlue,
            iconColor: AppColors.moodyBlue,
            title: 'No statements yet',
            message:
                'Your transaction statements will appear here once there\'s activity.',
          ),
        AppEmptyPreset.custom => _EmptyConfig(
            icon: icon!,
            iconBg: iconBg!,
            iconColor: iconColor!,
            title: title!,
            message: message!,
          ),
      };

  @override
  Widget build(BuildContext context) {
    final cfg = _config;

    return Center(
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon circle
            Container(
              width: 80.r,
              height: 80.r,
              decoration: BoxDecoration(
                color: cfg.iconBg,
                shape: BoxShape.circle,
              ),
              child: Icon(cfg.icon, size: 36.r, color: cfg.iconColor),
            ),

            SizedBox(height: 20.h),

            // Title
            Text(
              cfg.title,
              textAlign: TextAlign.center,
              style: AppTextStyles.titleMedium.copyWith(
                fontFamily: 'BWGradual',
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),

            SizedBox(height: 8.h),

            // Message
            Text(
              cfg.message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
                height: 1.55,
              ),
            ),

            // Optional CTA
            if (actionLabel != null && onAction != null) ...[
              SizedBox(height: 24.h),
              GestureDetector(
                onTap: onAction,
                child: Container(
                  padding:
                      REdgeInsets.symmetric(horizontal: 28, vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    actionLabel!,
                    style: AppTextStyles.labelLarge.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ── Internal config ────────────────────────────────────────────────────────────
class _EmptyConfig {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String message;

  const _EmptyConfig({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.message,
  });
}
