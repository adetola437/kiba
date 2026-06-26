part of '../controllers/stocks_controller.dart';

class StocksView extends StatelessWidget implements StocksViewContract {
  const StocksView({super.key, required this.controller});

  final StocksControllerContract controller;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ── App Bar ──────────────────────────────────────────────────
          const SliverAppBar(
            floating: true,
            snap: true,
            elevation: 0,
            scrolledUnderElevation: 0,
            titleSpacing: 0,
            automaticallyImplyLeading: false,
            title: CustomAppBar(title: 'Stocks'),
          ),

          SliverPadding(
            padding: REdgeInsets.fromLTRB(20, 8, 20, 40),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // ── Hero Banner ─────────────────────────────────────
                const _StocksHeroBanner(),

                SizedBox(height: 20.h),

                // ── Market Indices Strip ─────────────────────────────
                const _MarketIndicesStrip(),

                SizedBox(height: 24.h),

                // ── Watchlist ────────────────────────────────────────
                if (controller.watchlist.isNotEmpty) ...[
                  _StocksWatchlistSection(
                    watchlist: controller.watchlist,
                    onStockTap: controller.onStockTap,
                  ),
                  SizedBox(height: 24.h),
                ],

                // ── Section header ───────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'NGX Listed Stocks',
                      style: textTheme.titleLarge,
                    ),
                    GestureDetector(
                      onTap: controller.onSeeAllTap,
                      child: Text(
                        'See all',
                        style: textTheme.labelMedium?.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 14.h),

                // ── Sector tabs ──────────────────────────────────────
                _SectorTabs(
                  active: controller.activeSector,
                  onChanged: controller.onSectorChanged,
                ),

                SizedBox(height: 16.h),

                // ── Stock list ───────────────────────────────────────
                if (controller.isLoading) ...[
                  const _StockCardSkeleton(),
                  SizedBox(height: 12.h),
                  const _StockCardSkeleton(),
                  SizedBox(height: 12.h),
                  const _StockCardSkeleton(),
                ] else if (controller.filteredStocks.isEmpty)
                  const _EmptyStocksState()
                else ...[
                  ...controller.filteredStocks.map(
                    (stock) => Padding(
                      padding: REdgeInsets.only(bottom: 12),
                      child: _StockCard(
                        stock: stock,
                        onTap: () => controller.onStockTap(stock),
                      ),
                    ),
                  ),
                ],

                SizedBox(height: 8.h),

                // ── Disclaimer ───────────────────────────────────────
                Container(
                  padding: REdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        size: 14.r,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          'Stock prices are delayed by 15 minutes. Past performance does not guarantee future results. Investments in stocks carry risk including loss of capital.',
                          style: textTheme.bodySmall?.copyWith(
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Search bar ─────────────────────────────────────────────────────────────────
class _SearchBar extends StatelessWidget {
  final StocksControllerContract controller;
  const _SearchBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Expanded(
          child: Container(
            height: 42.h,
            decoration: BoxDecoration(
              color: colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: TextField(
              autofocus: true,
              onChanged: controller.onSearchChanged,
              style: textTheme.bodyMedium,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    REdgeInsets.symmetric(horizontal: 14, vertical: 12),
                hintText: 'Search ticker or company…',
                hintStyle: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  size: 18.r,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        GestureDetector(
          onTap: controller.onToggleSearch,
          child: Text(
            'Cancel',
            style: textTheme.labelMedium?.copyWith(
              color: colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}

// ── Empty state ────────────────────────────────────────────────────────────────
class _EmptyStocksState extends StatelessWidget {
  const _EmptyStocksState();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: REdgeInsets.symmetric(vertical: 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 48.r,
            color: colorScheme.primary.withOpacity(0.2),
          ),
          SizedBox(height: 12.h),
          Text(
            'No stocks match your search.',
            style: textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}