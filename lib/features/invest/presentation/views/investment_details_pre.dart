part of '../controllers/investment_details_controller.dart';

class InvestmentDetailPreView extends StatelessWidget
    implements InvestmentDetailViewContract {
  const InvestmentDetailPreView({super.key, required this.controller});

  final InvestmentDetailControllerContract controller;

  String _fmt(double v) =>
      '₦${NumberFormat('#,##0.00', 'en_US').format(v)}';

  String _fmtShort(double v) {
    if (v >= 1000000) return '₦${(v / 1000000).toStringAsFixed(1)}M';
    if (v >= 1000) return '₦${(v / 1000).toStringAsFixed(0)}K';
    return '₦${v.toStringAsFixed(0)}';
  }

  bool get _canInvest =>
      controller.estimatorAmount >= controller.product.minimumAmount;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final product = controller.product;
    final dateFormat = DateFormat('MMM d, y');

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: colorScheme.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: controller.onBack,
          child: Icon(
            Icons.arrow_back_rounded,
            size: 22.r,
            color: colorScheme.onBackground,
          ),
        ),
        title: Text(
          product.name,
          style: AppTextStyles.titleLarge.copyWith(
            color: colorScheme.onBackground,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: REdgeInsets.fromLTRB(20, 8, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Hero section ─────────────────────────────────
                  Container(
                    width: double.infinity,
                    padding: REdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Stack(
                      children: [
                        // Decorative circle
                        Positioned(
                          top: -20.r,
                          right: -20.r,
                          child: Container(
                            width: 100.r,
                            height: 100.r,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colorScheme.onPrimary.withValues(alpha: 0.05),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Category chip
                            Container(
                              padding: REdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: colorScheme.primaryContainer
                                    .withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Text(
                                product.category,
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: colorScheme.primaryContainer,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              product.tagline,
                              style: AppTextStyles.headlineSmall.copyWith(
                                color: colorScheme.onPrimary,
                                height: 1.25,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              product.description,
                              style: AppTextStyles.bodySmall.copyWith(
                                color: colorScheme.onPrimary.withValues(alpha: 0.65),
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // ── Key stats ────────────────────────────────────
                  // Annual yield — full width
                  Container(
                    width: double.infinity,
                    padding: REdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: colorScheme.outline),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ANNUAL YIELD',
                              style: AppTextStyles.labelSmall.copyWith(
                                color: colorScheme.onSurface.withValues(alpha: 0.38),
                                letterSpacing: 0.5,
                                fontSize: 9.sp,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              '${product.annualYield}%',
                              style: AppTextStyles.displaySmall.copyWith(
                                color: colorScheme.primary,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 44.r,
                          height: 44.r,
                          decoration: BoxDecoration(
                            color: colorScheme.primaryContainer
                                .withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.trending_up_rounded,
                            size: 20.r,
                            color: colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10.h),

                  Row(
                    children: [
                      Expanded(
                        child: _StatBox(
                          label: 'TENOR',
                          value: '${product.tenorDays} Days',
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: _StatBox(
                          label: 'MINIMUM',
                          value: _fmtShort(product.minimumAmount),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 24.h),

                  // ── Why choose ───────────────────────────────────
                  Text(
                    'Why choose ${product.name.split(' ').first}?',
                    style: AppTextStyles.titleLarge.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  ...product.features.map((f) => _FeatureRow(feature: f)),

                  SizedBox(height: 24.h),

                  SizedBox(height: 24.h),

                  // ── Trust strip ──────────────────────────────────
                  Container(
                    padding: REdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _TrustItem(
                          icon: Icons.verified_user_outlined,
                          label: 'SEC\nRegulated',
                        ),
                        _vDivider(colorScheme.outline),
                        _TrustItem(
                          icon: Icons.security_outlined,
                          label: 'NDIC\nInsured',
                        ),
                        _vDivider(colorScheme.outline),
                        _TrustItem(
                          icon: Icons.people_outline_rounded,
                          label: '10,000+\nInvestors',
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),

          // ── CTA ────────────────────────────────────────────────────
          Container(
            padding: REdgeInsets.fromLTRB(20, 12, 20, 32),
            decoration: BoxDecoration(
              color: colorScheme.background,
              border: Border(top: BorderSide(color: colorScheme.outline)),
            ),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: 1.0,
              child: GestureDetector(
                onTap: controller.onInvestNow,
                child: Container(
                  width: double.infinity,
                  height: 56.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Invest Now',
                        style: AppTextStyles.labelLarge.copyWith(
                          color: colorScheme.onPrimary,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 18.r,
                        color: colorScheme.onPrimary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _vDivider(Color color) => Container(
      width: 1, height: 32.h, color: color);
}

// ── Trust item ─────────────────────────────────────────────────────────────────
class _TrustItem extends StatelessWidget {
  const _TrustItem({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Icon(
          icon,
          size: 20.r,
          color: colorScheme.primary,
        ),
        SizedBox(height: 6.h),
        Text(
          label,
          textAlign: TextAlign.center,
          style: AppTextStyles.labelSmall.copyWith(
            color: colorScheme.onSurfaceVariant,
            height: 1.4,
            fontSize: 10.sp,
          ),
        ),
      ],
    );
  }
}