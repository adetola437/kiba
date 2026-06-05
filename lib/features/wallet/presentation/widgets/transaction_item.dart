part of '../controllers/transactions_controller.dart';

class _TransactionItem extends StatelessWidget {
  const _TransactionItem({
    required this.data,
    required this.onTap,
    required this.isLast,
  });

  final TransactionData data;
  final VoidCallback onTap;
  final bool isLast;

  Color get _iconBg {
    switch (data.type) {
      case TransactionFilter.fundings:
        return AppColors.cloudyBlue;
      case TransactionFilter.investments:
        return AppColors.limeGreen.withOpacity(0.4);
      case TransactionFilter.withdrawals:
        return AppColors.beigePink.withOpacity(0.5);
      case TransactionFilter.all:
        return AppColors.surfaceVariant;
    }
  }

  Color get _iconColor {
    switch (data.type) {
      case TransactionFilter.fundings:
        return AppColors.moodyBlue;
      case TransactionFilter.investments:
        return AppColors.primary;
      case TransactionFilter.withdrawals:
        return AppColors.charcoalGrey;
      case TransactionFilter.all:
        return AppColors.textSecondary;
    }
  }

  Color get _statusBg {
    switch (data.status) {
      case TransactionStatus.successful:
        return AppColors.limeGreen.withOpacity(0.35);
      case TransactionStatus.accrued:
        return AppColors.limeGreen.withOpacity(0.35);
      case TransactionStatus.completed:
        return AppColors.cloudyBlue.withOpacity(0.6);
      case TransactionStatus.locked:
        return AppColors.beigePink.withOpacity(0.5);
      case TransactionStatus.pending:
        return AppColors.beigePink.withOpacity(0.4);
      case TransactionStatus.failed:
        return Colors.red.withOpacity(0.12);
    }
  }

  Color get _statusColor {
    switch (data.status) {
      case TransactionStatus.successful:
      case TransactionStatus.accrued:
        return AppColors.primary;
      case TransactionStatus.completed:
        return AppColors.moodyBlue;
      case TransactionStatus.locked:
        return AppColors.charcoalGrey;
      case TransactionStatus.pending:
        return AppColors.charcoalGrey;
      case TransactionStatus.failed:
        return Colors.red;
    }
  }

  String get _statusLabel {
    switch (data.status) {
      case TransactionStatus.successful: return 'SUCCESSFUL';
      case TransactionStatus.accrued:    return 'ACCRUED';
      case TransactionStatus.completed:  return 'COMPLETED';
      case TransactionStatus.locked:     return 'LOCKED';
      case TransactionStatus.pending:    return 'PENDING';
      case TransactionStatus.failed:     return 'FAILED';
    }
  }

  String _fmtAmount() {
    final sign = data.isCredit ? '+' : '-';
    final f = NumberFormat('#,##0.##', 'en_US');
    if (data.amount >= 1000000) {
      return '$sign₦${(data.amount / 1000000).toStringAsFixed(1)}M';
    } else if (data.amount >= 1000) {
      return '$sign₦${f.format(data.amount / 1000)}K';
    }
    return '$sign₦${f.format(data.amount)}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            splashColor: AppColors.primary.withOpacity(0.04),
            child: Padding(
              padding: REdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  // Icon
                  Container(
                    width: 44.r,
                    height: 44.r,
                    decoration: BoxDecoration(
                      color: _iconBg,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(data.icon, size: 18.r, color: _iconColor),
                  ),

                  SizedBox(width: 12.w),

                  // Title + subtitle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.title,
                          style: AppTextStyles.titleSmall.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Text(
                          data.subtitle,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textDisabled,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 10.w),

                  // Amount + status
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _fmtAmount(),
                        style: AppTextStyles.titleSmall.copyWith(
                          color: data.isCredit
                              ? AppColors.primary
                              : AppColors.charcoalGrey,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Container(
                        padding: REdgeInsets.symmetric(
                            horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: _statusBg,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          _statusLabel,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: _statusColor,
                            fontSize: 9.sp,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        if (!isLast)
          Divider(
            height: 1,
            color: AppColors.divider,
            indent: 72.w,
          ),
      ],
    );
  }
}