part of '../controllers/onboard_controller.dart';

class OnboardingView extends StatelessWidget implements OnboardingViewContract {
  const OnboardingView({super.key, required this.controller});

  final OnboardingControllerContract controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // ── PageView ────────────────────────────────────────────────────
          PageView.builder(
            controller: controller.pageController,
            // physics: NeverScrollableScrollPhysics(),
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
              color: AppColors.background,
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

                  // SizedBox(height: 16.h),

                  // // Social proof
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     _AvatarStack(),
                  //     SizedBox(width: 10.w),
                  //     Text(
                  //       'Joined by 10k+ investors this month',
                  //       style: AppTextStyles.bodySmall.copyWith(
                  //         color: AppColors.textDisabled,
                  //       ),
                  //     ),
                  //   ],
                  // ),
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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      width: isActive ? 24.w : 8.w,
      height: 8.h,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.primary.withOpacity(0.2),
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 56.h,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(14.r),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: AppTextStyles.labelLarge.copyWith(
            color: AppColors.textOnDark,
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 56.h,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: AppColors.buttonBorder, width: 1.5),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: AppTextStyles.labelLarge.copyWith(
            color: AppColors.onBackground,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}

// ── Avatar stack (social proof) ────────────────────────────────────────────────
class _AvatarStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Uses brand palette: beigePink, limeGreen, cloudyBlue
    const avatarColors = [
      AppColors.beigePink,
      AppColors.limeGreen,
      AppColors.cloudyBlue,
    ];
    return SizedBox(
      width: 52.w,
      height: 24.h,
      child: Stack(
        children: List.generate(3, (i) {
          return Positioned(
            left: i * 16.w,
            child: Container(
              width: 24.r,
              height: 24.r,
              decoration: BoxDecoration(
                color: avatarColors[i],
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.white, width: 1.5),
              ),
            ),
          );
        }),
      ),
    );
  }
}