import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/contract.dart';

part '../contracts/investment_success_contract.dart';
part '../views/investment_success_view.dart';

class InvestmentSuccessScreen extends StatefulWidget {
  static const String route = 'investment_success';

  final String productName;
  final double amount;
  final int tenorDays;
  final double totalAtMaturity;
  final DateTime maturityDate;

  const InvestmentSuccessScreen({
    super.key,
    required this.productName,
    required this.amount,
    required this.tenorDays,
    required this.totalAtMaturity,
    required this.maturityDate,
  });

  @override
  State<InvestmentSuccessScreen> createState() =>
      _InvestmentSuccessScreenState();
}

class _InvestmentSuccessScreenState extends State<InvestmentSuccessScreen>
    with TickerProviderStateMixin
    implements InvestmentSuccessControllerContract {
  late final InvestmentSuccessViewContract view;

  @override late final AnimationController checkController;
  @override late final AnimationController contentController;
  @override late final AnimationController particleController;

  @override late Animation<double> checkScale;
  @override late Animation<double> checkOpacity;
  @override late Animation<double> ringScale;
  @override late Animation<double> ringOpacity;
  @override late Animation<double> contentOpacity;
  @override late Animation<Offset> contentSlide;

  @override String   get productName    => widget.productName;
  @override double   get amount         => widget.amount;
  @override int      get tenorDays      => widget.tenorDays;
  @override double   get totalAtMaturity => widget.totalAtMaturity;
  @override DateTime get maturityDate   => widget.maturityDate;

  @override
  void initState() {
    super.initState();
    view = InvestmentSuccessView(controller: this);
    _setupAnimations();
    _startFlow();
  }

  void _setupAnimations() {
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
    ringScale = Tween<double>(begin: 0.6, end: 2.0).animate(
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

    contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    contentOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: contentController, curve: Curves.easeOut),
    );
    contentSlide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: contentController, curve: Curves.easeOut),
    );

    // Particle confetti controller — loops
    particleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
  }

  Future<void> _startFlow() async {
    await Future.delayed(const Duration(milliseconds: 300));
    checkController.forward();
    particleController.repeat();

    await Future.delayed(const Duration(milliseconds: 500));
    contentController.forward();
  }

  @override
  void onViewPortfolio() => context.goNamed('portfolio');

  @override
  void onInvestMore() => context.goNamed('invest');

  @override
  void dispose() {
    checkController.dispose();
    contentController.dispose();
    particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => view.build(context);
}