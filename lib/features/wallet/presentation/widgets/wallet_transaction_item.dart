part of '../controllers/wallet_controller.dart';

enum _TxType { credit, debit, neutral }

class _WalletTransactionItem extends StatelessWidget {
  const _WalletTransactionItem({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.type,
  });

  final String title;
  final String subtitle;
  final String amount;
  final _TxType type;

  Color get _iconBg {
    switch (type) {
      case _TxType.credit:
        return AppColors.cloudyBlue;
      case _TxType.debit:
        return AppColors.beigePink;
      case _TxType.neutral:
        return AppColors.limeGreen;
    }
  }

  IconData get _icon {
    switch (type) {
      case _TxType.credit:
        return Icons.arrow_downward_rounded;
      case _TxType.debit:
        return Icons.arrow_upward_rounded;
      case _TxType.neutral:
        return Icons.currency_exchange_rounded;
    }
  }

  Color get _iconColor {
    switch (type) {
      case _TxType.credit:
        return AppColors.moodyBlue;
      case _TxType.debit:
        return AppColors.charcoalGrey;
      case _TxType.neutral:
        return AppColors.primary;
    }
  }

  Color get _amountColor {
    switch (type) {
      case _TxType.credit:
        return AppColors.primary;
      case _TxType.debit:
        return AppColors.charcoalGrey;
      case _TxType.neutral:
        return AppColors.charcoalGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 14),
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
            child: Icon(_icon, size: 18.r, color: _iconColor),
          ),

          SizedBox(width: 14.w),

          // Title + subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.titleSmall.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  subtitle,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textDisabled,
                  ),
                ),
              ],
            ),
          ),

          // Amount
          Text(
            amount,
            style: AppTextStyles.titleSmall.copyWith(
              color: _amountColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}