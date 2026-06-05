import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kiba/features/auth/presentation/controllers/register_success_controller.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/contract.dart';
import '../widgets/progress_bar.dart';

part '../contracts/register_step3_contract.dart';
part '../views/register_step3_view.dart';

class RegisterStep3Screen extends StatefulWidget {
  static const String route = 'register_step3';

  final String phone;
  final String firstName;

      const RegisterStep3Screen({super.key, required this.phone, required this.firstName});

      @override
  State<RegisterStep3Screen> createState() => _RegisterStep3ScreenState();
}

class _RegisterStep3ScreenState extends State<RegisterStep3Screen>
    implements RegisterStep3ControllerContract {
  late final RegisterStep3ViewContract view;

  static const int _otpLength = 6;
  static const int _resendDuration = 120; // 2 minutes

  @override
  late final otpController = TextEditingController();

  @override
  late final otpFocusNode = FocusNode();

  @override
  int resendSeconds = _resendDuration;

  Timer? _timer;

  @override
  String get maskedPhone {
    final p = widget.phone;
    if (p.length < 4) return p;
    return '+234 ••••••${p.substring(p.length - 2)}';
  }

  @override
  bool get canVerify => otpController.text.length == _otpLength;

  @override
  bool get canResend => resendSeconds == 0;

  @override
  void initState() {
    super.initState();
    view = RegisterStep3View(controller: this);
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => resendSeconds = _resendDuration);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (resendSeconds == 0) {
        t.cancel();
      } else {
        setState(() => resendSeconds--);
      }
    });
  }

  @override
  void onOtpChanged(String value) {
    setState(() {});
  }

  @override
  void onVerify() {
    if (!canVerify) return;
    final otp = otpController.text;
    // TODO: call verification API via cubit with otp
    context.goNamed(RegisterSuccessScreen.route, extra: widget.firstName);
  }

  @override
  void onResend() {
    if (!canResend) return;
    otpController.clear();
    otpFocusNode.requestFocus();
    _startTimer();
    // TODO: trigger resend OTP API call
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