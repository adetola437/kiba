part of '../controllers/wallet_controller.dart';

class WalletView extends StatelessWidget implements WalletViewContract {
  const WalletView({super.key, required this.controller});

  final WalletControllerContract controller;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          // ── App Bar ──────────────────────────────────────────────────
          SliverAppBar(
            backgroundColor: colorScheme.surface,
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
                      color: colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    DateFormat('MMMM d, y').format(DateTime.now()),
                    style: AppTextStyles.bodySmall.copyWith(
                      color: colorScheme.onSurfaceVariant,
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
                        color: colorScheme.onSurface,
                      ),
                    ),
                    GestureDetector(
                      onTap: controller.onSeeAllTransactions,
                      child: Text(
                        'See all',
                        style: AppTextStyles.labelMedium.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: colorScheme.outline),
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
                      Divider(color: colorScheme.outline, height: 1),
                      const _WalletTransactionItem(
                        title: 'Investment Created',
                        subtitle: 'Today, 09:15 AM',
                        amount: '-₦1M',
                        type: _TxType.debit,
                      ),
                      Divider(color: colorScheme.outline, height: 1),
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
                      color: colorScheme.onSurfaceVariant,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'SECURE & NDIC INSURED',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: colorScheme.onSurfaceVariant,
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