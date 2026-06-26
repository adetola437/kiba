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

  Color _iconBg(ColorScheme cs) {
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

  Color _iconColor(ColorScheme cs) {
    switch (type) {
      case _TxType.credit:
        return AppColors.moodyBlue;
      case _TxType.debit:
        return cs.onSurface;
      case _TxType.neutral:
        return cs.primary;
    }
  }

  Color _amountColor(ColorScheme cs) {
    switch (type) {
      case _TxType.credit:
        return cs.primary;
      case _TxType.debit:
        return cs.onSurface;
      case _TxType.neutral:
        return cs.onSurface;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: REdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          // Icon
          Container(
            width: 44.r,
            height: 44.r,
            decoration: BoxDecoration(
              color: _iconBg(colorScheme),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _icon,
              size: 18.r,
              color: _iconColor(colorScheme),
            ),
          ),

          SizedBox(width: 14.w),

          // Title + subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.titleSmall,
                ),
                SizedBox(height: 3.h),
                Text(
                  subtitle,
                  style: textTheme.bodySmall,
                ),
              ],
            ),
          ),

          // Amount
          Text(
            amount,
            style: textTheme.titleSmall?.copyWith(
              color: _amountColor(colorScheme),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}