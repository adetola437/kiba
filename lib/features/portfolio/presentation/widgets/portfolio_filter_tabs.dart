part of '../controllers/portfolio_controller.dart';

class _PortfolioFilterTabs extends StatelessWidget {
  final PortfolioFilter active;
  final ValueChanged<PortfolioFilter> onChanged;
  final int allCount;
  final int activeCount;
  final int maturedCount;
  final int? stocksCount; // null = don't show the tab

  const _PortfolioFilterTabs({
    required this.active,
    required this.onChanged,
    required this.allCount,
    required this.activeCount,
    required this.maturedCount,
    this.stocksCount,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final tabs = [
      (filter: PortfolioFilter.all, label: 'All ($allCount)'),
      (filter: PortfolioFilter.active, label: 'Active ($activeCount)'),
      (filter: PortfolioFilter.matured, label: 'Matured ($maturedCount)'),
      if (stocksCount != null)
        (filter: PortfolioFilter.stocks, label: 'Stocks ($stocksCount)'),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: tabs.map((t) {
          final isActive = t.filter == active;
          return Padding(
            padding: REdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () => onChanged(t.filter),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding:
                    REdgeInsets.symmetric(horizontal: 18, vertical: 9),
                decoration: BoxDecoration(
                  color: isActive ? colorScheme.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isActive
                        ? colorScheme.primary
                        : colorScheme.outline.withOpacity(0.5),
                    width: 1.5,
                  ),
                ),
                child: Text(
                  t.label,
                  style: textTheme.labelMedium?.copyWith(
                    color:
                        isActive ? colorScheme.onPrimary : colorScheme.onSurfaceVariant,
                    fontWeight:
                        isActive ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}