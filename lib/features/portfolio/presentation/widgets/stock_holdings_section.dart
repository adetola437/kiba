part of '../controllers/portfolio_controller.dart';

class StockHoldingsSection extends StatelessWidget {
  final List<StockHolding> holdings;
  final List<StockOrder> pendingOrders;
  final bool balanceVisible;
  final void Function(StockHolding) onHoldingTap;
  final void Function(StockOrder) onCancelOrder;

  const StockHoldingsSection({
    super.key,
    required this.holdings,
    required this.pendingOrders,
    required this.balanceVisible,
    required this.onHoldingTap,
    required this.onCancelOrder,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final totalValue =
        holdings.fold<double>(0, (sum, h) => sum + h.currentValue);
    final totalCost =
        holdings.fold<double>(0, (sum, h) => sum + h.costBasis);
    final totalGL = totalValue - totalCost;
    final totalGLPct = (totalGL / totalCost) * 100;
    final isProfit = totalGL >= 0;
    final glColor =
        isProfit ? const Color(0xFF1A8C5B) : const Color(0xFFB00020);
    final glBg =
        isProfit ? const Color(0xFFEAF7F1) : const Color(0xFFFCE8EB);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Summary banner ─────────────────────────────────────────
        Container(
          padding: REdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TOTAL STOCKS VALUE',
                      style: textTheme.labelSmall?.copyWith(
                        color: Colors.white.withOpacity(0.5),
                        letterSpacing: 0.7,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      balanceVisible
                          ? '₦${NumberFormat('#,##0.00').format(totalValue)}'
                          : '₦ ••••••',
                      style: textTheme.headlineSmall?.copyWith(
                        fontFamily: 'BWGradual',
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    REdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: glBg,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isProfit
                          ? Icons.arrow_upward_rounded
                          : Icons.arrow_downward_rounded,
                      size: 12.r,
                      color: glColor,
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      '${isProfit ? '+' : ''}${totalGLPct.toStringAsFixed(2)}%',
                      style: textTheme.labelSmall?.copyWith(
                        color: glColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // ── Pending limit orders ───────────────────────────────────
        if (pendingOrders.isNotEmpty) ...[
          SizedBox(height: 24.h),
          PendingOrdersSection(
            orders: pendingOrders,
            onCancel: onCancelOrder,
          ),
        ],

        SizedBox(height: 24.h),

        // ── Holdings header ────────────────────────────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Holdings',
              style: textTheme.titleLarge,
            ),
            Text(
              '${holdings.length} ${holdings.length == 1 ? 'stock' : 'stocks'}',
              style: textTheme.labelMedium?.copyWith(
                color: colorScheme.primary,
              ),
            ),
          ],
        ),

        SizedBox(height: 14.h),

        // ── Holdings list ──────────────────────────────────────────
        if (holdings.isEmpty)
          const _EmptyHoldings()
        else
          ...holdings.map(
            (h) => Padding(
              padding: REdgeInsets.only(bottom: 12),
              child: _StockHoldingCard(
                holding: h,
                balanceVisible: balanceVisible,
                onTap: () => onHoldingTap(h),
              ),
            ),
          ),
      ],
    );
  }
}

// ── Empty holdings state ───────────────────────────────────────────────────────
class _EmptyHoldings extends StatelessWidget {
  const _EmptyHoldings();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: REdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          Icon(
            Icons.show_chart_rounded,
            size: 40.r,
            color: colorScheme.primary.withOpacity(0.2),
          ),
          SizedBox(height: 10.h),
          Text(
            'No stock holdings yet.',
            style: textTheme.bodyMedium,
          ),
          SizedBox(height: 4.h),
          Text(
            'Your purchased shares will appear here.',
            style: textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

// ── Individual holding card ────────────────────────────────────────────────────
class _StockHoldingCard extends StatelessWidget {
  final StockHolding holding;
  final bool balanceVisible;
  final VoidCallback onTap;

  const _StockHoldingCard({
    required this.holding,
    required this.balanceVisible,
    required this.onTap,
  });

  String _fmt(double v) =>
      '₦${NumberFormat('#,##0.00', 'en_US').format(v)}';

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final isProfit = holding.isProfit;
    final glColor =
        isProfit ? const Color(0xFF1A8C5B) : const Color(0xFFB00020);
    final glBg =
        isProfit ? const Color(0xFFEAF7F1) : const Color(0xFFFCE8EB);
    final ticker = holding.stock.ticker;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: REdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: colorScheme.outline),
        ),
        child: Column(
          children: [
            // ── Top row ───────────────────────────────────────────
            Row(
              children: [
                Container(
                  width: 42.r,
                  height: 42.r,
                  decoration: BoxDecoration(
                    color: holding.stock.iconBg.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Text(
                      ticker.substring(0, ticker.length.clamp(0, 3)),
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w800,
                        fontSize: 9.sp,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 12.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        holding.stock.ticker,
                        style: textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        holding.stock.name,
                        style: textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      balanceVisible
                          ? _fmt(holding.currentValue)
                          : '₦ ••••••',
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      padding: REdgeInsets.symmetric(
                          horizontal: 7, vertical: 3),
                      decoration: BoxDecoration(
                        color: glBg,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        '${isProfit ? '+' : ''}${holding.gainLossPercent.toStringAsFixed(2)}%',
                        style: textTheme.labelSmall?.copyWith(
                          color: glColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 12.h),
            Divider(
              color: colorScheme.outline.withOpacity(0.5),
              height: 1,
            ),
            SizedBox(height: 10.h),

            // ── Bottom stats ──────────────────────────────────────
            Row(
              children: [
                _Stat(
                  label: 'SHARES',
                  value: holding.shares.toStringAsFixed(
                    holding.shares == holding.shares.roundToDouble() ? 0 : 2,
                  ),
                ),
                _Stat(
                  label: 'AVG. BUY',
                  value: balanceVisible
                      ? '₦${holding.avgBuyPrice.toStringAsFixed(2)}'
                      : '₦ ••••',
                ),
                _Stat(
                  label: 'P&L',
                  value: balanceVisible
                      ? '${isProfit ? '+' : ''}${_fmt(holding.gainLoss)}'
                      : '₦ ••••',
                  valueColor: glColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Stat cell ──────────────────────────────────────────────────────────────────
class _Stat extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _Stat({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontSize: 9.sp,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            value,
            style: textTheme.bodySmall?.copyWith(
              color: valueColor ?? colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}