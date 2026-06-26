part of '../controllers/invest_controller.dart';

class _InvestProductCard extends StatelessWidget {
  const _InvestProductCard({
    required this.product,
    required this.onTap,
    required this.onCta,
  });

  final InvestProductData product;
  final VoidCallback onTap;
  final VoidCallback onCta;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: colorScheme.outline),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Stack(
            children: [
              // Card content
              Padding(
                padding: REdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Header ──────────────────────────────────────
                    Row(
                      children: [
                        // Icon
                        Container(
                          width: 42.r,
                          height: 42.r,
                          decoration: BoxDecoration(
                            color: product.iconBg.withValues(alpha: 0.35),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            product.icon,
                            size: 20.r,
                            color: colorScheme.primary,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: AppTextStyles.titleMedium.copyWith(
                                  color: colorScheme.onSurface,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                product.subtitle,
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (product.isMostPopular)
                          Container(
                            padding: REdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: colorScheme.primaryContainer
                                  .withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              'MOST POPULAR',
                              style: AppTextStyles.labelSmall.copyWith(
                                color: colorScheme.onPrimaryContainer,
                                letterSpacing: 0.4,
                                fontSize: 9.sp,
                              ),
                            ),
                          ),
                      ],
                    ),

                    SizedBox(height: 20.h),

                    // ── Stats row ────────────────────────────────────
                    Row(
                      children: [
                        _StatCell(
                          value: product.statOneValue,
                          label: product.statOneLabel,
                        ),
                        SizedBox(width: 32.w),
                        _StatCell(
                          value: product.statTwoValue,
                          label: product.statTwoLabel,
                        ),
                        SizedBox(width: 32.w),
                        _StatCell(
                          value: product.statThreeValue,
                          label: product.statThreeLabel,
                        ),
                      ],
                    ),

                    SizedBox(height: 20.h),

                    // ── CTA button ───────────────────────────────────
                    GestureDetector(
                      onTap: product.isLocked ? null : onCta,
                      child: Container(
                        width: double.infinity,
                        height: 50.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: product.isLocked
                              ? colorScheme.surfaceVariant
                              : colorScheme.primary,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (product.isLocked) ...[
                              Icon(
                                Icons.lock_outline_rounded,
                                size: 16.r,
                                color: colorScheme.onSurface
                                    .withValues(alpha: 0.38),
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                'Upgrade to Access',
                                style: AppTextStyles.labelLarge.copyWith(
                                  color: colorScheme.onSurface
                                      .withValues(alpha: 0.38),
                                ),
                              ),
                            ] else ...[
                              Text(
                                product.ctaLabel,
                                style: AppTextStyles.labelLarge.copyWith(
                                  color: colorScheme.onPrimary,
                                ),
                              ),
                              SizedBox(width: 6.w),
                              Icon(
                                Icons.arrow_forward_rounded,
                                size: 16.r,
                                color: colorScheme.onPrimary,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Locked overlay ───────────────────────────────────────
              if (product.isLocked)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: REdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    color: colorScheme.secondaryContainer
                        .withValues(alpha: 0.15),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          size: 13.r,
                          color: colorScheme.onSecondaryContainer,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          product.lockReason ?? 'Upgrade to access',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: colorScheme.onSecondaryContainer,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: AppTextStyles.titleMedium.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

// ── Shimmer skeleton card ──────────────────────────────────────────────────────
class _InvestProductSkeleton extends StatefulWidget {
  const _InvestProductSkeleton();

  @override
  State<_InvestProductSkeleton> createState() => _InvestProductSkeletonState();
}

class _InvestProductSkeletonState extends State<_InvestProductSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _shimmer;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
    _shimmer = Tween<double>(begin: -1, end: 2).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Widget _bone({required double width, required double height, double? radius}) {
    return AnimatedBuilder(
      animation: _shimmer,
      builder: (_, __) {
        final colorScheme = Theme.of(context).colorScheme;
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 6.r),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: const [0.0, 0.5, 1.0],
              colors: [
                colorScheme.surfaceVariant.withValues(alpha: 0.5),
                colorScheme.surface.withValues(alpha: 0.8),
                colorScheme.surfaceVariant.withValues(alpha: 0.5),
              ],
              transform: GradientRotation(_shimmer.value),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: REdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _bone(width: 42.r, height: 42.r, radius: 12.r),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _bone(width: 120.w, height: 14.h),
                  SizedBox(height: 6.h),
                  _bone(width: 80.w, height: 10.h),
                ],
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              _bone(width: 50.w, height: 36.h),
              SizedBox(width: 32.w),
              _bone(width: 50.w, height: 36.h),
              SizedBox(width: 32.w),
              _bone(width: 50.w, height: 36.h),
            ],
          ),
          SizedBox(height: 20.h),
          _bone(width: double.infinity, height: 50.h, radius: 12.r),
        ],
      ),
    );
  }
}