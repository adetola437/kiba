import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kiba/features/auth/presentation/controllers/login.dart';
import 'package:kiba/features/auth/presentation/controllers/register_step1_controller.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/contract.dart';

part '../contracts/onboard_contract.dart';
part '../views/onboard_view.dart';
part '../widgets/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  static const String route = 'onboarding';

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    implements OnboardingControllerContract {
  late final OnboardingViewContract view;

  @override
  final PageController pageController = PageController();

  @override
  int currentPage = 0;

  static const int _totalPages = 3;

  @override
  void initState() {
    super.initState();
    view = OnboardingView(controller: this);
  }

  @override
  void onPageChanged(int index) {
    setState(() => currentPage = index);
  }

  @override
  void onNext() {
    if (currentPage < _totalPages - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      onGetStarted();
    }
  }

  @override
  void onGetStarted() => context.goNamed(RegisterStep1Screen.route);

  @override
  void onLogin() => context.goNamed(LoginScreen.route);

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => view.build(context);
}