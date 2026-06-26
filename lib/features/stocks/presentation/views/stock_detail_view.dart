part of '../controllers/stock_detail_controller.dart';

class StockDetailView extends StatelessWidget implements StockDetailViewContract {
  const StockDetailView({super.key, required this.controller});

  final StockDetailControllerContract controller;

  String _fmt(double v) =>
      '₦${NumberFormat('#,##0.00', 'en_US').format(v)}';

  @override
  Widget build(BuildContext context) {
    final stock = controller.stock;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: CustomAppBar(title: stock.ticker),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: REdgeInsets.fromLTRB(20, 8, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Price header ─────────────────────────────────
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            stock.formattedPrice,
                            style: textTheme.displaySmall?.copyWith(
                              fontFamily: 'BWGradual',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              Icon(
                                stock.isGainer
                                    ? Icons.arrow_upward_rounded
                                    : Icons.arrow_downward_rounded,
                                size: 14.r,
                                color: stock.changeColor,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                '${stock.isGainer ? '+' : ''}${_fmt(stock.changeAmount)} (${stock.formattedChange})',
                                style: textTheme.bodyMedium?.copyWith(
                                  color: stock.changeColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        padding:
                            REdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceVariant,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          'Today',
                          style: textTheme.labelSmall,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 24.h),

                  // ── Price chart ──────────────────────────────────
                  _StockPriceChart(
                    stock: stock,
                    selectedRange: controller.selectedRange,
                    onRangeChanged: controller.onRangeChanged,
                  ),

                  SizedBox(height: 28.h),

                  // ── Day's range ──────────────────────────────────
                  Text(
                    "Today's Range",
                    style: textTheme.titleSmall,
                  ),
                  SizedBox(height: 10.h),
                  _DayRangeBar(stock: stock),

                  SizedBox(height: 28.h),

                  // ── Key stats ────────────────────────────────────
                  Text(
                    'Key Statistics',
                    style: textTheme.titleSmall,
                  ),
                  SizedBox(height: 14.h),
                  _StockStatsGrid(stock: stock),

                  SizedBox(height: 28.h),

                  // ── About company ────────────────────────────────
                  Text(
                    'About ${stock.name}',
                    style: textTheme.titleSmall,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '${stock.name} (${stock.ticker}) is listed on the Nigerian Exchange Group (NGX) under the ${_sectorLabel(stock.sector)} sector. The company is one of the leading players in its industry with a market capitalisation of ₦${stock.marketCap.toStringAsFixed(2)} trillion.',
                    style: textTheme.bodyMedium?.copyWith(
                      height: 1.6,
                    ),
                  ),

                  SizedBox(height: 12.h),
                ],
              ),
            ),
          ),

          // ── Bottom action buttons ────────────────────────────────
          Container(
            padding: REdgeInsets.fromLTRB(20, 12, 20, 32),
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              border: Border(
                top: BorderSide(
                  color: colorScheme.outline.withOpacity(0.5),
                ),
              ),
            ),
            child: Row(
              children: [
                // Sell button
                Expanded(
                  child: OutlinedButton(
                    onPressed: controller.onSellTap,
                    child: const Text('Sell'),
                  ),
                ),

                SizedBox(width: 12.w),

                // Buy button
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: controller.onBuyTap,
                    child: Text('Buy ${stock.ticker}'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _sectorLabel(StockSector s) {
    switch (s) {
      case StockSector.finance:
        return 'Banking & Finance';
      case StockSector.telecoms:
        return 'Telecommunications';
      case StockSector.energy:
        return 'Oil & Energy';
      case StockSector.consumer:
        return 'Consumer Goods';
      case StockSector.technology:
        return 'Technology';
      case StockSector.health:
        return 'Healthcare';
      default:
        return 'General';
    }
  }
}

// ── Day range bar ──────────────────────────────────────────────────────────────
class _DayRangeBar extends StatelessWidget {
  final StockData stock;
  const _DayRangeBar({required this.stock});

  String _fmt(double v) =>
      stock.isNigerian ? '₦${v.toStringAsFixed(2)}' : '\$${v.toStringAsFixed(2)}';

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final range = stock.highPrice - stock.lowPrice;
    final position = range < 0.01
        ? 0.5
        : ((stock.price - stock.lowPrice) / range).clamp(0.0, 1.0);

    return Column(
      children: [
        // Progress bar
        ClipRRect(
          borderRadius: BorderRadius.circular(4.r),
          child: Stack(
            children: [
              Container(
                height: 6.h,
                color: colorScheme.surfaceVariant,
              ),
              FractionallySizedBox(
                widthFactor: position,
                child: Container(
                  height: 6.h,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFB00020),
                        AppColors.primary,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Low: ${_fmt(stock.lowPrice)}',
              style: textTheme.bodySmall,
            ),
            Text(
              'Open: ${_fmt(stock.openPrice)}',
              style: textTheme.bodySmall,
            ),
            Text(
              'High: ${_fmt(stock.highPrice)}',
              style: textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }
}