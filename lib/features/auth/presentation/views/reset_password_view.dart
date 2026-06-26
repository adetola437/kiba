part of '../controllers/reset_password_controller.dart';

class ResetPasswordView extends StatelessWidget
    implements ResetPasswordViewContract {
  const ResetPasswordView({super.key, required this.controller});

  final ResetPasswordControllerContract controller;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
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
                          // color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    Text(
                      'Create New\nPassword',
                      style: AppTextStyles.headlineLarge.copyWith(
                        fontFamily: 'BWGradual',
                        color: colorScheme.primary,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Choose a strong password to keep your KIBA account secure.',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 40.h),
                    ValueListenableBuilder<bool>(
                      valueListenable: controller.obscurePassword,
                      builder: (context, obscure, _) {
                        return RegistrationInputField(
                          label: 'NEW PASSWORD',
                          controller: controller.passwordCtrl,
                          hint: '••••••••',
                          obscureText: obscure,
                          helperText: 'Must be at least 8 characters.',
                          validatorType: ValidatorType.password,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              controller.obscurePassword.value =
                                  !controller.obscurePassword.value;
                            },
                            child: Padding(
                              padding: REdgeInsets.only(right: 12),
                              child: Icon(
                                obscure
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                size: 20.r,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20.h),
                    ValueListenableBuilder<bool>(
                      valueListenable: controller.obscureConfirmPassword,
                      builder: (context, obscure, _) {
                        return RegistrationInputField(
                          label: 'CONFIRM PASSWORD',
                          controller: controller.confirmPasswordCtrl,
                          hint: '••••••••',
                          obscureText: obscure,
                          textInputAction: TextInputAction.done,
                          customValidator: controller.validateConfirmPassword,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              controller.obscureConfirmPassword.value =
                                  !controller.obscureConfirmPassword.value;
                            },
                            child: Padding(
                              padding: REdgeInsets.only(right: 12),
                              child: Icon(
                                obscure
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                size: 20.r,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: REdgeInsets.fromLTRB(24, 16, 24, 32),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                border: Border(
                  top: BorderSide(color: colorScheme.outline),
                ),
              ),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 220),
                opacity: controller.canSubmit ? 1 : 0.45,
                child: GestureDetector(
                  onTap: controller.canSubmit ? controller.onSubmit : null,
                  child: Container(
                    width: double.infinity,
                    height: 56.h,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Reset Password',
                          style: AppTextStyles.labelLarge.copyWith(
                            color: colorScheme.tertiary,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Icon(
                          Icons.check_rounded,
                          size: 18.r,
                          color: colorScheme.tertiary,
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
