part of '../controllers/add_bank_account_controller.dart';

abstract class AddBankAccountControllerContract {
  GlobalKey<FormState> get formKey;
  TextEditingController get accountNumberCtrl;
  TextEditingController get bankNameCtrl;
  ValueNotifier<String?> get resolvedAccountName;
  ValueNotifier<bool> get isResolving;
  ValueNotifier<bool> get isSaving;
  ValueNotifier<String?> get selectedBank;
  List<String> get banks;

  void onBankSelected(String? bank);
  Future<void> onSave();
}

abstract class AddBankAccountViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}
