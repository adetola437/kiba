part of '../controllers/stocks_controller.dart';

abstract class StocksControllerContract {
  bool get isLoading;
  StockSector get activeSector;
  String get searchQuery;
  bool get isSearching;
  List<StockData> get filteredStocks;
  List<StockData> get watchlist;

  void onSectorChanged(StockSector sector);
  void onSearchChanged(String query);
  void onToggleSearch();
  void onStockTap(StockData stock);
  void onSeeAllTap();
}

abstract class StocksViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}