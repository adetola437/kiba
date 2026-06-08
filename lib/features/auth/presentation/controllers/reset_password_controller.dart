import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/contract.dart';
import '../widgets/registeration_input_field.dart';
import 'forgot_password_success_controller.dart';

part '../contracts/reset_password_contract.dart';
part '../views/reset_password_view.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String route = 'reset_password';

  final String email;
  final String code;

  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.code,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen>
    implements ResetPasswordControllerContract {
  late final ResetPasswordViewContract view;

  @override
  final TextEditingController passwordCtrl = TextEditingController();

  @override
  final TextEditingController confirmPasswordCtrl = TextEditingController();

  @override
  late ValueNotifier<bool> obscurePassword;

  @override
  late ValueNotifier<bool> obscureConfirmPassword;

  @override
  bool canSubmit = false;

  @override
  void initState() {
    super.initState();
    obscurePassword = ValueNotifier<bool>(true);
    obscureConfirmPassword = ValueNotifier<bool>(true);
    view = ResetPasswordView(controller: this);
    passwordCtrl.addListener(_onPasswordChanged);
    confirmPasswordCtrl.addListener(_onPasswordChanged);
  }

  void _onPasswordChanged() {
    final password = passwordCtrl.text;
    final confirmPassword = confirmPasswordCtrl.text;
    final isValid = password.length >= 8 &&
        confirmPassword.length >= 8 &&
        password == confirmPassword;

    if (isValid != canSubmit) {
      setState(() => canSubmit = isValid);
    }
  }

  @override
  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Confirm your new password';
    if (value != passwordCtrl.text) return 'Passwords do not match';
    return null;
  }

  @override
  void onSubmit() {
    if (!canSubmit) return;
    // TODO: call reset password API with widget.email, widget.code, and password.
    context.goNamed(ForgotPasswordSuccessScreen.route);
  }

  @override
  void onBack() => context.pop();

  @override
  void dispose() {
    passwordCtrl.removeListener(_onPasswordChanged);
    confirmPasswordCtrl.removeListener(_onPasswordChanged);
    passwordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    obscurePassword.dispose();
    obscureConfirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => view.build(context);
}
