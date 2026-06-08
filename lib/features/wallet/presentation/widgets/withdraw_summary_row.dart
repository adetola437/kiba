part of '../controllers/withdraw_review_controller.dart';

class _WithdrawSummaryRow extends StatelessWidget {
  const _WithdrawSummaryRow({
    required this.label,
    required this.value,
    this.subValue,
    this.isBold = false,
    this.valueLarge = false,
    this.valueColor,
  });

  final String label;
  final String value;
  final String? subValue;
  final bool isBold;
  final bool valueLarge;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              value,
              style: (valueLarge
                      ? AppTextStyles.titleMedium
                      : AppTextStyles.bodyMedium)
                  .copyWith(
                color: valueColor ?? AppColors.textPrimary,
                fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
              ),
            ),
            if (subValue != null) ...[
              SizedBox(height: 2.h),
              Text(
                subValue!,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textDisabled,
                  fontFamily: 'EuclidCircularA',
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
