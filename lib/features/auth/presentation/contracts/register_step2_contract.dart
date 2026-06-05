part of '../controllers/register_step2_controller.dart';
 
abstract class RegisterStep2ControllerContract {
  InvestorType get investorType;

   late GlobalKey<FormState> formKey;
 
  // Individual fields
  TextEditingController get firstNameController;
  TextEditingController get middleNameController;
  TextEditingController get lastNameController;
 
  // Corporate fields
  TextEditingController get companyNameController;
  TextEditingController get contactPersonController;
 
  // Shared fields
  TextEditingController get phoneController;
  TextEditingController get emailController;
  TextEditingController get passwordController;
  TextEditingController get referralController;
 
  bool get obscurePassword;
  bool get referralExpanded;
  bool get canContinue;
 
  void onTogglePassword();
  void onToggleReferral();
  void onContinue();
  void onBack();
  void onLoginTap();
}
 
abstract class RegisterStep2ViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}
 

 