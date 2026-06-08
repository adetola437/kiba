part of '../controllers/withdraw_review_controller.dart';

abstract class WithdrawReviewControllerContract {
  bool get isLoading;
  double get amount;
  LinkedBankAccount get account;
  double get fee;
  double get totalToReceive;

  void onConfirm();
}

abstract class WithdrawReviewViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}
