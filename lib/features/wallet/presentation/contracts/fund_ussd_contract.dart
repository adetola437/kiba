part of '../controllers/fund_ussd_controller.dart';

abstract class FundUssdControllerContract {
  ValueNotifier<String> get searchQuery;
  TextEditingController get searchCtrl;
  List<_UssdBank> get filteredBanks;
  Future<void> onSelectBank(_UssdBank bank);
}

abstract class FundUssdViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}