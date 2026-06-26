part of '../controllers/invest_controller.dart';

class InvestView extends StatelessWidget implements InvestViewContract {
  const InvestView({super.key, required this.controller});

  final InvestControllerContract controller;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── App bar ──────────────────────────────────────────────
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Text(
                'Invest',
                style: AppTextStyles.headlineMedium.copyWith(
                  color: colorScheme.onBackground,
                ),
              ),
            ),

            // ── Hero banner (static) ─────────────────────────────────
            Padding(
              padding: REdgeInsets.fromLTRB(20, 8, 20, 0),
              child: const _InvestHeroBanner(),
            ),

            SizedBox(height: 20.h),

            // ── Tab bar (static) ─────────────────────────────────────
            Container(
              color: colorScheme.surface,
              padding: REdgeInsets.fromLTRB(20, 8, 20, 8),
              child: InvestTabSwitcher(
                tabController: controller.tabController,
              ),
            ),

            // ── Tab views (scrollable, fills remaining space) ────────
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: [
                  // ── Tab 0: Fixed Income ──────────────────────────
                  _FixedIncomeTab(controller: controller),

                  // ── Tab 1: Stocks ────────────────────────────────
                  const _StocksTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Fixed Income tab body ──────────────────────────────────────────────────────
class _FixedIncomeTab extends StatelessWidget {
  final InvestControllerContract controller;
  const _FixedIncomeTab({required this.controller});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListView(
      padding: REdgeInsets.fromLTRB(20, 16, 20, 40),
      children: [
        if (controller.isLoading) ...[
          const _InvestProductSkeleton(),
          SizedBox(height: 16.h),
          const _InvestProductSkeleton(),
        ] else if (controller.filteredProducts.isEmpty)
          const _EmptyCategory()
        else ...[
          ...controller.filteredProducts.map(
            (product) => Padding(
              padding: REdgeInsets.only(bottom: 16),
              child: _InvestProductCard(
                product: product,
                onTap: () => controller.onProductTap(product),
                onCta: () => controller.onPrimaryAction(product),
              ),
            ),
          ),
        ],

        SizedBox(height: 8.h),

        // ── Rate guide link ──────────────────────────────────────
        if (!controller.isLoading)
          GestureDetector(
            onTap: controller.onViewRateGuide,
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: REdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: colorScheme.outline),
              ),
              child: Row(
                children: [
                  Container(
                    width: 36.r,
                    height: 36.r,
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Icons.menu_book_outlined,
                      size: 18.r,
                      color: colorScheme.primary,
                    ),
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'View full rate guide & minimum amounts',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'All products, rates & terms',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: colorScheme.onSurface.withValues(alpha: 0.38),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 20.r,
                    color: colorScheme.onSurface.withValues(alpha: 0.38),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

// ── Stocks tab body ────────────────────────────────────────────────────────────
class _StocksTab extends StatelessWidget {
  const _StocksTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: REdgeInsets.only(bottom: 40, left: 20, right: 20),
      child: const InvestStocksEntry(),
    );
  }
}

// ── Pinned tab bar delegate ────────────────────────────────────────────────────
class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  const _TabBarDelegate({required this.child});

  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      child;

  @override
  double get maxExtent => 56;

  @override
  double get minExtent => 56;

  @override
  bool shouldRebuild(_TabBarDelegate old) => old.child != child;
}

// ── Empty state ────────────────────────────────────────────────────────────────
class _EmptyCategory extends StatelessWidget {
  const _EmptyCategory();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: REdgeInsets.symmetric(vertical: 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 48.r,
            color: colorScheme.primary.withValues(alpha: 0.2),
          ),
          SizedBox(height: 12.h),
          Text(
            'No products in this category yet.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}