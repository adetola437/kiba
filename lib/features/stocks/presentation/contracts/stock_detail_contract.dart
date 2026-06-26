part of '../controllers/stock_detail_controller.dart';

abstract class StockDetailControllerContract {
  StockData get stock;
  bool get isFavorite;
  ChartRange get selectedRange;

  void onToggleFavorite();
  void onRangeChanged(ChartRange range);
  void onBuyTap();
  void onSellTap();
  void onBack();
}

abstract class StockDetailViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}