part of '../controllers/invest_controller.dart';

class InvestView extends StatelessWidget implements InvestViewContract {
  const InvestView({super.key, required this.controller});

  final InvestControllerContract controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // ── App Bar ────────────────────────────────────────────────
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
              child: Text(
                'Invest',
                style: AppTextStyles.headlineMedium.copyWith(
                  fontFamily: 'BWGradual',
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: REdgeInsets.fromLTRB(20, 8, 20, 40),
            sliver: SliverList(
              delegate: SliverChildListDelegate([

                // ── Hero banner ──────────────────────────────────────
                const _InvestHeroBanner(),

                SizedBox(height: 24.h),

                // ── Category tabs ────────────────────────────────────
                _InvestCategoryTabs(
                  active: controller.activeCategory,
                  onChanged: controller.onCategoryChanged,
                ),

                SizedBox(height: 24.h),

                // ── Product list ─────────────────────────────────────
                if (controller.isLoading) ...[
                  const _InvestProductSkeleton(),
                  SizedBox(height: 16.h),
                  const _InvestProductSkeleton(),
                ] else if (controller.filteredProducts.isEmpty)
                  _EmptyCategory()
                else ...[
                  ...controller.filteredProducts.map((product) => Padding(
                    padding: REdgeInsets.only(bottom: 16),
                    child: _InvestProductCard(
                      product: product,
                      onTap: () => controller.onProductTap(product),
                      onCta: () => controller.onPrimaryAction(product),
                    ),
                  )),
                ],

                SizedBox(height: 8.h),

                // ── Rate guide link ──────────────────────────────────
                if (!controller.isLoading)
                  GestureDetector(
                    onTap: controller.onViewRateGuide,
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: REdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 36.r,
                            height: 36.r,
                            decoration: BoxDecoration(
                              color: AppColors.surfaceVariant,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Icon(
                              Icons.menu_book_outlined,
                              size: 18.r,
                              color: AppColors.primary,
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
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  'All products, rates & terms',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.textDisabled,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            size: 20.r,
                            color: AppColors.textDisabled,
                          ),
                        ],
                      ),
                    ),
                  ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Empty state for filtered category ─────────────────────────────────────────
class _EmptyCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 48.r,
            color: AppColors.primary.withOpacity(0.2),
          ),
          SizedBox(height: 12.h),
          Text(
            'No products in this category yet.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}