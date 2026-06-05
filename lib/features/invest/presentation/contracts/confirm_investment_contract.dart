part of '../controllers/confirm_investment_controller.dart';

abstract class ConfirmInvestmentControllerContract {
  String get productName;
  int get tenorDays;
  double get annualRate;
  double get amount;
  double get projectedInterest;
  double get totalAtMaturity;
  DateTime get maturityDate;
  bool get termsAccepted;
  bool get isLoading;

  void onToggleTerms();
  void onConfirm();
  void onBack();
}

abstract class ConfirmInvestmentViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}

