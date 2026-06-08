part of '../controllers/investment_details_controller.dart';


abstract class InvestmentDetailControllerContract {
  InvestmentProduct get product;
  bool get hasActiveInvestment;
  ActiveInvestmentDetail? get activeInvestment;
  bool get balanceVisible;
  bool get isNearMaturity;
  bool get isMatured;

  // Pre-investment estimator
  double get estimatorAmount;
  double get estimatedInterest;
  double get estimatedTotal;
  DateTime get estimatedMaturityDate;

  TextEditingController?  estimatorController;

  void onToggleBalance();
  void onEstimatorAmountChanged(String value);
  void onInvestNow();
  void onTopUp();
  void onRollOver();
  void onWithdraw();
  void onSeeAllTransactions();
  void onContactSupport();
  void onBack();
}

abstract class InvestmentDetailViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}

