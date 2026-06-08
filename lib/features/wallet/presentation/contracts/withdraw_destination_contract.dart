part of '../controllers/withdraw_destination_controller.dart';

abstract class WithdrawDestinationControllerContract {
  ValueNotifier<String?> get selectedAccountId;
  List<LinkedBankAccount> get accounts;
  double get amount;

  void onSelectAccount(String id);
  void onAddNewAccount();
  void onReviewWithdrawal();
}

abstract class WithdrawDestinationViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}
