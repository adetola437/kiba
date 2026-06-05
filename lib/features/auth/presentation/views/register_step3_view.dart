part of '../controllers/register_step3_controller.dart';
 
class RegisterStep3View extends StatelessWidget
    implements RegisterStep3ViewContract {
  const RegisterStep3View({super.key, required this.controller});
 
  final RegisterStep3ControllerContract controller;
 
  String get _formattedTime {
    final m = controller.resendSeconds ~/ 60;
    final s = controller.resendSeconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }
 
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
 
                    // Back
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
 
                   const RegistrationProgressBar(currentStep: 3),
 
                    SizedBox(height: 28.h),
 
                    Text(
                      'Verify your\nPhone',
                      style: AppTextStyles.headlineLarge.copyWith(
                        fontFamily: 'BWGradual',
                        color: AppColors.primary,
                      ),
                    ),
 
                    SizedBox(height: 10.h),
 
                    RichText(
                      text: TextSpan(
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                        children: [
                          const TextSpan(
                              text:
                                  'Enter the 6-digit verification code sent to '),
                          TextSpan(
                            text: controller.maskedPhone,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const TextSpan(text: '.'),
                        ],
                      ),
                    ),
 
                    SizedBox(height: 40.h),
 
                    // ── OTP boxes ─────────────────────────────────────
                    Pinput(
                      length: 6,
                      controller: controller.otpController,
                      focusNode: controller.otpFocusNode,
                      onChanged: (value) => controller.onOtpChanged(value),
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      showCursor: true,
                      defaultPinTheme: PinTheme(
                        width: 46.r,
                        height: 56.r,
                        textStyle: AppTextStyles.titleLarge.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceVariant,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: Colors.transparent),
                        ),
                      ),
                      focusedPinTheme: PinTheme(
                        width: 46.r,
                        height: 56.r,
                        textStyle: AppTextStyles.titleLarge.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: AppColors.primary.withOpacity(0.4),
                            width: 1.5,
                          ),
                        ),
                      ),
                      submittedPinTheme: PinTheme(
                        width: 46.r,
                        height: 56.r,
                        textStyle: AppTextStyles.titleLarge.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: AppColors.primary,
                            width: 2,
                          ),
                        ),
                      ),
                    ),

 
                    SizedBox(height: 28.h),
 
                    // ── Resend row ────────────────────────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 16.r,
                          color: controller.canResend
                              ? AppColors.primary
                              : AppColors.textDisabled,
                        ),
                        SizedBox(width: 6.w),
                        GestureDetector(
                          onTap: controller.canResend
                              ? controller.onResend
                              : null,
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 200),
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: controller.canResend
                                  ? AppColors.primary
                                  : AppColors.textDisabled,
                              fontWeight: controller.canResend
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                            child: Text(
                              controller.canResend
                                  ? 'Resend code'
                                  : 'Resend in $_formattedTime',
                            ),
                          ),
                        ),
                      ],
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
                  top: BorderSide(color: AppColors.divider),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Verify button
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 220),
                    opacity: controller.canVerify ? 1.0 : 0.45,
                    child: GestureDetector(
                      onTap: controller.canVerify ? controller.onVerify : null,
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
                              'Verify & Complete',
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
 
                  SizedBox(height: 16.h),
 
                  // Terms
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      children: [
                        const TextSpan(
                            text: 'By clicking verify, you agree to Beige Africa\'s '),
                        TextSpan(
                          text: 'Terms of Service',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const TextSpan(text: '.'),
                      ],
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
 
// ── Single OTP input box ───────────────────────────────────────────────────────
class _OtpBox extends StatelessWidget {
  const _OtpBox({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.isFilled,
  });
 
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final bool isFilled;
 
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 46.r,
      height: 56.r,
      decoration: BoxDecoration(
        color: isFilled
            ? AppColors.primary.withOpacity(0.06)
            : AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isFilled
              ? AppColors.primary
              : focusNode.hasFocus
                  ? AppColors.primary.withOpacity(0.4)
                  : Colors.transparent,
          width: isFilled ? 2 : 1.5,
        ),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        onChanged: onChanged,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        style: AppTextStyles.titleLarge.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w700,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          counterText: '',
        ),
      ),
    );
  }
}