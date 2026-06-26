part of '../controllers/stock_order_controller.dart';

class _OrderModeToggle extends StatelessWidget {
  final StockOrderMode active;
  final ValueChanged<StockOrderMode> onChanged;

  const _OrderModeToggle({required this.active, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: 44.h,
      padding: REdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: StockOrderMode.values.map((mode) {
          final isActive = mode == active;
          final label =
              mode == StockOrderMode.market ? 'Market Order' : 'Limit Order';
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(mode),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isActive ? colorScheme.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(9.r),
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: colorScheme.primary.withOpacity(0.2),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          )
                        ]
                      : null,
                ),
                child: Text(
                  label,
                  style: textTheme.labelSmall?.copyWith(
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