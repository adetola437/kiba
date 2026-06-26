part of '../controllers/portfolio_controller.dart';

class PortfolioView extends StatelessWidget implements PortfolioViewContract {
  const PortfolioView({super.key, required this.controller});

  final PortfolioControllerContract controller;

  // ── counts ─────────────────────────────────────────────────────────────────
  int get _allCount => kInvestments.length;
  int get _activeCount => kInvestments.where((i) => !i.isMatured).length;
  int get _maturedCount => kInvestments.where((i) => i.isMatured).length;
  int get _stocksCount => controller.stockHoldings.length;

  String _sortLabel(PortfolioSort s) {
    switch (s) {
      case PortfolioSort.maturityDate:   return 'Maturity date';
      case PortfolioSort.amountInvested: return 'Amount invested';
      case PortfolioSort.returns:        return 'Returns';
      case PortfolioSort.dateCreated:    return 'Date created';
    }
  }

  void _showSortSheet(
    BuildContext context,
    PortfolioControllerContract ctrl,
    ColorScheme colorScheme,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => Padding(
        padding: REdgeInsets.fromLTRB(24, 8, 24, 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                margin: REdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: colorScheme.outline,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            Text(
              'Sort investments by',
              style: AppTextStyles.titleLarge.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 16.h),
            ...PortfolioSort.values.map((s) {
              final isSelected = ctrl.activeSort == s;
              return GestureDetector(
                onTap: () => ctrl.onSortChanged(s),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: REdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: colorScheme.outline,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _sortLabel(s),
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: isSelected
                              ? colorScheme.primary
                              : colorScheme.onSurface,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          Icons.check_rounded,
                          size: 18.r,
                          color: colorScheme.primary,
                        ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isStocksTab = controller.activeFilter == PortfolioFilter.stocks;
    final investments = controller.filteredInvestments;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          // ── App Bar ──────────────────────────────────────────────────
          SliverAppBar(
            backgroundColor: colorScheme.surface,
            floating: true,
            snap: true,
            elevation: 0,
            scrolledUnderElevation: 0,
            titleSpacing: 0,
            automaticallyImplyLeading: false,
            title: Padding(
              padding: REdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My Portfolio',
                    style: AppTextStyles.headlineMedium.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    DateFormat('EEEE, d MMMM y').format(DateTime.now()),
                    style: AppTextStyles.bodySmall.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: REdgeInsets.fromLTRB(20, 12, 20, 32),
            sliver: SliverList(
              delegate: SliverChildListDelegate([

                // ── Stats card ────────────────────────────────────────
                _PortfolioStatsCard(
                  balanceVisible: controller.balanceVisible,
                  onToggle: controller.onToggleBalance,
                ),

                SizedBox(height: 20.h),

                // ── Filter tabs (All / Active / Matured / Stocks) ─────
                _PortfolioFilterTabs(
                  active: controller.activeFilter,
                  onChanged: controller.onFilterChanged,
                  allCount: _allCount,
                  activeCount: _activeCount,
                  maturedCount: _maturedCount,
                  stocksCount: controller.hasStocks ? _stocksCount : null,
                ),

                SizedBox(height: 24.h),

                // ── Stocks tab ────────────────────────────────────────
                if (isStocksTab) ...[
                  StockHoldingsSection(
                    holdings: controller.stockHoldings,
                    pendingOrders: controller.pendingOrders,
                    balanceVisible: controller.balanceVisible,
                    onHoldingTap: controller.onStockHoldingTap,
                    onCancelOrder: controller.onCancelOrder,
                  ),
                ] else ...[
                  // ── Investments section header ─────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Investments',
                        style: AppTextStyles.titleLarge.copyWith(
                          color: colorScheme.onSurface,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _showSortSheet(
                          context,
                          controller,
                          colorScheme,
                        ),
                        behavior: HitTestBehavior.opaque,
                        child: Row(
                          children: [
                            Icon(
                              Icons.sort_rounded,
                              size: 16.r,
                              color: colorScheme.primary,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              'Sort by ${_sortLabel(controller.activeSort).toLowerCase()}',
                              style: AppTextStyles.labelMedium.copyWith(
                                color: colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 14.h),

                  // ── Investment list or empty state ─────────────────
                  if (investments.isEmpty)
                    _PortfolioEmptyState(
                      filter: controller.activeFilter,
                      onInvest: controller.onNewInvestment,
                    )
                  else
                    ...investments.map((inv) => Padding(
                          padding: REdgeInsets.only(bottom: 14),
                          child: _InvestmentCard(
                            data: inv,
                            balanceVisible: controller.balanceVisible,
                            onTap: () => controller.onInvestmentTap(inv),
                          ),
                        )),
                ],
              ]),
            ),
          ),
        ],
      ),
    );
  }
}