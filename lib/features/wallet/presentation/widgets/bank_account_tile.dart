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
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: REdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primary.withOpacity(0.04)
              : colorScheme.surface,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected ? colorScheme.primary : colorScheme.outline,
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
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    account.maskedNumber,
                    style: textTheme.bodySmall?.copyWith(
                      letterSpacing: 1.0,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    account.accountName,
                    style: textTheme.labelSmall,
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
                color: isSelected ? colorScheme.primary : Colors.transparent,
                border: Border.all(
                  color: isSelected ? colorScheme.primary : colorScheme.outline,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Icon(
                      Icons.check_rounded,
                      size: 12.r,
                      color: colorScheme.onPrimary,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}