import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/models/investment_data.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/contract.dart';

part '../contracts/portfolio_contract.dart';
part '../views/portfolio_view.dart';
part '../widgets/portfolio_stats_card.dart';
part '../widgets/portfolio_filter_tabs.dart';
part '../widgets/investment_card.dart';
part '../widgets/portfolio_empty_state.dart';

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

  @override
  List<InvestmentData> get filteredInvestments {
    List<InvestmentData> list;
    switch (activeFilter) {
      case PortfolioFilter.all:
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
    Navigator.of(context).pop(); // close bottom sheet
  }

  @override
  void onInvestmentTap(InvestmentData investment) =>
      context.pushNamed('investment_detail', extra: investment);

  @override
  void onNewInvestment() => context.goNamed('invest');

  @override
  Widget build(BuildContext context) => view.build(context);
}