import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';
 
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
// import '../contracts/register_step1_.dart' show InvestorType;

import '../../../../core/utils/contract.dart';
import '../../../../core/utils/enums.dart';
import '../widgets/progress_bar.dart';
import '../widgets/registeration_input_field.dart';
import 'register_step3_controller.dart';
 
part '../contracts/register_step2_contract.dart';
part '../views/register_step2_view.dart';
 
class RegisterStep2Screen extends StatefulWidget {
  static const String route = 'register_step2';
 
  final InvestorType investorType;
 
  const RegisterStep2Screen({super.key, required this.investorType});
 
  @override
  State<RegisterStep2Screen> createState() => _RegisterStep2ScreenState();
}
 
class _RegisterStep2ScreenState extends State<RegisterStep2Screen>
    implements RegisterStep2ControllerContract {
  late final RegisterStep2ViewContract view;
 
  @override InvestorType get investorType => widget.investorType;
 
  @override final firstNameController     = TextEditingController();
  @override final middleNameController    = TextEditingController();
  @override final lastNameController      = TextEditingController();
  @override final companyNameController   = TextEditingController();
  @override final contactPersonController = TextEditingController();
  @override final phoneController         = TextEditingController();
  @override final emailController         = TextEditingController();
  @override final passwordController      = TextEditingController();
  @override final referralController      = TextEditingController();
 
  @override bool obscurePassword   = true;
  @override bool referralExpanded  = false;
 
  @override
  bool get canContinue {
    final sharedFilled = phoneController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.length >= 8;
 
    if (investorType == InvestorType.individual) {
      return firstNameController.text.isNotEmpty &&
          lastNameController.text.isNotEmpty &&
          sharedFilled;
    } else {
      return companyNameController.text.isNotEmpty &&
          contactPersonController.text.isNotEmpty &&
          sharedFilled;
    }
  }
 
  @override
  void initState() {
    super.initState();
    view = RegisterStep2View(controller: this);
    // Rebuild when any field changes so canContinue updates
    for (final c in [
      firstNameController, middleNameController, lastNameController,
      companyNameController, contactPersonController,
      phoneController, emailController, passwordController,
    ]) {
      c.addListener(() => setState(() {}));
    }
  }
 
  @override
  void onTogglePassword() => setState(() => obscurePassword = !obscurePassword);
 
  @override
  void onToggleReferral() => setState(() => referralExpanded = !referralExpanded);
 
  @override
  void onContinue() {
        if (formKey.currentState?.validate() ?? false) {
 if (!canContinue) return;
    context.pushNamed(
      RegisterStep3Screen.route,
      extra: {
        'investorType': investorType,
        'phone': phoneController.text,
        'firstName': firstNameController.text,
      },
    );
        }
   
  }
 
  @override
  void onBack() => context.pop();
 
  @override
  void onLoginTap() => context.goNamed('login');
 
  @override
  void dispose() {
    for (final c in [
      firstNameController, middleNameController, lastNameController,
      companyNameController, contactPersonController,
      phoneController, emailController, passwordController, referralController,
    ]) {
      c.dispose();
    }
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) => view.build(context);

  @override
   GlobalKey<FormState> formKey = GlobalKey<FormState>();
}