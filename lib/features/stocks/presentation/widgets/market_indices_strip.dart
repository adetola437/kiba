part of '../controllers/stocks_controller.dart';

class _MarketIndicesStrip extends StatelessWidget {
  const _MarketIndicesStrip();

  @override
  Widget build(BuildContext context) {
    const indices = [
      _IndexData(label: 'ASI', value: '108,243.51', change: '+0.87%', isUp: true),
      _IndexData(label: 'Market Cap', value: '₦68.4T', change: '+1.2%', isUp: true),
      _IndexData(label: 'Volume', value: '₦3.2B', change: '-0.4%', isUp: false),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        children: indices
            .map(
              (idx) => Padding(
                padding: REdgeInsets.only(right: 12),
                child: _IndexChip(data: idx),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _IndexData {
  final String label;
  final String value;
  final String change;
  final bool isUp;
  const _IndexData({
    required this.label,
    required this.value,
    required this.change,
    required this.isUp,
  });
}

class _IndexChip extends StatelessWidget {
  final _IndexData data;
  const _IndexChip({required this.data});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final color = data.isUp ? colorScheme.primary : colorScheme.error;
    final bgColor = data.isUp
        ? colorScheme.primary.withOpacity(0.12)
        : colorScheme.error.withOpacity(0.12);

    return Container(
      padding: REdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.label,
            style: textTheme.labelSmall,
          ),
          SizedBox(height: 3.h),
          Text(
            data.value,
            style: textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4.h),
          Container(
            padding: REdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  data.isUp
                      ? Icons.arrow_upward_rounded
                      : Icons.arrow_downward_rounded,
                  size: 10.r,
                  color: color,
                ),
                SizedBox(width: 2.w),
                Text(
                  data.change,
                  style: textTheme.labelSmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
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