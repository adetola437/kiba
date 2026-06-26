part of '../controllers/invest_controller.dart';

class _InvestCategoryTabs extends StatelessWidget {
  const _InvestCategoryTabs({
    required this.active,
    required this.onChanged,
  });

  final InvestCategory active;
  final ValueChanged<InvestCategory> onChanged;

  static const _tabs = [
    (category: InvestCategory.all, label: 'All'),
    (category: InvestCategory.savings, label: 'Savings'),
    (category: InvestCategory.fixedIncome, label: 'Fixed Income'),
    (category: InvestCategory.government, label: 'Government'),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _tabs.map((t) {
          final isActive = t.category == active;
          return Padding(
            padding: REdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () => onChanged(t.category),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                padding: REdgeInsets.symmetric(horizontal: 18, vertical: 9),
                decoration: BoxDecoration(
                  color: isActive ? colorScheme.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isActive
                        ? colorScheme.primary
                        : colorScheme.outline,
                    width: 1.5,
                  ),
                ),
                child: Text(
                  t.label,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: isActive
                        ? colorScheme.onPrimary
                        : colorScheme.onSurfaceVariant,
                    fontWeight: isActive
                        ? FontWeight.w600
                        : FontWeight.w400,
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