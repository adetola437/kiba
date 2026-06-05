import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/models/tenor.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/contract.dart';
import 'confirm_investment_controller.dart';

part '../contracts/new_investment_contract.dart';
part '../views/new_investment_view.dart';
part '../widgets/tenor_chip.dart';
part '../widgets/project_return_card.dart';

class NewInvestmentScreen extends StatefulWidget {
  static const String route = 'new_investment';

  final String productName;
  final double minAmount;

  const NewInvestmentScreen({
    super.key,
    required this.productName,
    this.minAmount = 100000,
  });

  @override
  State<NewInvestmentScreen> createState() => _NewInvestmentScreenState();
}

class _NewInvestmentScreenState extends State<NewInvestmentScreen>
    implements NewInvestmentControllerContract {
  late final NewInvestmentViewContract view;


  @override
  String get productName => widget.productName;

  @override
  TenorOption selectedTenor = kTenors[1]; // 90 days default

  @override
  double enteredAmount = 100000;

  @override
  final double walletBalance = 2450000;

  @override
  String get displayAmount =>
      NumberFormat('#,##0', 'en_US').format(enteredAmount);

  @override
  bool get canProceed =>
      enteredAmount >= widget.minAmount &&
      enteredAmount <= walletBalance;

  @override
  double get projectedInterest =>
      enteredAmount * (selectedTenor.rate / 100) *
      (selectedTenor.days / 365);

  @override
  double get totalAtMaturity => enteredAmount + projectedInterest;

  @override
  DateTime get maturityDate =>
      DateTime.now().add(Duration(days: selectedTenor.days));

  @override
  void initState() {
    super.initState();
    view = NewInvestmentView(controller: this);
    amountController = TextEditingController(
      text: NumberFormat('#,##0', 'en_US').format(enteredAmount),
    );
  }

  @override
  void onTenorSelected(TenorOption tenor) =>
      setState(() => selectedTenor = tenor);

  @override
  void onAmountChanged(String value) {
    final clean = value.replaceAll(',', '').replaceAll('₦', '');
    final parsed = double.tryParse(clean) ?? 0;
    setState(() => enteredAmount = parsed);
  }

  @override
  void onQuickAmount(double amount) {
    setState(() {
      enteredAmount = amount;
      amountController?.text =
          NumberFormat('#,##0', 'en_US').format(amount);
    });
  }

  @override
  void onFundWallet() => context.pushNamed('fund_wallet');

  @override
  void onProceed() {
    if (!canProceed) return;
    context.pushNamed(
      ConfirmInvestmentScreen.route,
      extra: {
        'productName': productName,
        'tenor': selectedTenor,
        'amount': enteredAmount,
        'interest': projectedInterest,
        'total': totalAtMaturity,
        'maturityDate': maturityDate,
      },
    );
  }

  @override
  void onBack() => context.pop();

  @override
  void dispose() {
    amountController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => view.build(context);

  @override
  TextEditingController? amountController = TextEditingController();
}