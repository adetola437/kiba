part of '../controllers/wallet_controller.dart';

class _VirtualAccountCard extends StatelessWidget {
  const _VirtualAccountCard({required this.onCopy});

  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: REdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(
                Icons.account_balance_outlined,
                size: 16.r,
                color: colorScheme.primary,
              ),
              SizedBox(width: 6.w),
              Text(
                'YOUR VIRTUAL ACCOUNT',
                style: textTheme.labelSmall?.copyWith(
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),

          SizedBox(height: 14.h),

          // Bank name + Copy button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Providus Bank',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: onCopy,
                child: Container(
                  padding:
                      REdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.copy_rounded,
                        size: 14.r,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        'Copy',
                        style: textTheme.labelSmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),
          const Divider(height: 1),
          SizedBox(height: 14.h),

          // Account Number
          Text(
            'Account Number',
            style: textTheme.bodySmall,
          ),
          SizedBox(height: 4.h),
          Text(
            '9901234567',
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
            ),
          ),

          SizedBox(height: 14.h),

          // Account Name
          Text(
            'Account Name',
            style: textTheme.bodySmall,
          ),
          SizedBox(height: 4.h),
          Text(
            'Beige Africa / Ismail Adamu',
            style: textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}