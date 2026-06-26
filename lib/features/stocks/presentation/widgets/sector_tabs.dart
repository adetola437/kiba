part of '../controllers/stocks_controller.dart';

class _SectorTabs extends StatelessWidget {
  const _SectorTabs({required this.active, required this.onChanged});

  final StockSector active;
  final ValueChanged<StockSector> onChanged;

  static const _tabs = [
    (sector: StockSector.all, label: 'All'),
    (sector: StockSector.finance, label: 'Banking'),
    (sector: StockSector.telecoms, label: 'Telecoms'),
    (sector: StockSector.energy, label: 'Energy'),
    (sector: StockSector.consumer, label: 'Consumer'),
    (sector: StockSector.technology, label: 'Tech'),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _tabs.map((t) {
          final isActive = t.sector == active;
          return Padding(
            padding: REdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () => onChanged(t.sector),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                padding: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isActive ? colorScheme.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isActive ? colorScheme.primary : colorScheme.outline,
                    width: 1.5,
                  ),
                ),
                child: Text(
                  t.label,
                  style: textTheme.labelMedium?.copyWith(
                    color: isActive
                        ? colorScheme.onPrimary
                        : colorScheme.onSurfaceVariant,
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