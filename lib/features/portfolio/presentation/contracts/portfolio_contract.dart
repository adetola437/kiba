part of '../controllers/portfolio_controller.dart';

enum PortfolioFilter { all, active, matured }

enum PortfolioSort { maturityDate, amountInvested, returns, dateCreated }

abstract class PortfolioControllerContract {
  bool get balanceVisible;
  PortfolioFilter get activeFilter;
  PortfolioSort get activeSort;
  List<InvestmentData> get filteredInvestments;

  void onToggleBalance();
  void onFilterChanged(PortfolioFilter filter);
  void onSortChanged(PortfolioSort sort);
  void onInvestmentTap(InvestmentData investment);
  void onNewInvestment();
}

abstract class PortfolioViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}
