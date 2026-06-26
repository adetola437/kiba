part of '../controllers/stock_detail_controller.dart';

class _StockStatsGrid extends StatelessWidget {
  final StockData stock;
  const _StockStatsGrid({required this.stock});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final stats = [
      _StatItem(
          label: 'Market Cap',
          value: '₦${stock.marketCap.toStringAsFixed(2)}T'),
      _StatItem(
          label: 'P/E Ratio',
          value: stock.peRatio.toStringAsFixed(1)),
      _StatItem(
          label: 'Div. Yield',
          value: '${stock.dividendYield.toStringAsFixed(1)}%'),
      _StatItem(
          label: 'Volume',
          value: '${stock.volume.toStringAsFixed(1)}M'),
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 2.6,
      mainAxisSpacing: 10.h,
      crossAxisSpacing: 10.w,
      children: stats
          .map((s) => Container(
                padding:
                    REdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      s.label,
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      s.value,
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}

class _StatItem {
  final String label;
  final String value;
  const _StatItem({required this.label, required this.value});
}