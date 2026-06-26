import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class VirtualAccountDisplayCard extends StatelessWidget {
  const VirtualAccountDisplayCard({super.key, required this.onCopy});

  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.primary,
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
                color: Colors.white.withOpacity(0.04),
              ),
            ),
          ),
          Positioned(
            bottom: -20.r,
            right: 60.r,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bank name row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 28.r,
                          height: 28.r,
                          decoration: const BoxDecoration(
                            color: AppColors.beigePink,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.account_balance_rounded,
                            size: 14.r,
                            color: colorScheme.primary,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'MY NAME',
                          style: textTheme.labelSmall?.copyWith(
                            color: Colors.white.withOpacity(0.6),
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.account_balance_outlined,
                      size: 20.r,
                      color: Colors.white.withOpacity(0.4),
                    ),
                  ],
                ),

                SizedBox(height: 12.h),

                Text(
                  'Providus Bank',
                  style: textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(height: 20.h),

                // Account Number label
                Text(
                  'ACCOUNT NUMBER',
                  style: textTheme.labelSmall?.copyWith(
                    color: Colors.white.withOpacity(0.55),
                    letterSpacing: 1.0,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '9901234567',
                  style: TextStyle(
                    fontFamily: 'EuclidCircularA',
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),

                SizedBox(height: 16.h),

                // Account Name label
                Text(
                  'ACCOUNT NAME',
                  style: textTheme.labelSmall?.copyWith(
                    color: Colors.white.withOpacity(0.55),
                    letterSpacing: 1.0,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Beige Africa / Ismail Adamu',
                  style: textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: 20.h),

                // Copy button
                GestureDetector(
                  onTap: onCopy,
                  child: Container(
                    width: double.infinity,
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.copy_rounded,
                          size: 16.r,
                          color: colorScheme.primary,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Copy Account Number',
                          style: textTheme.labelLarge?.copyWith(
                            color: colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
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