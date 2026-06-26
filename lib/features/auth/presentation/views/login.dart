part of '../controllers/login.dart';

class LoginView extends StatelessWidget implements LoginViewContract {
  const LoginView({super.key, required this.controller});

  final LoginControllerContract controller;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
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
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),

                    SizedBox(height: 40.h),

                    // Headline
                    Text(
                      'Welcome Back',
                      style: AppTextStyles.headlineLarge.copyWith(
                        color: colorScheme.primary,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    // Subtitle
                    Text(
                      'Log in to manage your investments and grow\nyour wealth.',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),

                    SizedBox(height: 40.h),

                    // Form
                    Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Phone/Email field
                          RegistrationInputField(
                            label: 'PHONE NUMBER OR EMAIL',
                            controller: controller.emailCtrl,
                            hint: 'e.g. name@example.com',
                            keyboardType: TextInputType.emailAddress,
                            validatorType: ValidatorType.email,
                            suffixIcon: Padding(
                              padding: REdgeInsets.only(right: 12),
                              child: Icon(
                                Icons.mail_outline_rounded,
                                size: 20.r,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),

                          SizedBox(height: 20.h),

                          // Password field
                          ValueListenableBuilder<bool>(
                            valueListenable: controller.obscurePassword,
                            builder: (context, obscure, _) {
                              return RegistrationInputField(
                                label: 'PASSWORD',
                                controller: controller.passwordCtrl,
                                hint: '••••••••',
                                obscureText: obscure,
                                helperText:
                                    'Must be at least 8 characters with a symbol.',
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

                          SizedBox(height: 16.h),

                          // Forgot password
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: controller.onForgotPassword,
                              child: Text(
                                'Forgot Password?',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 28.h),

                          // Login button — always-brand surface, not adaptive
                          GestureDetector(
                            onTap: controller.submit,
                            child: Container(
                              width: double.infinity,
                              height: 56.h,
                              decoration: BoxDecoration(
                                color: AppColors.africanGreen,
                                borderRadius: BorderRadius.circular(14.r),
                              ),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Log In',
                                    style: AppTextStyles.labelLarge.copyWith(
                                      color: AppColors.beigePink,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 20.r,
                                    color: AppColors.beigePink,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 20.h),

                          // OR divider
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: colorScheme.outline,
                                  height: 1,
                                  thickness: 1,
                                ),
                              ),
                              Padding(
                                padding:
                                    REdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  'OR',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: colorScheme.outline,
                                  height: 1,
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 20.h),

                          // Biometrics button — always-brand surface, not adaptive
                          GestureDetector(
                            onTap: controller.onBiometrics,
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
                                  Icon(
                                    Icons.fingerprint_rounded,
                                    size: 20.r,
                                    color: AppColors.africanGreen,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    'Use Biometrics',
                                    style: AppTextStyles.labelLarge.copyWith(
                                      color: AppColors.africanGreen,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Sign up section ─────────────────────────────────────────
            Container(
              padding: REdgeInsets.fromLTRB(24, 16, 24, 32),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                border: Border(
                  top: BorderSide(color: colorScheme.outline),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  GestureDetector(
                    onTap: controller.onCreateAccount,
                    child: Text(
                      'Create an account',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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