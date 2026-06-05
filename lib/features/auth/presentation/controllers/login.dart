import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kiba/core/shell/main_shell.dart';
import 'package:kiba/features/home/presentation/controllers/home_controller.dart';

import '../../../../config/di/app_initializer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/contract.dart';
import '../widgets/registeration_input_field.dart';
import '../../cubit/auth_cubit.dart';

part '../contracts/login.dart';
part '../views/login.dart';

class LoginScreen extends StatefulWidget {
  static const route = 'login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    implements LoginControllerContract {
  late final LoginViewContract view;


  @override
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  final TextEditingController emailCtrl = TextEditingController();
  @override
  final TextEditingController passwordCtrl = TextEditingController();
  @override
  late ValueNotifier<bool> obscurePassword;

  @override
  void initState() {
    super.initState();
    obscurePassword = ValueNotifier<bool>(true);
    view = LoginView(controller: this);
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    obscurePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return view.build(context);
  }

  @override
  void submit() {
    if (formKey.currentState?.validate() ?? false) {
      context.goNamed(HomeScreen.route);
      // cubit.login(emailCtrl.text.trim(), passwordCtrl.text);
    }
  }

  @override
  void onForgotPassword() {
    context.pushNamed('forgot_password');
  }

  @override
  void onCreateAccount() {
    context.pushNamed('register_step1');
  }

  @override
  void onBiometrics() {
    // TODO: Implement biometric login
  }

  @override
  void onBack() {
    context.pop();
  }
}