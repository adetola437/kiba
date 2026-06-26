part of '../controllers/home_controller.dart';

abstract class HomeControllerContract {
  String get greeting;
  bool get balanceVisible;

void onUpgradeTier();
  void onToggleBalance();
  void onNotificationTap();
  void onFundWallet();
  void onWithdraw();
  void onQuickAction(QuickAction action);
  void onSeeAllInvestments();
  void onViewHistory();
  void onEnterBeigeClub();
}

abstract class HomeViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}



