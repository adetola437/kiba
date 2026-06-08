part of '../controllers/transactions_controller.dart';





abstract class TransactionsControllerContract {
  TransactionFilter get activeFilter;
  String get searchQuery;
  bool get isSearching;
  Map<String, List<TransactionData>> get groupedTransactions;

  TextEditingController? searchController;

  void onFilterChanged(TransactionFilter filter);
  void onSearchToggle();
  void onSearchChanged(String query);
  void onTransactionTap(TransactionData tx);
  void onBack();
}

abstract class TransactionsViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}
