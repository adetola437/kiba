part of '../controllers/forgot_password_otp_controller.dart';

class ForgotPasswordOtpView extends StatelessWidget
    implements ForgotPasswordOtpViewContract {
  const ForgotPasswordOtpView({super.key, required this.controller});

  final ForgotPasswordOtpControllerContract controller;

  String get _formattedTime {
    final minutes = controller.resendSeconds ~/ 60;
    final seconds = controller.resendSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

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
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    Text(
                      'Check your\nEmail',
                      style: textTheme.headlineLarge,
                    ),
                    SizedBox(height: 10.h),
                    RichText(
                      text: TextSpan(
                        style: textTheme.bodyMedium?.copyWith(
                          height: 1.5,
                        ),
                        children: [
                          const TextSpan(
                            text: 'Enter the 6-digit code sent to ',
                          ),
                          TextSpan(
                            text: controller.maskedEmail,
                            style: textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const TextSpan(text: '.'),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.h),
                    Pinput(
                      length: 6,
                      controller: controller.otpController,
                      focusNode: controller.otpFocusNode,
                      onChanged: controller.onOtpChanged,
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      showCursor: true,
                      defaultPinTheme: PinTheme(
                        width: 46.r,
                        height: 56.r,
                        textStyle: textTheme.titleLarge?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceVariant,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: Colors.transparent),
                        ),
                      ),
                      focusedPinTheme: PinTheme(
                        width: 46.r,
                        height: 56.r,
                        textStyle: textTheme.titleLarge?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: colorScheme.primary.withOpacity(0.4),
                            width: 1.5,
                          ),
                        ),
                      ),
                      submittedPinTheme: PinTheme(
                        width: 46.r,
                        height: 56.r,
                        textStyle: textTheme.titleLarge?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: colorScheme.primary,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 28.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 16.r,
                          color: controller.canResend
                              ? colorScheme.primary
                              : colorScheme.onSurfaceVariant,
                        ),
                        SizedBox(width: 6.w),
                        GestureDetector(
                          onTap:
                              controller.canResend ? controller.onResend : null,
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 200),
                            style: textTheme.bodyMedium!.copyWith(
                              color: controller.canResend
                                  ? colorScheme.primary
                                  : colorScheme.onSurfaceVariant,
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
                opacity: controller.canVerify ? 1 : 0.45,
                child: GestureDetector(
                  onTap: controller.canVerify ? controller.onVerify : null,
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
                          'Verify Code',
                          style: textTheme.labelLarge?.copyWith(
                            color: colorScheme.onPrimary,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 18.r,
                          color: colorScheme.onPrimary,
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