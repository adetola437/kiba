import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

part '../contracts/topup_investment_contract.dart';
part '../views/topup_investment_view.dart';
part '../views/topup_review.dart';
part '../views/top_up_success.dart';

const _kTopUpQuickAmounts = [50000.0, 100000.0, 250000.0, 500000.0];

class TopUpInvestmentScreen extends StatefulWidget {
  static const String route = 'topup_investment';

  final String productName;
  final double currentPrincipal;
  final double currentValue;
  final double annualRate;
  final int daysRemaining;
  final DateTime maturityDate;

  const TopUpInvestmentScreen({
    super.key,
    required this.productName,
    required this.currentPrincipal,
    required this.currentValue,
    required this.annualRate,
    required this.daysRemaining,
    required this.maturityDate,
  });

  @override
  State<TopUpInvestmentScreen> createState() =>
      _TopUpInvestmentScreenState();
}

class _TopUpInvestmentScreenState extends State<TopUpInvestmentScreen>
    implements TopUpInvestmentControllerContract {
  late final TopUpInvestmentViewContract view;

  @override
  final TextEditingController amountController =
      TextEditingController(text: '50,000');

  @override
  double topUpAmount = 50000;

  @override
  final double walletBalance = 2450000;

  @override String   get productName      => widget.productName;
  @override double   get currentPrincipal => widget.currentPrincipal;
  @override double   get currentValue     => widget.currentValue;
  @override double   get annualRate       => widget.annualRate;
  @override int      get daysRemaining    => widget.daysRemaining;
  @override DateTime get maturityDate     => widget.maturityDate;

  @override
  bool get canProceed =>
      topUpAmount >= 10000 && topUpAmount <= walletBalance;

  @override
  double get revisedPrincipal => currentPrincipal + topUpAmount;

  @override
  double get additionalInterest =>
      topUpAmount * (annualRate / 100) * (daysRemaining / 365);

  @override
  double get revisedTotalAtMaturity =>
      currentValue + topUpAmount + additionalInterest;

  @override
  void initState() {
    super.initState();
    view = TopUpInvestmentView(controller: this);
  }

  @override
  void onAmountChanged(String value) {
    final clean = value.replaceAll(',', '').replaceAll('₦', '');
    final parsed = double.tryParse(clean) ?? 0;
    setState(() => topUpAmount = parsed);
  }

  @override
  void onQuickAmount(double amount) {
    setState(() {
      topUpAmount = amount;
      amountController.text =
          NumberFormat('#,##0', 'en_US').format(amount);
    });
  }

  @override
  void onProceed() {
    if (!canProceed) return;
    context.pushNamed(
      TopUpReviewScreen.route,
      extra: {
        'productName': productName,
        'currentPrincipal': currentPrincipal,
        'currentValue': currentValue,
        'topUpAmount': topUpAmount,
        'annualRate': annualRate,
        'daysRemaining': daysRemaining,
        'maturityDate': maturityDate,
        'revisedPrincipal': revisedPrincipal,
        'additionalInterest': additionalInterest,
        'revisedTotalAtMaturity': revisedTotalAtMaturity,
      },
    );
  }

  @override
  void onBack() => context.pop();

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => view.build(context);
}