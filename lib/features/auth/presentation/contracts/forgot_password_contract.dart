part of '../controllers/forgot_password_controller.dart';

abstract class ForgotPasswordControllerContract {
  TextEditingController get emailCtrl;
  bool get canContinue;

  void onContinue();
  void onBack();
}

abstract class ForgotPasswordViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}
