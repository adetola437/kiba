part of '../controllers/portfolio_controller.dart';

class _PortfolioEmptyState extends StatelessWidget {
  const _PortfolioEmptyState({
    required this.filter,
    required this.onInvest,
  });

  final PortfolioFilter filter;
  final VoidCallback onInvest;

  String get _message {
    switch (filter) {
      case PortfolioFilter.active:
        return 'No active investments yet.\nStart investing to grow your wealth.';
      case PortfolioFilter.matured:
        return 'No matured investments yet.\nYour completed investments will appear here.';
      case PortfolioFilter.all:
        return 'Your portfolio is empty.\nMake your first investment today.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 32, vertical: 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72.r,
              height: 72.r,
              decoration: BoxDecoration(
                color: AppColors.limeGreen.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.pie_chart_outline_rounded,
                size: 32.r,
                color: AppColors.primary.withOpacity(0.4),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              _message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
                height: 1.6,
              ),
            ),
            SizedBox(height: 24.h),
            if (filter != PortfolioFilter.matured)
              GestureDetector(
                onTap: onInvest,
                child: Container(
                  padding: REdgeInsets.symmetric(
                      horizontal: 28, vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    'Start Investing',
                    style: AppTextStyles.labelLarge.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}