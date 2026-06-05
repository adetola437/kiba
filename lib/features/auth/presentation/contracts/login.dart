part of '../controllers/login.dart';

abstract class LoginControllerContract {
  GlobalKey<FormState> get formKey;
  TextEditingController get emailCtrl;
  TextEditingController get passwordCtrl;
  ValueNotifier<bool> get obscurePassword;

  void submit();
  void onForgotPassword();
  void onCreateAccount();
  void onBiometrics();
  void onBack();
}

abstract class LoginViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}


