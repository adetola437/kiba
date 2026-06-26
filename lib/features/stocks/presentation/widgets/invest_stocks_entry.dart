// lib/features/invest/presentation/widgets/invest_stocks_entry.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../stocks/presentation/controllers/stocks_controller.dart';
import '../../data/stocks_data.dart';

// ── Tab switcher ───────────────────────────────────────────────────────────────

class InvestTabSwitcher extends StatelessWidget {
  final TabController tabController;

  const InvestTabSwitcher({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: 40.h,
      padding: REdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TabBar(
        controller: tabController,
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(
          color: colorScheme.primary,
          borderRadius: BorderRadius.circular(9.r),
          boxShadow: [
            BoxShadow(
              color: colorScheme.primary.withValues(alpha: 0.2),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w400,
        ),
        labelColor: colorScheme.onPrimary,
        unselectedLabelColor: colorScheme.onSurfaceVariant,
        tabs: const [
          Tab(text: 'Fixed Income'),
          Tab(text: 'Stocks'),
        ],
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _Tab({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? colorScheme.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(9.r),
          ),
          child: Text(
            label,
            style: textTheme.labelSmall?.copyWith(
              color: isActive ? colorScheme.onPrimary : colorScheme.onSurfaceVariant,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

// ── Stocks entry card (shown when Stocks tab is active) ────────────────────────

class InvestStocksEntry extends StatelessWidget {
  const InvestStocksEntry({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Top movers preview ─────────────────────────────────────
        Text(
          'Top Movers Today',
          style: textTheme.titleLarge,
        ),

        SizedBox(height: 12.h),

        // Show 3 preview cards (read-only, no sparkline interaction)
        ...kNgxStocks.take(3).map((stock) => _PreviewStockRow(stock: stock)),

        SizedBox(height: 20.h),

        // ── CTA banner ─────────────────────────────────────────────
        GestureDetector(
          onTap: () => context.pushNamed(StocksScreen.route),
          child: Container(
            width: double.infinity,
            padding: REdgeInsets.all(20),
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: BorderRadius.circular(18.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Browse all NGX stocks',
                        style: textTheme.titleMedium?.copyWith(
                          color: colorScheme.onPrimary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Market orders, limit orders,\nreal-time prices.',
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onPrimary.withValues(alpha: 0.6),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 44.r,
                  height: 44.r,
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    size: 20.r,
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ── Lightweight read-only stock row ───────────────────────────────────────────

class _PreviewStockRow extends StatelessWidget {
  final StockData stock;
  const _PreviewStockRow({required this.stock});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: REdgeInsets.only(bottom: 10),
      child: Container(
        padding: REdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: colorScheme.outline),
        ),
        child: Row(
          children: [
            Container(
              width: 38.r,
              height: 38.r,
              decoration: BoxDecoration(
                color: stock.iconBg.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                child: Text(
                  stock.ticker.substring(0, stock.ticker.length.clamp(0, 3)),
                  style: textTheme.labelSmall?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w800,
                    fontSize: 8.sp,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                stock.name,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  stock.formattedPrice,
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  stock.formattedChange,
                  style: textTheme.labelSmall?.copyWith(
                    color: stock.changeColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}