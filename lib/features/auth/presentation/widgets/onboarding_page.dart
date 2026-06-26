part of '../controllers/onboard_controller.dart';
 
class _OnboardingPageData {
  final String illustrationPath;
  final String headline;
  final String body;
 
  const _OnboardingPageData({
    required this.illustrationPath,
    required this.headline,
    required this.body,
  });
}
 
const List<_OnboardingPageData> _kPages = [
  _OnboardingPageData(
    illustrationPath: 'assets/icons/onboarding_1.svg',
    headline: 'Invest with\nConfidence',
    body:
        'Unlock exclusive wealth opportunities through the Beige Club and institutional-grade stability with our PMPS (Portfolio Management & Planning System).',
  ),
  _OnboardingPageData(
    illustrationPath: 'assets/icons/onboarding_2.svg',
    headline: 'Grow Your\nWealth',
    body:
        'Access curated investment portfolios designed for African markets. From fixed income to equities, we have the right fit for your goals.',
  ),
  _OnboardingPageData(
    illustrationPath: 'assets/icons/onboarding_3.svg',
    headline: 'Built for\nYou',
    body:
        'Personalised financial planning at your fingertips. KIBA learns your goals and helps you stay on track — every step of the way.',
  ),
];
 
class _OnboardingPageWidget extends StatelessWidget {
  const _OnboardingPageWidget({required this.data});
 
  final _OnboardingPageData data;
 
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Illustration ──────────────────────────────────────────────────
        Expanded(
          flex: 4,
          child: SvgPicture.asset(
            data.illustrationPath,
            fit: BoxFit.cover,
            width: double.maxFinite,
            
          ),
        ),
 
        // ── Content ───────────────────────────────────────────────────────
        Expanded(
          flex: 4,
          child: Padding(
            padding: REdgeInsets.symmetric(horizontal: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.h),
                Text(
                  data.headline,
                  style: AppTextStyles.displaySmall.copyWith(
                    color: colorScheme.primary,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  data.body,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}