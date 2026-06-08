part of '../controllers/reset_password_controller.dart';

abstract class ResetPasswordControllerContract {
  TextEditingController get passwordCtrl;
  TextEditingController get confirmPasswordCtrl;
  ValueNotifier<bool> get obscurePassword;
  ValueNotifier<bool> get obscureConfirmPassword;
  bool get canSubmit;

  String? validateConfirmPassword(String? value);
  void onSubmit();
  void onBack();
}

abstract class ResetPasswordViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}
