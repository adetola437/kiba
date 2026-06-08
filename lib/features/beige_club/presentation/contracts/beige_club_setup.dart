part of '../controllers/beige_club_setup_controller.dart';



abstract class BeigeClubSetupControllerContract {
  double get selectedAmount;
  String get selectedMonth;
  ContributionMode get contributionMode;
  bool get canContinue;

  // Computed projections
  double get totalContributed;
  double get projectedInterest;
  double get yearEndPayout;
  double get dailyAccrual;

  void onAmountSelected(double amount);
  void onMonthSelected(String month);
  void onModeChanged(ContributionMode mode);
  void onContinue();
  void onBack();
}

abstract class BeigeClubSetupViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}

