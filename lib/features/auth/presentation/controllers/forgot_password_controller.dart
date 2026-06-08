import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/contract.dart';
import '../widgets/registeration_input_field.dart';
import 'forgot_password_otp_controller.dart';

part '../contracts/forgot_password_contract.dart';
part '../views/forgot_password_view.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String route = 'forgot_password';

  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    implements ForgotPasswordControllerContract {
  late final ForgotPasswordViewContract view;

  @override
  final TextEditingController emailCtrl = TextEditingController();

  @override
  bool canContinue = false;

  @override
  void initState() {
    super.initState();
    view = ForgotPasswordView(controller: this);
    emailCtrl.addListener(_onEmailChanged);
  }

  void _onEmailChanged() {
    final isValid =
        RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(emailCtrl.text.trim());
    if (isValid != canContinue) {
      setState(() => canContinue = isValid);
    }
  }

  @override
  void onContinue() {
    if (!canContinue) return;
    // TODO: request password reset code via auth API.
    context.pushNamed(
      ForgotPasswordOtpScreen.route,
      extra: emailCtrl.text.trim(),
    );
  }

  @override
  void onBack() => context.pop();

  @override
  void dispose() {
    emailCtrl.removeListener(_onEmailChanged);
    emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => view.build(context);
}
