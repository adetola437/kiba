part of '../controllers/onboard_controller.dart';
 
class OnboardingView extends StatelessWidget implements OnboardingViewContract {
  const OnboardingView({super.key, required this.controller});
 
  final OnboardingControllerContract controller;
 
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
 
    return Scaffold(
      // Scaffold bg doesn't matter — PageView covers the full body,
      // bottom sheet covers the footer. Keep it dark so no flash on load.
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          // ── PageView ────────────────────────────────────────────────────
          PageView.builder(
            controller: controller.pageController,
            onPageChanged: controller.onPageChanged,
            itemCount: _kPages.length,
            itemBuilder: (_, i) => _OnboardingPageWidget(data: _kPages[i]),
          ),
 
          // ── Top bar ─────────────────────────────────────────────────────
          SafeArea(
            child: Padding(
              padding: REdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 32.r,
                    height: 32.r,
                    child: SvgPicture.asset(
                      'assets/icons/kiba_icon.svg',
                      fit: BoxFit.contain,
                    ),
                  ),
                  if (controller.currentPage < _kPages.length - 1)
                    GestureDetector(
                      onTap: controller.onGetStarted,
                      child: Text(
                        'Skip',
                        style: AppTextStyles.labelMedium.copyWith(
                          // Always white — sits on top of dark page imagery
                          color: AppColors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
 
          // ── Bottom controls ─────────────────────────────────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              // Adaptive: white in light, darkSurface in dark
              color: Theme.of(context).scaffoldBackgroundColor,
              padding: REdgeInsets.fromLTRB(28, 16, 28, 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Dot indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _kPages.length,
                      (i) => _DotIndicator(
                        isActive: i == controller.currentPage,
                      ),
                    ),
                  ),
 
                  SizedBox(height: 20.h),
 
                  // Primary CTA
                  _PrimaryButton(
                    label: controller.currentPage == _kPages.length - 1
                        ? 'Get Started'
                        : 'Next',
                    onTap: controller.onNext,
                  ),
 
                  SizedBox(height: 12.h),
 
                  // Log In
                  _SecondaryButton(
                    label: 'Log In',
                    onTap: controller.onLogin,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
 
// ── Dot indicator ──────────────────────────────────────────────────────────────
class _DotIndicator extends StatelessWidget {
  const _DotIndicator({required this.isActive});
  final bool isActive;
 
  @override
  Widget build(BuildContext context) {
    // Dots sit inside the adaptive bottom sheet — use colorScheme.primary
    // so they're African Green in light and darkPrimary in dark.
    final color = Theme.of(context).colorScheme.primary;
 
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      width: isActive ? 24.w : 8.w,
      height: 8.h,
      decoration: BoxDecoration(
        color: isActive ? color : color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }
}
 
// ── Primary button ─────────────────────────────────────────────────────────────
class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;
 
  @override
  Widget build(BuildContext context) {
    
    // CTA is always African Green + Beige Pink — intentional brand, not adaptive.
    // Matches the ElevatedButton definition in AppTheme for both light and dark.
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 56.h,
        decoration: BoxDecoration(
          color: AppColors.africanGreen,
          borderRadius: BorderRadius.circular(14.r),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: AppTextStyles.labelLarge.copyWith(
            color: Theme.of(context).colorScheme.secondary,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}
 
// ── Secondary button ───────────────────────────────────────────────────────────
class _SecondaryButton extends StatelessWidget {
  const _SecondaryButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;
 
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
 
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 56.h,
        decoration: BoxDecoration(
          // Matches the bottom sheet background so it feels inset/outlined
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            // African Green border in light, darkPrimary in dark
            color: colorScheme.primary.withValues(alpha:  0.25),
            width: 1.5,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: AppTextStyles.labelLarge.copyWith(
            color: colorScheme.onSurface,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}
 
// ── Avatar stack (social proof) ────────────────────────────────────────────────
