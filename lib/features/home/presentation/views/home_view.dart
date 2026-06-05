part of '../controllers/home_controller.dart';

class HomeView extends StatelessWidget implements HomeViewContract {
  const HomeView({super.key, required this.controller});

  final HomeControllerContract controller;

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
            title: Padding(
              padding: REdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  // Avatar
                  Container(
                    width: 40.r,
                    height: 40.r,
                    decoration:const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        'I',
                        style: AppTextStyles.titleMedium.copyWith(
                          color: AppColors.white,
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
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          'Ismail',
                          style: AppTextStyles.titleMedium.copyWith(
                            color: AppColors.textPrimary,
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
                            color: AppColors.surfaceVariant,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.notifications_outlined,
                            size: 20.r,
                            color: AppColors.textPrimary,
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
                Container(
                  padding: REdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.verified_outlined,
                        size: 18.r,
                        color: AppColors.primary,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          'Upgrade to Tier 2 for higher limits',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 18.r,
                        color: AppColors.textDisabled,
                      ),
                    ],
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
                Row(
                  children: [
                    Container(
                      padding: REdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.limeGreen.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_upward_rounded,
                            size: 12.r,
                            color: AppColors.primary,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '+₦1,920 today',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Container(
                      padding: REdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.beigePink.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 12.r,
                            color: AppColors.charcoalGrey,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'Next Payout: 15 Oct',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.charcoalGrey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 12.h),

                // ── Maturity banner ────────────────────────────────────
                Container(
                  padding: REdgeInsets.symmetric(
                      horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.moodyBlue.withOpacity(0.07),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColors.moodyBlue.withOpacity(0.15),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 32.r,
                        height: 32.r,
                        decoration: BoxDecoration(
                          color: AppColors.moodyBlue.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Icons.hourglass_bottom_rounded,
                          size: 16.r,
                          color: AppColors.moodyBlue,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Next Maturity in 12 Days',
                              style: AppTextStyles.titleSmall.copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              'PMPS — 180 Days (₦1.0M)',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 18.r,
                        color: AppColors.textDisabled,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 28.h),

                // ── Quick Actions ──────────────────────────────────────
                Text(
                  'Quick Actions',
                  style: AppTextStyles.titleLarge.copyWith(
                    color: AppColors.textPrimary,
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
                        color: AppColors.textPrimary,
                      ),
                    ),
                    GestureDetector(
                      onTap: controller.onSeeAllInvestments,
                      child: Text(
                        'See all',
                        style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.primary,
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
                    color: AppColors.textPrimary,
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
                        color: AppColors.textPrimary,
                      ),
                    ),
                    GestureDetector(
                      onTap: controller.onViewHistory,
                      child: Text(
                        'View History',
                        style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.primary,
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
              const  Divider(color: AppColors.divider, height: 1),
                const _RecentActivityItem(
                  icon: Icons.trending_up_rounded,
                  title: 'Interest Earned (PMPS)',
                  subtitle: 'Oct 11, 2026 · Daily Payout',
                  amount: '+₦1,920',
                  isCredit: true,
                ),
               const Divider(color: AppColors.divider, height: 1),
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
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 14.h),

               const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  child: Row(
                    children:  [
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