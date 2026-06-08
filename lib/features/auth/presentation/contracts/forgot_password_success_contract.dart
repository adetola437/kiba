part of '../controllers/forgot_password_success_controller.dart';

abstract class ForgotPasswordSuccessControllerContract {
  void onLogin();
}

abstract class ForgotPasswordSuccessViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}
