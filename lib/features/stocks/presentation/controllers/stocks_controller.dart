import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:kiba/core/widgets/general_app_bar.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/contract.dart';
import '../../../../core/utils/enums.dart';
import '../../data/stocks_data.dart';
import 'stock_detail_controller.dart';
import 'stock_order_controller.dart';

part '../contracts/stocks_contract.dart';
part '../views/stocks_view.dart';
part '../widgets/stocks_hero_banner.dart';
part '../widgets/stock_card.dart';
part '../widgets/sector_tabs.dart';
part '../widgets/market_indices_strip.dart';
part '../widgets/stocks_watchlist_section.dart';

class StocksScreen extends StatefulWidget {
  static const String route = 'stocks';
  const StocksScreen({super.key});

  @override
  State<StocksScreen> createState() => _StocksScreenState();
}

class _StocksScreenState extends State<StocksScreen>
    implements StocksControllerContract {
  late final StocksViewContract view;

  @override
  bool isLoading = true;

  @override
  StockSector activeSector = StockSector.all;

  @override
  String searchQuery = '';

  @override
  bool isSearching = false;

  final TextEditingController searchController = TextEditingController();

  @override
  List<StockData> get filteredStocks {
    var list = kNgxStocks;
    if (activeSector != StockSector.all) {
      list = list.where((s) => s.sector == activeSector).toList();
    }
    if (searchQuery.isNotEmpty) {
      final q = searchQuery.toLowerCase();
      list = list
          .where((s) =>
              s.ticker.toLowerCase().contains(q) ||
              s.name.toLowerCase().contains(q))
          .toList();
    }
    return list;
  }

  @override
  List<StockData> get watchlist =>
      kNgxStocks.where((s) => s.isFavorite).toList();

  @override
  void initState() {
    super.initState();
    view = StocksView(controller: this);
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) setState(() => isLoading = false);
    });
  }

  @override
  void onSectorChanged(StockSector sector) =>
      setState(() => activeSector = sector);

  @override
  void onSearchChanged(String query) => setState(() => searchQuery = query);

  @override
  void onToggleSearch() {
    setState(() {
      isSearching = !isSearching;
      if (!isSearching) {
        searchQuery = '';
        searchController.clear();
      }
    });
  }

  @override
  void onStockTap(StockData stock) {
    context.pushNamed(StockDetailScreen.route, extra: stock);
  }

  @override
  void onSeeAllTap() {
    // Navigate to a full list — for now same screen with no filter
    setState(() => activeSector = StockSector.all);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => view.build(context);
}