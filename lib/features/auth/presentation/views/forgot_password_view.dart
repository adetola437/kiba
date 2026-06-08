part of '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends StatelessWidget
    implements ForgotPasswordViewContract {
  const ForgotPasswordView({super.key, required this.controller});

  final ForgotPasswordControllerContract controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: REdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),
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
                    SizedBox(height: 40.h),
                    Container(
                      width: 56.r,
                      height: 56.r,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.08),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.lock_reset_rounded,
                        size: 28.r,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 28.h),
                    Text(
                      'Forgot\nPassword?',
                      style: AppTextStyles.headlineLarge.copyWith(
                        fontFamily: 'BWGradual',
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Enter the email connected to your KIBA account. We will send you a verification code.',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 40.h),
                    RegistrationInputField(
                      label: 'EMAIL ADDRESS',
                      controller: controller.emailCtrl,
                      hint: 'e.g. name@example.com',
                      keyboardType: TextInputType.emailAddress,
                      validatorType: ValidatorType.email,
                      textInputAction: TextInputAction.done,
                      suffixIcon: Padding(
                        padding: REdgeInsets.only(right: 12),
                        child: Icon(
                          Icons.mail_outline_rounded,
                          size: 20.r,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: REdgeInsets.fromLTRB(24, 16, 24, 32),
              decoration: BoxDecoration(
                color: AppColors.background,
                border: Border(
                  top: BorderSide(color: AppColors.divider),
                ),
              ),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: controller.canContinue ? 1 : 0.45,
                child: GestureDetector(
                  onTap: controller.canContinue ? controller.onContinue : null,
                  child: Container(
                    width: double.infinity,
                    height: 56.h,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Send Code',
                          style: AppTextStyles.labelLarge.copyWith(
                            color: AppColors.textOnDark,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 18.r,
                          color: AppColors.textOnDark,
                        ),
                      ],
                    ),
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
