import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/contract.dart';
import 'investment_success_controller.dart';

part '../contracts/confirm_investment_contract.dart';
part '../views/confirm_investment_view.dart';

class ConfirmInvestmentScreen extends StatefulWidget {
  static const String route = 'confirm_investment';

  final String productName;
  final int tenorDays;
  final double annualRate;
  final double amount;
  final double projectedInterest;
  final double totalAtMaturity;
  final DateTime maturityDate;

  const ConfirmInvestmentScreen({
    super.key,
    required this.productName,
    required this.tenorDays,
    required this.annualRate,
    required this.amount,
    required this.projectedInterest,
    required this.totalAtMaturity,
    required this.maturityDate,
  });

  @override
  State<ConfirmInvestmentScreen> createState() =>
      _ConfirmInvestmentScreenState();
}

class _ConfirmInvestmentScreenState extends State<ConfirmInvestmentScreen>
    implements ConfirmInvestmentControllerContract {
  late final ConfirmInvestmentViewContract view;

  @override bool termsAccepted = false;
  @override bool isLoading = false;

  @override String get productName     => widget.productName;
  @override int    get tenorDays       => widget.tenorDays;
  @override double get annualRate      => widget.annualRate;
  @override double get amount          => widget.amount;
  @override double get projectedInterest => widget.projectedInterest;
  @override double get totalAtMaturity => widget.totalAtMaturity;
  @override DateTime get maturityDate  => widget.maturityDate;

  @override
  void initState() {
    super.initState();
    view = ConfirmInvestmentView(controller: this);
  }

  @override
  void onToggleTerms() => setState(() => termsAccepted = !termsAccepted);

  @override
  Future<void> onConfirm() async {
    if (!termsAccepted || isLoading) return;
    setState(() => isLoading = true);

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 2200));

    if (!mounted) return;
    setState(() => isLoading = false);

    context.goNamed(
      InvestmentSuccessScreen.route,
      extra: {
        'productName': productName,
        'amount': amount,
        'tenorDays': tenorDays,
        'totalAtMaturity': totalAtMaturity,
        'maturityDate': maturityDate,
      },
    );
  }

  @override
  void onBack() => context.pop();

  @override
  Widget build(BuildContext context) => view.build(context);
}