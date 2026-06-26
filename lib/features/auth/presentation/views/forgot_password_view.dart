part of '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends StatelessWidget
    implements ForgotPasswordViewContract {
  const ForgotPasswordView({super.key, required this.controller});

  final ForgotPasswordControllerContract controller;

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
                    Container(
                      width: 56.r,
                      height: 56.r,
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withOpacity(0.08),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.lock_reset_rounded,
                        size: 28.r,
                        color: colorScheme.primary,
                      ),
                    ),
                    SizedBox(height: 28.h),
                    Text(
                      'Forgot\nPassword?',
                      style: textTheme.headlineLarge?.copyWith(
                        fontFamily: 'BWGradual',
                        color: colorScheme.primary,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Enter the email connected to your KIBA account. We will send you a verification code.',
                      style: textTheme.bodyMedium?.copyWith(
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
                          color: colorScheme.onSurfaceVariant,
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
                color: colorScheme.surface,
                border: Border(
                  top: BorderSide(
                    color: colorScheme.outline.withOpacity(0.5),
                  ),
                ),
              ),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: controller.canContinue ? 1 : 0.45,
                child: IgnorePointer(
                  ignoring: !controller.canContinue,
                  child: ElevatedButton.icon(
                    onPressed: controller.canContinue
                        ? controller.onContinue
                        : null,
                    icon: const Icon(Icons.arrow_forward_rounded),
                    label: const Text('Send Code'),
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