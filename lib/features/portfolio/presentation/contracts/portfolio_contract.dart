part of '../controllers/portfolio_controller.dart';

enum PortfolioFilter { all, active, matured, stocks }

enum PortfolioSort { maturityDate, amountInvested, returns, dateCreated }

abstract class PortfolioControllerContract {
  bool get balanceVisible;
  PortfolioFilter get activeFilter;
  PortfolioSort get activeSort;
  List<InvestmentData> get filteredInvestments;
  List<StockHolding> get stockHoldings;
  bool get hasStocks;

  void onToggleBalance();
  void onFilterChanged(PortfolioFilter filter);
  void onSortChanged(PortfolioSort sort);
  void onInvestmentTap(InvestmentData investment);
  void onStockHoldingTap(StockHolding holding);
  void onNewInvestment();
  List<StockOrder> get pendingOrders;
void onCancelOrder(StockOrder order);
}

abstract class PortfolioViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}