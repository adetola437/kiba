part of '../controllers/wallet_controller.dart';

class WalletView extends StatelessWidget implements WalletViewContract {
  const WalletView({super.key, required this.controller});

  final WalletControllerContract controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // ── App Bar ──────────────────────────────────────────────────
          SliverAppBar(
            backgroundColor: AppColors.background,
            floating: true,
            snap: true,
            elevation: 0,
            scrolledUnderElevation: 0,
            titleSpacing: 0,
            automaticallyImplyLeading: false,
            title: Padding(
              padding: REdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My Wallet',
                    style: AppTextStyles.headlineMedium.copyWith(
                      fontFamily: 'BWGradual',
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    DateFormat('MMMM d, y').format(DateTime.now()),
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: REdgeInsets.fromLTRB(20, 12, 20, 32),
            sliver: SliverList(
              delegate: SliverChildListDelegate([

                // ── Balance card ───────────────────────────────────────
                _WalletBalanceCard(
                  balanceVisible: controller.balanceVisible,
                  onToggle: controller.onToggleBalance,
                  onFund: controller.onFund,
                  onWithdraw: controller.onWithdraw,
                ),

                SizedBox(height: 20.h),

                // ── Virtual account ────────────────────────────────────
                _VirtualAccountCard(onCopy: controller.onCopyAccountNumber),

                SizedBox(height: 28.h),

                // ── Recent Transactions ────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Transactions',
                      style: AppTextStyles.titleLarge.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    GestureDetector(
                      onTap: controller.onSeeAllTransactions,
                      child: Text(
                        'See all',
                        style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: AppColors.border),
                  ),
                  padding: REdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const _WalletTransactionItem(
                        title: 'Wallet Funded',
                        subtitle: 'Today, 10:42 AM',
                        amount: '+₦500K',
                        type: _TxType.credit,
                      ),
                      Divider(color: AppColors.divider, height: 1),
                      const _WalletTransactionItem(
                        title: 'Investment Created',
                        subtitle: 'Today, 09:15 AM',
                        amount: '-₦1M',
                        type: _TxType.debit,
                      ),
                      Divider(color: AppColors.divider, height: 1),
                      const _WalletTransactionItem(
                        title: 'Interest Earned',
                        subtitle: 'Yesterday, 10:00 AM',
                        amount: '+₦1.9K',
                        type: _TxType.neutral,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 28.h),

                // ── Trust badge ────────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.security_outlined,
                      size: 14.r,
                      color: AppColors.textDisabled,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'SECURE & NDIC INSURED',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.textDisabled,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}