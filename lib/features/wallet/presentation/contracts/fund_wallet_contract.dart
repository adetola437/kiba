part of '../controllers/fund_wallet_controller.dart';

abstract class FundWalletControllerContract {
  void onSelectDebitCard();
  void onSelectBankTransfer();
  void onSelectUssd();
  void onSelectVirtualAccount();
}

abstract class FundWalletViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}