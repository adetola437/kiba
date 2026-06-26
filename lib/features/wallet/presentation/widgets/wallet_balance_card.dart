part of '../controllers/wallet_controller.dart';

class _WalletBalanceCard extends StatelessWidget {
  const _WalletBalanceCard({
    required this.balanceVisible,
    required this.onToggle,
    required this.onFund,
    required this.onWithdraw,
  });

  final bool balanceVisible;
  final VoidCallback onToggle;
  final VoidCallback onFund;
  final VoidCallback onWithdraw;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            top: -40.r,
            right: -40.r,
            child: Container(
              width: 160.r,
              height: 160.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.onPrimary.withValues(alpha: 0.04),
              ),
            ),
          ),
          Positioned(
            bottom: -20.r,
            right: 40.r,
            child: Container(
              width: 100.r,
              height: 100.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.onPrimary.withValues(alpha: 0.04),
              ),
            ),
          ),

          Padding(
            padding: REdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Label + eye toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'WALLET BALANCE',
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.surface.withValues(alpha: 0.55),
                        letterSpacing: 1.2,
                      ),
                    ),
                    GestureDetector(
                      onTap: onToggle,
                      child: Icon(
                        balanceVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: colorScheme.onPrimary.withValues(alpha: 0.55),
                        size: 18.r,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10.h),

                // Balance
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Text(
                    balanceVisible ? '₦250,000.00' : '••••••••',
                    key: ValueKey(balanceVisible),
                    style: textTheme.titleLarge?.copyWith(
                      fontSize: balanceVisible ? 32.sp : 36.sp,
                      fontWeight: FontWeight.w700,
                      color: colorScheme.surface,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                // Stats row
                Container(
                  padding: REdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: colorScheme.onPrimary.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        _StatCell(
                          value: balanceVisible ? '₦4M' : '••••',
                          label: 'Invested',
                        ),
                        VerticalDivider(
                          color: colorScheme.surface.withValues(alpha:0.15),
                          width: 1,
                          thickness: 1,
                        ),
                        _StatCell(
                          value: balanceVisible ? '₦57.6K' : '••••',
                          label: 'Accrued',
                        ),
                        VerticalDivider(
                          color: colorScheme.onPrimary.withOpacity(0.15),
                          width: 1,
                          thickness: 1,
                        ),
                        _StatCell(
                          value: balanceVisible ? '₦4.3M' : '••••',
                          label: 'Total',
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: _WalletActionButton(
                        label: '+ Fund Wallet',
                        onTap: onFund,
                        backgroundColor: colorScheme.secondary,
                        textColor: colorScheme.onSecondary,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _WalletActionButton(
                        label: '↓ Withdraw',
                        onTap: onWithdraw,
                        backgroundColor:
                            colorScheme.surface.withValues(alpha: 0.12),
                        textColor: colorScheme.onPrimary,
                        borderColor:
                            colorScheme.outline.withValues(alpha: 0.2),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCell extends StatelessWidget {
  const _StatCell({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.surface,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 3.h),
          Text(
            label,
            style: textTheme.labelSmall?.copyWith(
              color: colorScheme.onPrimary.withOpacity(0.55),
            ),
          ),
        ],
      ),
    );
  }
}

class _WalletActionButton extends StatelessWidget {
  const _WalletActionButton({
    required this.label,
    required this.onTap,
    required this.backgroundColor,
    required this.textColor,
    this.borderColor,
  });

  final String label;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(25.r),
          border: borderColor != null
              ? Border.all(color: borderColor!, width: 1)
              : null,
        ),
        child: Text(
          label,
          style: textTheme.labelLarge?.copyWith(
            color: textColor,
          ),
        ),
      ),
    );
  }
}