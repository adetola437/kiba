import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
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
 
  late final AnimationController _iconController;
  late final AnimationController _wordmarkController;
  late final AnimationController _lineController;
 
  late final Animation<double> _iconOpacity;
  late final Animation<double> _iconScale;
  late final Animation<double> _wordmarkOpacity;
  late final Animation<Offset> _wordmarkSlide;
  late final Animation<double> _lineWidth;
 
  @override
  void initState() {
    super.initState();
    view = SplashView(controller: this);
    _setupAnimations();
    _startSplashFlow();
  }
 
  void _setupAnimations() {
    _iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _iconOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _iconController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );
    _iconScale = Tween<double>(begin: 0.75, end: 1.0).animate(
      CurvedAnimation(parent: _iconController, curve: Curves.easeOutBack),
    );
 
    _wordmarkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _wordmarkOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _wordmarkController, curve: Curves.easeOut),
    );
    _wordmarkSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _wordmarkController, curve: Curves.easeOut),
    );
 
    _lineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _lineWidth = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _lineController, curve: Curves.easeOut),
    );
  }
 
  Future<void> _startSplashFlow() async {
    // 1. Run animations sequentially — total ~2200ms
    await Future.delayed(const Duration(milliseconds: 300));
    await _iconController.forward().orCancel;
 
    await Future.delayed(const Duration(milliseconds: 200));
    await _wordmarkController.forward().orCancel;
 
    await Future.delayed(const Duration(milliseconds: 100));
    await _lineController.forward().orCancel;
 
    // 2. Hold for a beat so the fully-rendered screen is visible
    await Future.delayed(const Duration(milliseconds: 600));
 
    // 3. Only NOW resolve auth and route
    await resolveAuthState();
  }
 
  @override Animation<double> get iconOpacity => _iconOpacity;
  @override Animation<double> get iconScale => _iconScale;
  @override Animation<double> get wordmarkOpacity => _wordmarkOpacity;
  @override Animation<Offset> get wordmarkSlide => _wordmarkSlide;
  @override Animation<double> get lineWidth => _lineWidth;
 
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
    _iconController.dispose();
    _wordmarkController.dispose();
    _lineController.dispose();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) => view.build(context);
}