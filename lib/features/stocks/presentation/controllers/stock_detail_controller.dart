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
import 'stock_order_controller.dart';

part '../contracts/stock_detail_contract.dart';
part '../views/stock_detail_view.dart';
part '../widgets/stock_price_chart.dart';
part '../widgets/stock_stats_grid.dart';

class StockDetailScreen extends StatefulWidget {
  static const String route = 'stock_detail';
  final StockData stock;

  const StockDetailScreen({super.key, required this.stock});

  @override
  State<StockDetailScreen> createState() => _StockDetailScreenState();
}

class _StockDetailScreenState extends State<StockDetailScreen>
    implements StockDetailControllerContract {
  late final StockDetailViewContract view;

  @override
  StockData get stock => widget.stock;

  @override
  bool isFavorite = false;

  @override
  ChartRange selectedRange = ChartRange.oneWeek;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.stock.isFavorite;
    view = StockDetailView(controller: this);
  }

  @override
  void onToggleFavorite() => setState(() => isFavorite = !isFavorite);

  @override
  void onRangeChanged(ChartRange range) =>
      setState(() => selectedRange = range);

  @override
  void onBuyTap() {
    context.pushNamed(
      StockOrderScreen.route,
      extra: {
        'stock': stock,
        'orderType': StockOrderType.buy,
      },
    );
  }

  @override
  void onSellTap() {
    context.pushNamed(
      StockOrderScreen.route,
      extra: {
        'stock': stock,
        'orderType': StockOrderType.sell,
      },
    );
  }

  @override
  void onBack() => context.pop();

  @override
  Widget build(BuildContext context) => view.build(context);
}

enum ChartRange { oneDay, oneWeek, oneMonth, threeMonths, oneYear }