import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kiba/core/utils/contract.dart';
import 'package:kiba/features/auth/presentation/controllers/login.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'login.dart';
import 'onboard_controller.dart';

part '../contracts/register_success_contract.dart';
part '../views/register_success_view.dart';

class RegisterSuccessScreen extends StatefulWidget {
  static const String route = 'register_success';

  final String firstName;

  const RegisterSuccessScreen({super.key, required this.firstName});

  @override
  State<RegisterSuccessScreen> createState() => _RegisterSuccessScreenState();
}

class _RegisterSuccessScreenState extends State<RegisterSuccessScreen>
    with TickerProviderStateMixin
    implements RegisterSuccessControllerContract {
  late final RegisterSuccessViewContract view;

  // Check icon + ripple ring
  @override
  late final AnimationController checkController;

  // Text content below
  @override
  late final AnimationController contentController;

  @override late Animation<double> checkScale;
  @override late Animation<double> checkOpacity;
  @override late Animation<double> ringScale;
  @override late Animation<double> ringOpacity;
  @override late Animation<double> contentOpacity;
  @override late Animation<Offset> contentSlide;

  @override
  String get firstName => widget.firstName;

  @override
  void initState() {
    super.initState();
    view = RegisterSuccessView(controller: this);
    _setupAnimations();
    _startFlow();
  }

  void _setupAnimations() {
    // Check circle: pops in with a spring
    checkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    checkScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: checkController,
        curve: const Interval(0.0, 0.65, curve: Curves.elasticOut),
      ),
    );

    checkOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: checkController,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );

    // Ring ripple: expands and fades out after check appears
    ringScale = Tween<double>(begin: 0.6, end: 1.8).animate(
      CurvedAnimation(
        parent: checkController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );

    ringOpacity = Tween<double>(begin: 0.5, end: 0.0).animate(
      CurvedAnimation(
        parent: checkController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );

    // Content slides up and fades in
    contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    contentOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: contentController, curve: Curves.easeOut),
    );

    contentSlide = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: contentController, curve: Curves.easeOut),
    );
  }

  Future<void> _startFlow() async {
    // Short pause then pop the check in
    await Future.delayed(const Duration(milliseconds: 300));
    await checkController.forward().orCancel;

    // Content fades up right after
    await Future.delayed(const Duration(milliseconds: 150));
    await contentController.forward().orCancel;

    // Hold so user can read it, then navigate
    await Future.delayed(const Duration(milliseconds: 2200));

    if (!mounted) return;
    context.goNamed(LoginScreen.route);
  }

  @override
  void dispose() {
    checkController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => view.build(context);
}