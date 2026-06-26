part of '../controllers/stock_order_success_controller.dart';

abstract class StockOrderSuccessControllerContract {
  StockData get stock;
  StockOrderType get orderType;
  double get shares;
  double get pricePerShare;
  double get total;
  StockOrderMode get orderMode;

  AnimationController get checkController;
  AnimationController get particleController;
  Animation<double> get checkScale;
  Animation<double> get checkOpacity;
  Animation<double> get ringScale;
  Animation<double> get ringOpacity;
  Animation<Offset> get contentSlide;
  Animation<double> get contentOpacity;

  void onViewPortfolio();
  void onTradeAgain();
}

abstract class StockOrderSuccessViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}