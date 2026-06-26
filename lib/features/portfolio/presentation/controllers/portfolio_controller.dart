import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:kiba/features/invest/presentation/controllers/investment_details_controller.dart';
import 'package:kiba/features/invest/presentation/controllers/new_investment_controller.dart';

import '../../../../core/models/investment_data.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/contract.dart';
import '../../../stocks/data/stock_order.dart';
import '../../../stocks/data/stocks_data.dart';
import '../../../stocks/presentation/controllers/stock_detail_controller.dart';
import '../../../stocks/presentation/widgets/pending_orders_section.dart';

part '../contracts/portfolio_contract.dart';
part '../views/portfolio_view.dart';
part '../widgets/portfolio_stats_card.dart';
part '../widgets/portfolio_filter_tabs.dart';
part '../widgets/investment_card.dart';
part '../widgets/portfolio_empty_state.dart';
part '../widgets/stock_holdings_section.dart'; // new

class PortfolioScreen extends StatefulWidget {
  static const String route = 'portfolio';
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen>
    implements PortfolioControllerContract {
  late final PortfolioViewContract view;

  @override
  bool balanceVisible = true;

  @override
  PortfolioFilter activeFilter = PortfolioFilter.all;

  @override
  PortfolioSort activeSort = PortfolioSort.maturityDate;

  // ── Stock holdings (replace with real data source when ready) ─────────────
  @override
  List<StockHolding> get stockHoldings => kMyStockHoldings;

  @override
  bool get hasStocks => stockHoldings.isNotEmpty;

  @override
  List<InvestmentData> get filteredInvestments {
    List<InvestmentData> list;
    switch (activeFilter) {
      case PortfolioFilter.all:
      case PortfolioFilter.stocks: // stocks tab shows its own widget, not this list
        list = List.from(kInvestments);
      case PortfolioFilter.active:
        list = kInvestments.where((i) => !i.isMatured).toList();
      case PortfolioFilter.matured:
        list = kInvestments.where((i) => i.isMatured).toList();
    }

    switch (activeSort) {
      case PortfolioSort.maturityDate:
        list.sort((a, b) => a.maturityDate.compareTo(b.maturityDate));
      case PortfolioSort.amountInvested:
        list.sort((a, b) => b.principal.compareTo(a.principal));
      case PortfolioSort.returns:
        list.sort((a, b) => b.returns.compareTo(a.returns));
      case PortfolioSort.dateCreated:
        list.sort((a, b) => a.startDate.compareTo(b.startDate));
    }

    return list;
  }

  @override
  void initState() {
    super.initState();
    view = PortfolioView(controller: this);
  }

  @override
  void onToggleBalance() => setState(() => balanceVisible = !balanceVisible);

  @override
  void onFilterChanged(PortfolioFilter filter) =>
      setState(() => activeFilter = filter);

  @override
  void onSortChanged(PortfolioSort sort) {
    setState(() => activeSort = sort);
    Navigator.of(context).pop();
  }

  @override
  void onInvestmentTap(InvestmentData investment) =>
      context.pushNamed(InvestmentDetailScreen.route,
          extra: {'hasActiveInvestment': true});

  @override
  void onStockHoldingTap(StockHolding holding) =>
      context.pushNamed(StockDetailScreen.route, extra: holding.stock);

  @override
  void onNewInvestment() => context.goNamed(NewInvestmentScreen.route);

  final _pendingOrders = ValueNotifier<List<StockOrder>>(List.from(kPendingOrders));
 
@override
List<StockOrder> get pendingOrders => _pendingOrders.value;
 
@override
void onCancelOrder(StockOrder order) {
  // Mark as cancelled then remove from the list
  _pendingOrders.value = _pendingOrders.value
      .where((o) => o.id != order.id)
      .toList();
  setState(() {}); // trigger rebuild
 
  // TODO: call your API to cancel the order on the backend
}



  @override
  Widget build(BuildContext context) => view.build(context);

  @override
void dispose() {
  _pendingOrders.dispose();
  super.dispose();
}
}