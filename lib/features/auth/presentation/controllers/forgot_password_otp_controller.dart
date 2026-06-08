import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/contract.dart';
import 'reset_password_controller.dart';

part '../contracts/forgot_password_otp_contract.dart';
part '../views/forgot_password_otp_view.dart';

class ForgotPasswordOtpScreen extends StatefulWidget {
  static const String route = 'forgot_password_otp';

  final String email;

  const ForgotPasswordOtpScreen({super.key, required this.email});

  @override
  State<ForgotPasswordOtpScreen> createState() =>
      _ForgotPasswordOtpScreenState();
}

class _ForgotPasswordOtpScreenState extends State<ForgotPasswordOtpScreen>
    implements ForgotPasswordOtpControllerContract {
  late final ForgotPasswordOtpViewContract view;

  static const int _otpLength = 6;
  static const int _resendDuration = 120;

  @override
  late final TextEditingController otpController = TextEditingController();

  @override
  late final FocusNode otpFocusNode = FocusNode();

  @override
  int resendSeconds = _resendDuration;

  Timer? _timer;

  @override
  String get maskedEmail {
    final parts = widget.email.split('@');
    if (parts.length != 2 || parts.first.length <= 2) return widget.email;

    final name = parts.first;
    return '${name.substring(0, 2)}••••@${parts.last}';
  }

  @override
  bool get canVerify => otpController.text.length == _otpLength;

  @override
  bool get canResend => resendSeconds == 0;

  @override
  void initState() {
    super.initState();
    view = ForgotPasswordOtpView(controller: this);
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => resendSeconds = _resendDuration);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendSeconds == 0) {
        timer.cancel();
      } else {
        setState(() => resendSeconds--);
      }
    });
  }

  @override
  void onOtpChanged(String value) => setState(() {});

  @override
  void onVerify() {
    if (!canVerify) return;
    // TODO: verify password reset code via auth API.
    context.pushNamed(
      ResetPasswordScreen.route,
      extra: {
        'email': widget.email,
        'code': otpController.text,
      },
    );
  }

  @override
  void onResend() {
    if (!canResend) return;
    otpController.clear();
    otpFocusNode.requestFocus();
    _startTimer();
    // TODO: trigger resend password reset code API.
  }

  @override
  void onBack() => context.pop();

  @override
  void dispose() {
    _timer?.cancel();
    otpController.dispose();
    otpFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => view.build(context);
}
