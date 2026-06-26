part of '../controllers/home_controller.dart';

class _QuickActions extends StatelessWidget {
  const _QuickActions({required this.onAction});

  final ValueChanged<QuickAction> onAction;

  static const _actions = [
    (action: QuickAction.fund,     icon: Icons.account_balance_outlined, label: 'Fund'),
    (action: QuickAction.withdraw, icon: Icons.arrow_upward_rounded,    label: 'Withdraw'),
    (action: QuickAction.invest,   icon: Icons.trending_up_rounded,      label: 'Invest'),
    (action: QuickAction.history,  icon: Icons.history_rounded,          label: 'History'),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _actions.map((item) {
        return GestureDetector(
          onTap: () => onAction(item.action),
          behavior: HitTestBehavior.opaque,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56.r,
                height: 56.r,
                decoration: BoxDecoration(
                  color: colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Icon(
                  item.icon,
                  size: 22.r,
                  color: colorScheme.primary,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                item.label,
                style: AppTextStyles.labelSmall.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}