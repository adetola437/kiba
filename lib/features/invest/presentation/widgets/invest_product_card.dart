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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.border),
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
                            color: product.iconBg.withOpacity(0.35),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            product.icon,
                            size: 20.r,
                            color: AppColors.primary,
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
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                product.subtitle,
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.textSecondary,
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
                              color: AppColors.limeGreen.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              'MOST POPULAR',
                              style: AppTextStyles.labelSmall.copyWith(
                                color: AppColors.primary,
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
                              ? AppColors.surfaceVariant
                              : AppColors.primary,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (product.isLocked) ...[
                              Icon(
                                Icons.lock_outline_rounded,
                                size: 16.r,
                                color: AppColors.textDisabled,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                'Upgrade to Access',
                                style: AppTextStyles.labelLarge.copyWith(
                                  color: AppColors.textDisabled,
                                ),
                              ),
                            ] else ...[
                              Text(
                                product.ctaLabel,
                                style: AppTextStyles.labelLarge.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                              SizedBox(width: 6.w),
                              Icon(
                                Icons.arrow_forward_rounded,
                                size: 16.r,
                                color: AppColors.white,
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
                    color: AppColors.beigePink.withOpacity(0.15),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          size: 13.r,
                          color: AppColors.charcoalGrey,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          product.lockReason ?? 'Upgrade to access',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.charcoalGrey,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: AppTextStyles.titleMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
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
      builder: (_, __) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 6.r),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: const [0.0, 0.5, 1.0],
            colors: [
              AppColors.shimmerBase,
              AppColors.shimmerHighlight,
              AppColors.shimmerBase,
            ],
            transform: GradientRotation(_shimmer.value),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
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