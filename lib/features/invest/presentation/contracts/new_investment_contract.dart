part of '../controllers/new_investment_controller.dart';




abstract class NewInvestmentControllerContract {
  String get productName;
  TenorOption get selectedTenor;
  double get enteredAmount;
  String get displayAmount;
  double get walletBalance;
  bool get canProceed;

  // Computed
  double get projectedInterest;
  double get totalAtMaturity;
  DateTime get maturityDate;

  TextEditingController? amountController;

  void onTenorSelected(TenorOption tenor);
  void onAmountChanged(String value);
  void onQuickAmount(double amount);
  void onFundWallet();
  void onProceed();
  void onBack();
}

abstract class NewInvestmentViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}
