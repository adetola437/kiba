part of '../controllers/forgot_password_success_controller.dart';

class ForgotPasswordSuccessView extends StatelessWidget
    implements ForgotPasswordSuccessViewContract {
  const ForgotPasswordSuccessView({super.key, required this.controller});

  final ForgotPasswordSuccessControllerContract controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const Spacer(),
              Container(
                width: 104.r,
                height: 104.r,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.limeGreen,
                ),
                child: Icon(
                  Icons.check_rounded,
                  size: 56.r,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 40.h),
              Text(
                'Password\nUpdated',
                textAlign: TextAlign.center,
                style: AppTextStyles.displaySmall.copyWith(
                  fontFamily: 'BWGradual',
                  color: AppColors.white,
                  height: 1.2,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Your password has been reset successfully. You can now log in with your new password.',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.white.withOpacity(0.7),
                  height: 1.6,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: controller.onLogin,
                child: Container(
                  width: double.infinity,
                  height: 56.h,
                  decoration: BoxDecoration(
                    color: AppColors.beigePink,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Proceed to Login',
                        style: AppTextStyles.labelLarge.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 18.r,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}
