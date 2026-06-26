import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kiba/core/theme/app_colors.dart';
import 'package:kiba/features/auth/presentation/controllers/onboard_controller.dart';

import '../../../../config/di/app_initializer.dart';
import '../../../../core/utils/contract.dart';
import '../../cubit/auth_cubit.dart';
import '../../cubit/auth_state.dart';

part '../contracts/splash.dart';
part '../views/splash.dart';

class SplashScreen extends StatefulWidget {
  static const String route = 'splash';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin
    implements SplashControllerContract {
  late final SplashViewContract view;

  // ── Animation Controllers ──────────────────────────────────────────
  late final AnimationController _logoController;
  late final AnimationController _kibaController;
  late final AnimationController _byBeigeController;
  late final AnimationController _taglineController;
  late final AnimationController _exitController;

  // ── Animations ─────────────────────────────────────────────────────
  late final Animation<double> _logoOpacity;
  late final Animation<double> _logoScale;
  late final Animation<double> _logoLineProgress;

  late final Animation<double> _kibaOpacity;
  late final Animation<Offset> _kibaSlide;

  late final Animation<double> _byBeigeOpacity;
  late final Animation<int> _byBeigeLetterCount;

  late final Animation<double> _taglineOpacity;
  late final Animation<int> _taglineLetterCount;

  late final Animation<double> _exitFade;

  @override
  void initState() {
    super.initState();
    view = SplashView(controller: this);
    _setupAnimations();
    _startSplashFlow();
  }

  void _setupAnimations() {
    // 1. Logo reveal: square fade + line fans out (0-800ms)
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );
    _logoScale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );
    _logoLineProgress = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    // 2. "KIBA" slides up and fades in (700ms)
    _kibaController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _kibaOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _kibaController, curve: Curves.easeOut),
    );
    _kibaSlide = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _kibaController, curve: Curves.easeOut),
    );

    // 3. "by Beige Africa" typewriter effect (1200ms)
    _byBeigeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _byBeigeOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _byBeigeController, curve: Curves.easeOut),
    );
    _byBeigeLetterCount = IntTween(
      begin: 0,
      end: 'by Beige Africa'.length,
    ).animate(
      CurvedAnimation(parent: _byBeigeController, curve: Curves.linear),
    );

    // 4. Tagline typewriter effect (1500ms)
    _taglineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _taglineOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _taglineController, curve: Curves.easeOut),
    );
    _taglineLetterCount = IntTween(
      begin: 0,
      end: '...designed to match you'.length,
    ).animate(
      CurvedAnimation(parent: _taglineController, curve: Curves.linear),
    );

    // 5. Exit fade out (600ms)
    _exitController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _exitFade = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _exitController, curve: Curves.easeIn),
    );
  }

  Future<void> _startSplashFlow() async {
    // Phase 1: Logo reveal
    await Future.delayed(const Duration(milliseconds: 200));
    await _logoController.forward().orCancel;

    // Phase 2: "KIBA" appears
    await Future.delayed(const Duration(milliseconds: 150));
    await _kibaController.forward().orCancel;

    // Phase 3: "by Beige Africa" types in
    await Future.delayed(const Duration(milliseconds: 200));
    await _byBeigeController.forward().orCancel;

    // Phase 4: Tagline types in
    await Future.delayed(const Duration(milliseconds: 300));
    await _taglineController.forward().orCancel;

    // Hold for readability
    await Future.delayed(const Duration(milliseconds: 1200));

    // Phase 5: Exit animation (reverse of entry)
    await _exitController.forward().orCancel;

    // Navigate
    await resolveAuthState();
  }

  // ── Getters ────────────────────────────────────────────────────────
  @override Animation<double> get logoOpacity => _logoOpacity;
  @override Animation<double> get logoScale => _logoScale;
  @override Animation<double> get logoLineProgress => _logoLineProgress;
  @override Animation<double> get kibaOpacity => _kibaOpacity;
  @override Animation<Offset> get kibaSlide => _kibaSlide;
  @override Animation<double> get byBeigeOpacity => _byBeigeOpacity;
  @override Animation<int> get byBeigeLetterCount => _byBeigeLetterCount;
  @override Animation<double> get taglineOpacity => _taglineOpacity;
  @override Animation<int> get taglineLetterCount => _taglineLetterCount;
  @override Animation<double> get exitFade => _exitFade;

  @override
  Future<void> resolveAuthState() async {
    final authCubit = sl<AuthCubit>();

    while (authCubit.state is AuthInitial) {
      await Future.delayed(const Duration(milliseconds: 100));
    }

    if (!mounted) return;

    if (authCubit.state is AuthAuthenticated) {
      context.goNamed('home');
    } else {
      context.goNamed(OnboardingScreen.route);
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _kibaController.dispose();
    _byBeigeController.dispose();
    _taglineController.dispose();
    _exitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => view.build(context);
}