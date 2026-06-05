part of '../controllers/invest_controller.dart';

class _InvestHeroBanner extends StatelessWidget {
  const _InvestHeroBanner();

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
          // Decorative circles
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
            bottom: -20.r,
            right: 50.r,
            child: Container(
              width: 80.r,
              height: 80.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.04),
              ),
            ),
          ),

          Padding(
            padding: REdgeInsets.all(22),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Put Your Money\nto Work',
                        style: AppTextStyles.headlineSmall.copyWith(
                          fontFamily: 'BWGradual',
                          color: AppColors.white,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'SEC-regulated investments\nearning up to 18.5% p.a.',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.white.withOpacity(0.65),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 16.w),

                // ROI badge
                Container(
                  width: 72.r,
                  height: 72.r,
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: AppColors.white.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '18.5%',
                        style: AppTextStyles.titleLarge.copyWith(
                          color: AppColors.limeGreen,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        'P.A.',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.white.withOpacity(0.6),
                          letterSpacing: 1.0,
                          fontSize: 9.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}