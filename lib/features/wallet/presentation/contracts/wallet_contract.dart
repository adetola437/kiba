part of '../controllers/wallet_controller.dart';

abstract class WalletControllerContract {
  bool get balanceVisible;
  void onToggleBalance();
  void onFund();
  void onWithdraw();
  void onCopyAccountNumber();
  void onSeeAllTransactions();
}

abstract class WalletViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}

