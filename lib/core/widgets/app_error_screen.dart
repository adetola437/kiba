import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';



// ─────────────────────────────────────────────────────────────────────────────
// AppErrorScreen
//
// Full-page error screen for terminal failures where the user can't continue
// the current flow. Use for:
//   - Payment / withdrawal failed (after PIN confirmation)
//   - Investment creation failed
//   - Session expired mid-flow
//   - Unrecoverable API errors
//
// Usage:
//   context.pushNamed(
//     AppErrorScreen.route,
//     extra: AppErrorScreenArgs(
//       type: AppErrorType.paymentFailed,
//       message: 'Your bank declined this transaction.',
//       reference: 'WD1234567890',          // optional
//       onPrimaryAction: () => context.goNamed('wallet'),
//       onSecondaryAction: () => context.goNamed('support'), // optional
//     ),
//   );
// ─────────────────────────────────────────────────────────────────────────────

enum AppErrorType {
  paymentFailed,
  investmentFailed,
  sessionExpired,
  generic,
}

class AppErrorScreenArgs {
  final AppErrorType type;
  final String? title;
  final String? message;
  final String? reference;
  final String primaryLabel;
  final String? secondaryLabel;
  final VoidCallback onPrimaryAction;
  final VoidCallback? onSecondaryAction;

  const AppErrorScreenArgs({
    required this.type,
    required this.onPrimaryAction,
    this.title,
    this.message,
    this.reference,
    this.primaryLabel = 'Go Back',
    this.secondaryLabel,
    this.onSecondaryAction,
  });
}

class AppErrorScreen extends StatelessWidget {
  static const String route = 'app_error';

  final AppErrorScreenArgs args;

  const AppErrorScreen({super.key, required this.args});

  _ErrorConfig get _config => switch (args.type) {
        AppErrorType.paymentFailed => _ErrorConfig(
            icon: Icons.credit_card_off_rounded,
            iconBg: const Color(0xFFFFEBEE),
            iconColor: AppColors.error,
            defaultTitle: 'Payment Failed',
            defaultMessage:
                'We couldn\'t process your payment. No funds have been deducted.',
          ),
        AppErrorType.investmentFailed => _ErrorConfig(
            icon: Icons.trending_down_rounded,
            iconBg: const Color(0xFFFFEBEE),
            iconColor: AppColors.error,
            defaultTitle: 'Investment Failed',
            defaultMessage:
                'We couldn\'t create your investment. Your wallet balance is unchanged.',
          ),
        AppErrorType.sessionExpired => _ErrorConfig(
            icon: Icons.lock_clock_rounded,
            iconBg: AppColors.cloudyBlue,
            iconColor: AppColors.moodyBlue,
            defaultTitle: 'Session Expired',
            defaultMessage:
                'You\'ve been logged out for your security. Please sign in again.',
          ),
        AppErrorType.generic => _ErrorConfig(
            icon: Icons.error_outline_rounded,
            iconBg: const Color(0xFFFFEBEE),
            iconColor: AppColors.error,
            defaultTitle: 'Something went wrong',
            defaultMessage:
                'An unexpected error occurred. Please try again.',
          ),
      };

  @override
  Widget build(BuildContext context) {
    final cfg = _config;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              const Spacer(),

              // ── Icon ────────────────────────────────────────────
              Container(
                width: 96.r,
                height: 96.r,
                decoration: BoxDecoration(
                  color: cfg.iconBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(cfg.icon, size: 44.r, color: cfg.iconColor),
              ),

              SizedBox(height: 28.h),

              // ── Title ────────────────────────────────────────────
              Text(
                args.title ?? cfg.defaultTitle,
                textAlign: TextAlign.center,
                style: AppTextStyles.headlineMedium.copyWith(
                  fontFamily: 'BWGradual',
                  color: AppColors.textPrimary,
                ),
              ),

              SizedBox(height: 10.h),

              // ── Message ──────────────────────────────────────────
              Text(
                args.message ?? cfg.defaultMessage,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.55,
                ),
              ),

              // ── Reference number (if provided) ───────────────────
              if (args.reference != null) ...[
                SizedBox(height: 20.h),
                Container(
                  padding: REdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Ref: ',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        args.reference!,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textPrimary,
                          fontFamily: 'EuclidCircularA',
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const Spacer(),

              // ── Primary CTA ──────────────────────────────────────
              GestureDetector(
                onTap: args.onPrimaryAction,
                child: Container(
                  width: double.infinity,
                  height: 56.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Text(
                    args.primaryLabel,
                    style: AppTextStyles.labelLarge.copyWith(
                      color: AppColors.white,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),

              // ── Secondary CTA (optional) ─────────────────────────
              if (args.secondaryLabel != null &&
                  args.onSecondaryAction != null) ...[
                SizedBox(height: 12.h),
                GestureDetector(
                  onTap: args.onSecondaryAction,
                  child: Container(
                    width: double.infinity,
                    height: 56.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Text(
                      args.secondaryLabel!,
                      style: AppTextStyles.labelLarge.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
              ],

              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Internal config helper ─────────────────────────────────────────────────────
class _ErrorConfig {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String defaultTitle;
  final String defaultMessage;

  const _ErrorConfig({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.defaultTitle,
    required this.defaultMessage,
  });
}
