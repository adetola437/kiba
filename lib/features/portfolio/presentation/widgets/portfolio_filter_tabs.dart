part of '../controllers/portfolio_controller.dart';

class _PortfolioFilterTabs extends StatelessWidget {
  const _PortfolioFilterTabs({
    required this.active,
    required this.onChanged,
    required this.allCount,
    required this.activeCount,
    required this.maturedCount,
  });

  final PortfolioFilter active;
  final ValueChanged<PortfolioFilter> onChanged;
  final int allCount;
  final int activeCount;
  final int maturedCount;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _FilterChip(
            label: 'All ($allCount)',
            isActive: active == PortfolioFilter.all,
            onTap: () => onChanged(PortfolioFilter.all),
          ),
          SizedBox(width: 10.w),
          _FilterChip(
            label: 'Active ($activeCount)',
            isActive: active == PortfolioFilter.active,
            onTap: () => onChanged(PortfolioFilter.active),
          ),
          SizedBox(width: 10.w),
          _FilterChip(
            label: 'Matured ($maturedCount)',
            isActive: active == PortfolioFilter.matured,
            onTap: () => onChanged(PortfolioFilter.matured),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: REdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isActive ? AppColors.primary : AppColors.buttonBorder,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.labelMedium.copyWith(
            color: isActive ? AppColors.white : AppColors.textSecondary,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}