part of '../controllers/home_controller.dart';

class _BeigeClubBanner extends StatelessWidget {
  const _BeigeClubBanner({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Stack(
          children: [
            // Decorative circles
            Positioned(
              right: -20.r,
              top: -20.r,
              child: Container(
                width: 100.r,
                height: 100.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.06),
                ),
              ),
            ),
            Positioned(
              right: 20.r,
              bottom: -30.r,
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
              padding: REdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.workspace_premium_rounded,
                        size: 14.r,
                        color: AppColors.beigePink,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        'PREMIUM ACCESS',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.beigePink,
                          letterSpacing: 1.2,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 8.h),

                  Text(
                    'Join the Beige Club',
                    style: AppTextStyles.headlineSmall.copyWith(
                      fontFamily: 'BWGradual',
                      color: AppColors.white,
                    ),
                  ),

                  SizedBox(height: 6.h),

                  Text(
                    'Experience elite financial benefits and\npersonalized wealth strategies.',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.white.withOpacity(0.65),
                      height: 1.5,
                    ),
                  ),

                  SizedBox(height: 16.h),

                  Row(
                    children: [
                      Text(
                        'Enter Exclusive Lounge',
                        style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 14.r,
                        color: AppColors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}