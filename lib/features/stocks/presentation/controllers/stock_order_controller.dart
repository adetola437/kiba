import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/contract.dart';
import '../../../../core/utils/enums.dart';
import '../../data/stocks_data.dart';
import 'stock_order_success_controller.dart';

part '../contracts/stock_order_contract.dart';
part '../views/stock_order_view.dart';
part '../widgets/order_mode_toggle.dart';
part '../widgets/shares_amount_input.dart';

class StockOrderScreen extends StatefulWidget {
  static const String route = 'stock_order';

  final StockData stock;
  final StockOrderType orderType;

  const StockOrderScreen({
    super.key,
    required this.stock,
    required this.orderType,
  });

  @override
  State<StockOrderScreen> createState() => _StockOrderScreenState();
}

class _StockOrderScreenState extends State<StockOrderScreen>
    implements StockOrderControllerContract {
  late final StockOrderViewContract view;

  @override
  StockData get stock => widget.stock;

  @override
  StockOrderType get orderType => widget.orderType;

  @override
  StockOrderMode orderMode = StockOrderMode.market;

  @override
  double sharesCount = 0;

  @override
  double limitPrice = 0;

  @override
  bool termsAccepted = false;

  @override
  bool isLoading = false;

  final TextEditingController sharesController = TextEditingController();
  final TextEditingController limitController = TextEditingController();

  @override
  double get estimatedTotal => sharesCount * _effectivePrice;

  double get _effectivePrice =>
      orderMode == StockOrderMode.market ? stock.price : limitPrice;

  @override
  double get walletBalance => 2450000;

  @override
  bool get canProceed {
    if (sharesCount <= 0) return false;
    if (orderType == StockOrderType.buy &&
        estimatedTotal > walletBalance) return false;
    if (orderMode == StockOrderMode.limit && limitPrice <= 0) return false;
    if (!termsAccepted) return false;
    return true;
  }

  @override
  void initState() {
    super.initState();
    limitPrice = stock.price;
    limitController.text = stock.price.toStringAsFixed(2);
    view = StockOrderView(controller: this);
  }

  @override
  void onOrderModeChanged(StockOrderMode mode) =>
      setState(() => orderMode = mode);

  @override
  void onSharesChanged(String val) {
    final parsed = double.tryParse(val.replaceAll(',', '')) ?? 0;
    setState(() => sharesCount = parsed);
  }

  @override
  void onLimitPriceChanged(String val) {
    final parsed = double.tryParse(val.replaceAll(',', '')) ?? 0;
    setState(() => limitPrice = parsed);
  }

  @override
  void onToggleTerms() => setState(() => termsAccepted = !termsAccepted);

  @override
  void onConfirm() async {
    if (!canProceed) return;
    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => isLoading = false);
    context.pushNamed(
      StockOrderSuccessScreen.route,
      extra: {
        'stock': stock,
        'orderType': orderType,
        'shares': sharesCount,
        'pricePerShare': _effectivePrice,
        'total': estimatedTotal,
        'orderMode': orderMode,
      },
    );
  }

  @override
  void onBack() => context.pop();

  @override
  void dispose() {
    sharesController.dispose();
    limitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => view.build(context);
}