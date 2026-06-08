part of '../controllers/forgot_password_otp_controller.dart';

abstract class ForgotPasswordOtpControllerContract {
  TextEditingController get otpController;
  FocusNode get otpFocusNode;
  int get resendSeconds;
  String get maskedEmail;
  bool get canVerify;
  bool get canResend;

  void onOtpChanged(String value);
  void onVerify();
  void onResend();
  void onBack();
}

abstract class ForgotPasswordOtpViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}
