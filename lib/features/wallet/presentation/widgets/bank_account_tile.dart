part of '../controllers/withdraw_destination_controller.dart';

class _BankAccountTile extends StatelessWidget {
  const _BankAccountTile({
    required this.account,
    required this.isSelected,
    required this.onTap,
  });

  final LinkedBankAccount account;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: REdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.04)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          children: [
            // Bank icon
            Container(
              width: 44.r,
              height: 44.r,
              decoration: BoxDecoration(
                color: account.brandColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                Icons.account_balance_outlined,
                size: 20.r,
                color: account.brandColor,
              ),
            ),
            SizedBox(width: 14.w),

            // Account details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    account.bankName,
                    style: AppTextStyles.titleSmall.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    account.maskedNumber,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                      fontFamily: 'EuclidCircularA',
                      letterSpacing: 1.0,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    account.accountName,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.textDisabled,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),

            // Radio indicator
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22.r,
              height: 22.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColors.primary : Colors.transparent,
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.border,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Icon(Icons.check_rounded, size: 12.r, color: AppColors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
