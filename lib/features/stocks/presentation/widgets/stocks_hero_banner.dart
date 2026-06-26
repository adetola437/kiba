part of '../controllers/stocks_controller.dart';

class _StocksHeroBanner extends StatelessWidget {
  const _StocksHeroBanner();

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
            right: -20.r,
            child: Container(
              width: 120.r,
              height: 120.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          Positioned(
            bottom: -20.r,
            right: 60.r,
            child: Container(
              width: 70.r,
              height: 70.r,
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Invest in\nNigerian Stocks',
                        style: textTheme.headlineSmall?.copyWith(
                          fontFamily: 'BWGradual',
                          color: Colors.white,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Buy & sell NGX-listed equities\ndirectly from your wallet.',
                        style: textTheme.bodySmall?.copyWith(
                          color: Colors.white.withOpacity(0.65),
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 14.h),
                      Container(
                        padding: REdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          'Start Investing →',
                          style: textTheme.labelSmall?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 16.w),

                // ASI badge
                Container(
                  width: 76.r,
                  height: 76.r,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.show_chart_rounded,
                        size: 18.r,
                        color: colorScheme.primaryContainer,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'NGX',
                        style: textTheme.titleSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.0,
                        ),
                      ),
                      Text(
                        'LISTED',
                        style: textTheme.labelSmall?.copyWith(
                          color: Colors.white.withOpacity(0.55),
                          fontSize: 8.sp,
                          letterSpacing: 0.8,
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