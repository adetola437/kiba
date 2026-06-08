import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/contract.dart';
import 'login.dart';

part '../contracts/forgot_password_success_contract.dart';
part '../views/forgot_password_success_view.dart';

class ForgotPasswordSuccessScreen extends StatefulWidget {
  static const String route = 'forgot_password_success';

  const ForgotPasswordSuccessScreen({super.key});

  @override
  State<ForgotPasswordSuccessScreen> createState() =>
      _ForgotPasswordSuccessScreenState();
}

class _ForgotPasswordSuccessScreenState
    extends State<ForgotPasswordSuccessScreen>
    implements ForgotPasswordSuccessControllerContract {
  late final ForgotPasswordSuccessViewContract view;

  @override
  void initState() {
    super.initState();
    view = ForgotPasswordSuccessView(controller: this);
  }

  @override
  void onLogin() => context.goNamed(LoginScreen.route);

  @override
  Widget build(BuildContext context) => view.build(context);
}
