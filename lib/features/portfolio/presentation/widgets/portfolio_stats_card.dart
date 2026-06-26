part of '../controllers/portfolio_controller.dart';

class _PortfolioStatsCard extends StatelessWidget {
  const _PortfolioStatsCard({
    required this.balanceVisible,
    required this.onToggle,
  });

  final bool balanceVisible;
  final VoidCallback onToggle;

  String _mask(String value) => balanceVisible ? value : '••••••';

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
                color: colorScheme.onPrimary.withOpacity(0.04),
              ),
            ),
          ),

          Padding(
            padding: REdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Top stats row ─────────────────────────────────────
                IntrinsicHeight(
                  child: Row(
                    children: [
                      _StatsCell(
                        value: _mask('₦3.5M'),
                        label: 'INVESTED',
                      ),
                      VerticalDivider(
                        color: colorScheme.onPrimary.withOpacity(0.15),
                        width: 1,
                        thickness: 1,
                      ),
                      _StatsCell(
                        value: _mask('₦49.9K'),
                        label: 'ACCRUED',
                      ),
                      VerticalDivider(
                        color: colorScheme.onPrimary.withOpacity(0.15),
                        width: 1,
                        thickness: 1,
                      ),
                      _StatsCell(
                        value: _mask('₦3.55M'),
                        label: 'TOTAL VALUE',
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16.h),
                Divider(
                  color: colorScheme.onPrimary.withOpacity(0.1),
                  height: 1,
                ),
                SizedBox(height: 16.h),

                // ── Bottom row: daily accrual + next maturity ─────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Daily accrual
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _mask('+₦1,900 today'),
                          style: textTheme.titleMedium?.copyWith(
                            color: colorScheme.primaryContainer,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'DAILY ACCRUAL',
                          style: textTheme.labelSmall?.copyWith(
                            color: colorScheme.onPrimary.withOpacity(0.5),
                            letterSpacing: 1.0,
                            fontSize: 9.sp,
                          ),
                        ),
                      ],
                    ),

                    // Next maturity pill
                    Container(
                      padding: REdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: colorScheme.onPrimary.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        'Next maturity: 10 Jan',
                        style: textTheme.labelSmall?.copyWith(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    // Eye toggle
                    GestureDetector(
                      onTap: onToggle,
                      child: Icon(
                        balanceVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: colorScheme.onPrimary.withOpacity(0.55),
                        size: 18.r,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsCell extends StatelessWidget {
  const _StatsCell({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: textTheme.titleMedium?.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: textTheme.labelSmall?.copyWith(
                color: colorScheme.onPrimary.withOpacity(0.5),
                letterSpacing: 0.8,
                fontSize: 9.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}