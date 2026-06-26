part of '../controllers/stocks_controller.dart';

class _StocksWatchlistSection extends StatelessWidget {
  final List<StockData> watchlist;
  final void Function(StockData) onStockTap;

  const _StocksWatchlistSection({
    required this.watchlist,
    required this.onStockTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'My Watchlist',
              style: textTheme.titleLarge,
            ),
            Row(
              children: [
                Icon(
                  Icons.bookmark_rounded,
                  size: 14.r,
                  color: colorScheme.primary,
                ),
                SizedBox(width: 4.w),
                Text(
                  '${watchlist.length} stocks',
                  style: textTheme.labelMedium?.copyWith(
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 12.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: Row(
            children: watchlist
                .map(
                  (stock) => Padding(
                    padding: REdgeInsets.only(right: 12),
                    child: _WatchlistChip(
                      stock: stock,
                      onTap: () => onStockTap(stock),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _WatchlistChip extends StatelessWidget {
  final StockData stock;
  final VoidCallback onTap;

  const _WatchlistChip({required this.stock, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 130.w,
        padding: REdgeInsets.all(14),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: colorScheme.outline),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 32.r,
                  height: 32.r,
                  decoration: BoxDecoration(
                    color: stock.iconBg.withOpacity(0.35),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Center(
                    child: Text(
                      stock.ticker.substring(
                          0, math.min(3, stock.ticker.length)),
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w800,
                        fontSize: 8.sp,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: REdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: stock.changeBgColor,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    stock.formattedChange,
                    style: textTheme.labelSmall?.copyWith(
                      color: stock.changeColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 9.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Text(
              stock.ticker,
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              stock.formattedPrice,
              style: textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}