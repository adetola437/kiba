part of '../controllers/register_step1_controller.dart';
 
abstract class RegisterStep1ControllerContract {
  InvestorType? get selectedType;
  bool get canContinue;
 
  void onSelectType(InvestorType type);
  void onContinue();
  void onLogin();
  void onBack();
}
 
abstract class RegisterStep1ViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}
 

 
