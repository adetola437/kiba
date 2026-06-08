part of '../controllers/fund_bank_transfer_controller.dart';

abstract class FundBankTransferControllerContract {
  void onCopyAccountNumber();
}

abstract class FundBankTransferViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}