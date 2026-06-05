part of '../controllers/investment_success_controller.dart';

abstract class InvestmentSuccessControllerContract {
  String get productName;
  double get amount;
  int get tenorDays;
  double get totalAtMaturity;
  DateTime get maturityDate;

  AnimationController get checkController;
  AnimationController get contentController;
  AnimationController get particleController;

  Animation<double> get checkScale;
  Animation<double> get checkOpacity;
  Animation<double> get ringScale;
  Animation<double> get ringOpacity;
  Animation<double> get contentOpacity;
  Animation<Offset> get contentSlide;

  void onViewPortfolio();
  void onInvestMore();
}

abstract class InvestmentSuccessViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}

