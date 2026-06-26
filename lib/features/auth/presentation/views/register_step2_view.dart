part of '../controllers/register_step2_controller.dart';
 
class RegisterStep2View extends StatelessWidget
    implements RegisterStep2ViewContract {
  const RegisterStep2View({super.key, required this.controller});
 
  final RegisterStep2ControllerContract controller;
 
  bool get _isIndividual => controller.investorType == InvestorType.individual;
 
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
 
    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
        child: Form(
          key: controller.formKey,
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
 
                      // Back
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
 
                      SizedBox(height: 24.h),
 
                      RegistrationProgressBar(currentStep: 2),
 
                      SizedBox(height: 28.h),
 
                      Text(
                        _isIndividual
                            ? 'Create your Individual\nAccount'
                            : 'Create your Corporate\nAccount',
                        style: AppTextStyles.headlineLarge.copyWith(
                          fontFamily: 'BWGradual',
                          // Always African Green — brand headline, not adaptive
                          color: colorScheme.primary,
                        ),
                      ),
 
                      SizedBox(height: 8.h),
 
                      Text(
                        'Step 2 of 3: Personal Details',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
 
                      SizedBox(height: 32.h),
 
                      // ── Individual fields ─────────────────────────────
                      if (_isIndividual) ...[
                        RegistrationInputField(
                          label: 'First name',
                          hint: 'John',
                          controller: controller.firstNameController,
                          textInputAction: TextInputAction.next,
                          validatorType: ValidatorType.name,
                        ),
                        SizedBox(height: 20.h),
                        RegistrationInputField(
                          label: 'Middle name',
                          hint: 'Quincy',
                          controller: controller.middleNameController,
                          optional: true,
                          textInputAction: TextInputAction.next,
                          validatorType: ValidatorType.name,
                        ),
                        SizedBox(height: 20.h),
                        RegistrationInputField(
                          label: 'Last name',
                          hint: 'Doe',
                          controller: controller.lastNameController,
                          textInputAction: TextInputAction.next,
                          validatorType: ValidatorType.name,
                        ),
                      ],
 
                      // ── Corporate fields ──────────────────────────────
                      if (!_isIndividual) ...[
                        RegistrationInputField(
                          label: 'Company name',
                          hint: 'Acme Ltd.',
                          controller: controller.companyNameController,
                          textInputAction: TextInputAction.next,
                          validatorType: ValidatorType.name,
                        ),
                        SizedBox(height: 20.h),
                        RegistrationInputField(
                          label: 'Contact person',
                          hint: 'John Doe',
                          controller: controller.contactPersonController,
                          textInputAction: TextInputAction.next,
                          validatorType: ValidatorType.name,
                        ),
                      ],
 
                      SizedBox(height: 20.h),
 
                      // ── Phone ─────────────────────────────────────────
                      RegistrationInputField(
                        label: 'Phone',
                        hint: '800 000 000',
                        controller: controller.phoneController,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        validatorType: ValidatorType.phone,
                      ),
 
                      SizedBox(height: 20.h),
 
                      RegistrationInputField(
                        label: 'Email address',
                        hint: 'name@example.com',
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validatorType: ValidatorType.email,
                      ),
 
                      SizedBox(height: 20.h),
 
                      RegistrationInputField(
                        label: 'Password',
                        hint: '••••••••',
                        controller: controller.passwordController,
                        obscureText: controller.obscurePassword,
                        helperText:
                            'Must be at least 8 characters with a symbol.',
                        textInputAction: TextInputAction.done,
                        suffixIcon: GestureDetector(
                          onTap: controller.onTogglePassword,
                          child: Icon(
                            controller.obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            size: 20.r,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        validatorType: ValidatorType.password,
                      ),
 
                      SizedBox(height: 24.h),
 
                      // ── Referral code (collapsible) ───────────────────
                      GestureDetector(
                        onTap: controller.onToggleReferral,
                        behavior: HitTestBehavior.opaque,
                        child: Row(
                          children: [
                            Icon(
                              controller.referralExpanded
                                  ? Icons.remove
                                  : Icons.add,
                              size: 18.r,
                              color: colorScheme.primary,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              'Have a referral code?',
                              style: AppTextStyles.labelMedium.copyWith(
                                color: colorScheme.primary,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              '(optional)',
                              style: AppTextStyles.labelSmall.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
 
                      AnimatedCrossFade(
                        duration: const Duration(milliseconds: 250),
                        crossFadeState: controller.referralExpanded
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        firstChild: const SizedBox.shrink(),
                        secondChild: Column(
                          children: [
                            SizedBox(height: 16.h),
                            RegistrationInputField(
                              label: 'Referral code',
                              hint: 'e.g. KIBA-1234',
                              controller: controller.referralController,
                              textInputAction: TextInputAction.done,
                            ),
                          ],
                        ),
                      ),
 
                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
              ),
 
              // ── Bottom actions ──────────────────────────────────────────
              Container(
                padding: REdgeInsets.fromLTRB(24, 16, 24, 10),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  border: Border(
                    top: BorderSide(color: colorScheme.outline),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Continue — always African Green, same as ElevatedButton
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
                            color: AppColors.africanGreen,
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Continue',
                                style: AppTextStyles.labelLarge.copyWith(
                                  color: AppColors.beigePink,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Icon(
                                Icons.arrow_forward_rounded,
                                size: 18.r,
                                color: AppColors.beigePink,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
 
                    SizedBox(height: 16.h),
 
                    // Terms
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: AppTextStyles.bodySmall.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        children: [
                          const TextSpan(
                              text: 'By clicking continue, you agree to our '),
                          TextSpan(
                            text: 'Terms of Service',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          const TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}