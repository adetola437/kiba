import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
 
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/contract.dart';
import '../../../../core/utils/enums.dart';
import '../widgets/progress_bar.dart';
import 'register_step2_controller.dart';
 
part '../contracts/register_step1_contract.dart';
part '../views/register_step1_view.dart';
part '../widgets/investor_card.dart';

 
class RegisterStep1Screen extends StatefulWidget {
  static const String route = 'register';
 
  const RegisterStep1Screen({super.key});
 
  @override
  State<RegisterStep1Screen> createState() => _RegisterStep1ScreenState();
}
 
class _RegisterStep1ScreenState extends State<RegisterStep1Screen>
    implements RegisterStep1ControllerContract {
  late final RegisterStep1ViewContract view;
 
  @override
  InvestorType? selectedType;
 
  @override
  bool get canContinue => selectedType != null;
 
  @override
  void initState() {
    super.initState();
    view = RegisterStep1View(controller: this);
  }
 
  @override
  void onSelectType(InvestorType type) {
    setState(() => selectedType = type);
  }
 
  @override
  void onContinue() {
    if (!canContinue) return;
    context.pushNamed(RegisterStep2Screen.route, extra: selectedType);
  }
 
  @override
  void onLogin() => context.goNamed('login');
 
  @override
  void onBack() => context.pop();
 
  @override
  Widget build(BuildContext context) => view.build(context);
}