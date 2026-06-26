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
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              value,
              style: (valueLarge
                      ? textTheme.titleMedium
                      : textTheme.bodyMedium)
                  ?.copyWith(
                color: valueColor ?? colorScheme.onSurface,
                fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
              ),
            ),
            if (subValue != null) ...[
              SizedBox(height: 2.h),
              Text(
                subValue!,
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
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