part of '../controllers/topup_investment_controller.dart';

abstract class TopUpInvestmentControllerContract {
  // Investment context
  String get productName;
  double get currentPrincipal;
  double get currentValue;
  double get annualRate;
  int get daysRemaining;
  DateTime get maturityDate;
  double get walletBalance;

  // Input
  TextEditingController get amountController;
  double get topUpAmount;
  bool get canProceed;

  // Live projections — based on days remaining
  double get revisedPrincipal;
  double get additionalInterest;
  double get revisedTotalAtMaturity;

  void onAmountChanged(String value);
  void onQuickAmount(double amount);
  void onProceed();
  void onBack();
}

abstract class TopUpInvestmentViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}

abstract class BaseViewContract {}