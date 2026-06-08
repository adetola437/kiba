part of '../controllers/withdraw_success_controller.dart';

abstract class WithdrawSuccessControllerContract {
  AnimationController get checkController;
  AnimationController get contentController;
  AnimationController get particleController;
  Animation<double> get checkScale;
  Animation<double> get checkOpacity;
  Animation<double> get ringScale;
  Animation<double> get ringOpacity;
  Animation<double> get contentOpacity;
  Animation<Offset> get contentSlide;

  double get amount;
  LinkedBankAccount get account;
  String get reference;

  void onGoToWallet();
  void onViewTransactions();
}

abstract class WithdrawSuccessViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}
