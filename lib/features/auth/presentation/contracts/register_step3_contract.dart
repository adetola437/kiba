part of '../controllers/register_step3_controller.dart';

abstract class RegisterStep3ControllerContract {
  String get maskedPhone;
  TextEditingController get otpController;
  FocusNode get otpFocusNode;
  bool get canVerify;
  int get resendSeconds;
  bool get canResend;

  void onOtpChanged(String value);
  void onVerify();
  void onResend();
  void onBack();
}

abstract class RegisterStep3ViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}

