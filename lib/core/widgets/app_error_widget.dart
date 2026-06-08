import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';


// ─────────────────────────────────────────────────────────────────────────────
// AppErrorWidget
//
// Inline error state for when a screen's content fails to load but the
// scaffold/shell still renders fine. Use inside the body, not as a full page.
// Use for:
//   - Wallet balance / transactions failed to fetch
//   - Portfolio / investments list failed
//   - USSD bank list failed
//   - Virtual account not yet assigned
//   - Any list/content area that failed a network call
//
// Sizes:
//   AppErrorSize.large  — takes up most of the screen body (default)
//   AppErrorSize.small  — compact, fits inside a card or partial area
//
// Usage:
//   AppErrorWidget(
//     message: 'Could not load your portfolio.',
//     onRetry: () => controller.fetchPortfolio(),
//   )
//
//   AppErrorWidget.small(
//     message: 'Failed to load transactions.',
//     onRetry: () => controller.fetchTransactions(),
//   )
// ─────────────────────────────────────────────────────────────────────────────

enum AppErrorSize { large, small }

class AppErrorWidget extends StatelessWidget {
  final String? title;
  final String message;
  final String retryLabel;
  final VoidCallback? onRetry;
  final AppErrorSize size;

  const AppErrorWidget({
    super.key,
    this.title,
    required this.message,
    this.retryLabel = 'Try Again',
    this.onRetry,
    this.size = AppErrorSize.large,
  });

  const AppErrorWidget.small({
    super.key,
    this.title,
    required this.message,
    this.retryLabel = 'Retry',
    this.onRetry,
  }) : size = AppErrorSize.small;

  @override
  Widget build(BuildContext context) {
    return size == AppErrorSize.large ? _buildLarge() : _buildSmall();
  }

  Widget _buildLarge() {
    return Center(
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              width: 80.r,
              height: 80.r,
              decoration: BoxDecoration(
                color: const Color(0xFFFFEBEE),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.wifi_off_rounded,
                size: 36.r,
                color: AppColors.error,
              ),
            ),

            SizedBox(height: 20.h),

            // Title
            if (title != null) ...[
              Text(
                title!,
                textAlign: TextAlign.center,
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 8.h),
            ],

            // Message
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),

            // Retry button
            if (onRetry != null) ...[
              SizedBox(height: 24.h),
              GestureDetector(
                onTap: onRetry,
                child: Container(
                  padding:
                      REdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.refresh_rounded,
                        size: 16.r,
                        color: AppColors.white,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        retryLabel,
                        style: AppTextStyles.labelLarge.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSmall() {
    return Container(
      width: double.infinity,
      padding: REdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEBEE),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.error.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 18.r,
            color: AppColors.error,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              message,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.error,
                height: 1.4,
              ),
            ),
          ),
          if (onRetry != null) ...[
            SizedBox(width: 10.w),
            GestureDetector(
              onTap: onRetry,
              child: Text(
                retryLabel,
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.error,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
