part of '../controllers/withdraw_amount_controller.dart';

abstract class WithdrawAmountControllerContract {
  TextEditingController get amountCtrl;
  ValueNotifier<double?> get parsedAmount;
  ValueNotifier<String?> get errorMessage;
  double get availableBalance;

  void onQuickSelect(double percent);
  void onContinue();

  String? validateAmount(String? value);
}

abstract class WithdrawAmountViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}
