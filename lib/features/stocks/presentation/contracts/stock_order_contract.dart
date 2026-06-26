part of '../controllers/stock_order_controller.dart';

abstract class StockOrderControllerContract {
  StockData get stock;
  StockOrderType get orderType;
  StockOrderMode get orderMode;
  double get sharesCount;
  double get limitPrice;
  bool get termsAccepted;
  bool get isLoading;
  double get estimatedTotal;
  double get walletBalance;
  bool get canProceed;

  void onOrderModeChanged(StockOrderMode mode);
  void onSharesChanged(String val);
  void onLimitPriceChanged(String val);
  void onToggleTerms();
  void onConfirm();
  void onBack();
}

abstract class StockOrderViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}