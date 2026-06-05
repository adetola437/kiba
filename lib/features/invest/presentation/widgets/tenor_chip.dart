part of '../controllers/new_investment_controller.dart';

class _TenorChip extends StatelessWidget {
  const _TenorChip({
    required this.tenor,
    required this.isSelected,
    required this.onTap,
  });

  final TenorOption tenor;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: REdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.buttonBorder,
            width: isSelected ? 2 : 1.5,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              tenor.label,
              style: AppTextStyles.labelSmall.copyWith(
                color: isSelected
                    ? AppColors.white.withOpacity(0.75)
                    : AppColors.textSecondary,
                letterSpacing: 0.4,
                fontSize: 10.sp,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              '+${tenor.rate}%',
              style: AppTextStyles.titleSmall.copyWith(
                color: isSelected ? AppColors.limeGreen : AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'p.a.',
              style: AppTextStyles.labelSmall.copyWith(
                color: isSelected
                    ? AppColors.white.withOpacity(0.55)
                    : AppColors.textDisabled,
                fontSize: 9.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}