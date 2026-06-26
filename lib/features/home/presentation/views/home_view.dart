part of '../controllers/home_controller.dart';

class HomeView extends StatelessWidget implements HomeViewContract {
  const HomeView({super.key, required this.controller});

  final HomeControllerContract controller;

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
            title: Padding(
              padding: REdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  // Avatar
                  Container(
                    width: 40.r,
                    height: 40.r,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        'I',
                        style: AppTextStyles.titleMedium.copyWith(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.greeting,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        Text(
                          'Ismail',
                          style: AppTextStyles.titleMedium.copyWith(
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Notification bell
                  GestureDetector(
                    onTap: controller.onNotificationTap,
                    child: Stack(
                      children: [
                        Container(
                          width: 40.r,
                          height: 40.r,
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceVariant,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.notifications_outlined,
                            size: 20.r,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        Positioned(
                          top: 8.r,
                          right: 8.r,
                          child: Container(
                            width: 8.r,
                            height: 8.r,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: REdgeInsets.fromLTRB(20, 8, 20, 32),
            sliver: SliverList(
              delegate: SliverChildListDelegate([

                // ── Upgrade tier banner ────────────────────────────────
                GestureDetector(
                  onTap: controller.onUpgradeTier,
                  child: Container(
                    padding: REdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: colorScheme.outline),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.verified_outlined,
                          size: 18.r,
                          color: colorScheme.primary,
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            'Upgrade to Tier 2 for higher limits',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: colorScheme.onSurface,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          size: 18.r,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 16.h),

                // ── Portfolio card ─────────────────────────────────────
                _PortfolioCard(
                  balanceVisible: controller.balanceVisible,
                  onToggle: controller.onToggleBalance,
                  onFund: controller.onFundWallet,
                  onWithdraw: controller.onWithdraw,
                ),

                SizedBox(height: 12.h),

                // ── Mini info strip ────────────────────────────────────
                // Pill backgrounds are intentional brand-tinted accents,
                // not adaptive surfaces — kept as brand colours with opacity.
                Row(
                  children: [
                    Container(
                      padding: REdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.limeGreen.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_upward_rounded,
                            size: 12.r,
                            color: colorScheme.primary,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '+₦1,920 today',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Container(
                      padding: REdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.beigePink.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 12.r,
                            color: colorScheme.onSurface,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'Next Payout: 15 Oct',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: colorScheme.onSurface,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 28.h),

                // ── Quick Actions ──────────────────────────────────────
                Text(
                  'Quick Actions',
                  style: AppTextStyles.titleLarge.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 16.h),
                _QuickActions(onAction: controller.onQuickAction),

                SizedBox(height: 28.h),

                // ── Active Investments ─────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Active Investments',
                      style: AppTextStyles.titleLarge.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),
                    GestureDetector(
                      onTap: controller.onSeeAllInvestments,
                      child: Text(
                        'See all',
                        style: AppTextStyles.labelMedium.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 14.h),
                const _ActiveInvestmentCard(),

                SizedBox(height: 28.h),

                // ── Special Contribution / Beige Club ──────────────────
                Text(
                  'Special Contribution',
                  style: AppTextStyles.titleLarge.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 14.h),
                _BeigeClubBanner(onTap: controller.onEnterBeigeClub),

                SizedBox(height: 28.h),

                // ── Recent Activities ──────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Activities',
                      style: AppTextStyles.titleLarge.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),
                    GestureDetector(
                      onTap: controller.onViewHistory,
                      child: Text(
                        'View History',
                        style: AppTextStyles.labelMedium.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),

                const _RecentActivityItem(
                  icon: Icons.account_balance_wallet_outlined,
                  title: 'Wallet Funded',
                  subtitle: 'Oct 12, 2026 · 09:45 AM',
                  amount: '+₦50,000',
                  isCredit: true,
                ),
                Divider(color: colorScheme.outline, height: 1),
                const _RecentActivityItem(
                  icon: Icons.trending_up_rounded,
                  title: 'Interest Earned (PMPS)',
                  subtitle: 'Oct 11, 2026 · Daily Payout',
                  amount: '+₦1,920',
                  isCredit: true,
                ),
                Divider(color: colorScheme.outline, height: 1),
                const _RecentActivityItem(
                  icon: Icons.add_chart_rounded,
                  title: 'New Investment: PMPS',
                  subtitle: 'Oct 05, 2026 · 02:15 PM',
                  amount: '-₦1,000,000',
                  isCredit: false,
                ),

                SizedBox(height: 28.h),

                // ── Market Insights ────────────────────────────────────
                Text(
                  'Market Insights',
                  style: AppTextStyles.titleLarge.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 14.h),

                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  child: Row(
                    children: [
                      _MarketInsightCard(
                        category: 'MARKET UPDATE',
                        headline:
                            "Nigeria's Treasury Bills rate climbs to 18% as inflation...",
                        timeAgo: '3 hours ago',
                        readTime: '5 min',
                      ),
                      _MarketInsightCard(
                        category: 'WEALTH TIP',
                        headline:
                            'Diversifying your portfolio at high interest rate environments',
                        timeAgo: 'Yesterday',
                        readTime: '3 min',
                      ),
                      _MarketInsightCard(
                        category: 'ECONOMY',
                        headline:
                            'CBN holds rates steady — what this means for fixed income investors',
                        timeAgo: '2 days ago',
                        readTime: '4 min',
                      ),
                    ],
                  ),
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