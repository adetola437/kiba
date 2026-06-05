part of '../controllers/register_step1_controller.dart';
 
class RegisterStep1View extends StatelessWidget
    implements RegisterStep1ViewContract {
  const RegisterStep1View({super.key, required this.controller});
 
  final RegisterStep1ControllerContract controller;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // ── Scrollable content ──────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: REdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),
 
                    // Back button
                    GestureDetector(
                      onTap: controller.onBack,
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: REdgeInsets.only(bottom: 8),
                        child: Icon(
                          Icons.arrow_back_rounded,
                          size: 24.r,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
 
                    SizedBox(height: 24.h),
 
                    // Progress bar
                    RegistrationProgressBar(
                      totalSteps: 3,
                      currentStep: 1,
                    ),
 
                    SizedBox(height: 28.h),
 
                    // Headline
                    Text(
                      'Join KIBA',
                      style: AppTextStyles.headlineLarge.copyWith(
                        fontFamily: 'BWGradual',
                        color: AppColors.primary,
                      ),
                    ),
 
                    SizedBox(height: 8.h),
 
                    // Subtitle
                    Text(
                      'Step 1 of 3: Choose your investor type to get started.',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ),
 
                    SizedBox(height: 36.h),
 
                    // Individual card
                    _InvestorTypeCard(
                      type: InvestorType.individual,
                      isSelected:
                          controller.selectedType == InvestorType.individual,
                      onTap: () =>
                          controller.onSelectType(InvestorType.individual),
                    ),
 
                    SizedBox(height: 16.h),
 
                    // Corporate card
                    _InvestorTypeCard(
                      type: InvestorType.corporate,
                      isSelected:
                          controller.selectedType == InvestorType.corporate,
                      onTap: () =>
                          controller.onSelectType(InvestorType.corporate),
                    ),
 
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
 
            // ── Bottom actions ──────────────────────────────────────────
            Container(
              padding: REdgeInsets.fromLTRB(24, 16, 24, 32),
              decoration: BoxDecoration(
                color: AppColors.background,
                border: Border(
                  top: BorderSide(
                    color: AppColors.divider,
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Continue button
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 220),
                    opacity: controller.canContinue ? 1.0 : 0.45,
                    child: GestureDetector(
                      onTap: controller.canContinue
                          ? controller.onContinue
                          : null,
                      child: Container(
                        width: double.infinity,
                        height: 56.h,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Continue',
                          style: AppTextStyles.labelLarge.copyWith(
                            color: AppColors.textOnDark,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                    ),
                  ),
 
                  SizedBox(height: 16.h),
 
                  // Already have account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      GestureDetector(
                        onTap: controller.onLogin,
                        child: Text(
                          'Log In',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
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