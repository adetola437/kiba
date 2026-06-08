import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/contract.dart';
import 'withdraw_destination_controller.dart';

part '../contracts/withdraw_success_contract.dart';
part '../views/withdraw_success_view.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Screen
// ─────────────────────────────────────────────────────────────────────────────

class WithdrawSuccessScreen extends StatefulWidget {
  static const String route = 'withdraw_success';

  final double amount;
  final LinkedBankAccount account;
  final String reference;

  const WithdrawSuccessScreen({
    super.key,
    required this.amount,
    required this.account,
    required this.reference,
  });

  @override
  State<WithdrawSuccessScreen> createState() => _WithdrawSuccessScreenState();
}

class _WithdrawSuccessScreenState extends State<WithdrawSuccessScreen>
    with TickerProviderStateMixin
    implements WithdrawSuccessControllerContract {
  late final WithdrawSuccessViewContract view;

  @override
  late final AnimationController checkController;
  @override
  late final AnimationController contentController;
  @override
  late final AnimationController particleController;

  @override
  late Animation<double> checkScale;
  @override
  late Animation<double> checkOpacity;
  @override
  late Animation<double> ringScale;
  @override
  late Animation<double> ringOpacity;
  @override
  late Animation<double> contentOpacity;
  @override
  late Animation<Offset> contentSlide;

  @override
  double get amount => widget.amount;
  @override
  LinkedBankAccount get account => widget.account;
  @override
  String get reference => widget.reference;

  @override
  void initState() {
    super.initState();
    view = WithdrawSuccessView(controller: this);
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
  void onGoToWallet() => context.goNamed('wallet');

  @override
  void onViewTransactions() => context.goNamed('history');

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
