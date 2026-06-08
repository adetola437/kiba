part of '../controllers/fund_ussd_controller.dart';

class _UssdBankTile extends StatelessWidget {
  const _UssdBankTile({required this.bank, required this.onTap});

  final _UssdBank bank;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: REdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            // Bank avatar
            Container(
              width: 40.r,
              height: 40.r,
              decoration: BoxDecoration(
                color: bank.color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                child: Text(
                  bank.name[0],
                  style: TextStyle(
                    fontFamily: 'BWGradual',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: bank.color,
                  ),
                ),
              ),
            ),
            SizedBox(width: 14.w),

            Expanded(
              child: Text(
                bank.name,
                style: AppTextStyles.titleSmall.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14.r,
              color: AppColors.textDisabled,
            ),
          ],
        ),
      ),
    );
  }
}