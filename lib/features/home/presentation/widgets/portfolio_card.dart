part of '../controllers/home_controller.dart';

class _PortfolioCard extends StatelessWidget {
  const _PortfolioCard({
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
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Stack(
        children: [
          // Decorative circle top-right
          Positioned(
            top: -30.r,
            right: -30.r,
            child: Container(
              width: 130.r,
              height: 130.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          Positioned(
            top: 20.r,
            right: 20.r,
            child: Container(
              width: 80.r,
              height: 80.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),

          Padding(
            padding: REdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Label
                Text(
                  'TOTAL PORTFOLIO',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.white.withOpacity(0.55),
                    letterSpacing: 1.2,
                  ),
                ),

                SizedBox(height: 8.h),

                // Balance row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: Text(
                          balanceVisible ? '₦4,250,000.00' : '••••••••',
                          key: ValueKey(balanceVisible),
                          style: TextStyle(
                            fontFamily: 'EuclidCircularA',
                            fontSize: balanceVisible ? 28.sp : 32.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: onToggle,
                      child: Icon(
                        balanceVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: AppColors.white.withOpacity(0.6),
                        size: 20.r,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 6.h),

                // Cash balance chip
                Container(
                  padding: REdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    'CASH BALANCE: ₦250,400.00',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.white.withOpacity(0.75),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                // Stats row
                Row(
                  children: [
                    _StatChip(
                      label: 'LIFETIME ACCRUED',
                      value: '+₦185,200.50',
                      valueColor: AppColors.limeGreen,
                    ),
                    SizedBox(width: 12.w),
                    _StatChip(
                      label: 'CURRENT ROI',
                      value: '17.00% p.a.',
                      valueColor: AppColors.limeGreen,
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: _CardButton(
                        label: '+ Fund Wallet',
                        onTap: onFund,
                        filled: true,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _CardButton(
                        label: '↗ Withdraw',
                        onTap: onWithdraw,
                        filled: false,
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

class _StatChip extends StatelessWidget {
  const _StatChip({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.white.withOpacity(0.5),
            letterSpacing: 0.6,
            fontSize: 9.sp,
          ),
        ),
        SizedBox(height: 3.h),
        Text(
          value,
          style: AppTextStyles.titleSmall.copyWith(
            color: valueColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _CardButton extends StatelessWidget {
  const _CardButton({
    required this.label,
    required this.onTap,
    required this.filled,
  });

  final String label;
  final VoidCallback onTap;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: filled ? AppColors.white.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: AppColors.white.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.labelMedium.copyWith(
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}