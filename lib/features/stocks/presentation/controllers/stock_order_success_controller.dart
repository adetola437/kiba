import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/contract.dart';
import '../../../../core/utils/enums.dart';
import '../../data/stocks_data.dart';

part '../contracts/stock_order_success_contract.dart';
part '../views/stock_order_success_view.dart';

class StockOrderSuccessScreen extends StatefulWidget {
  static const String route = 'stock_order_success';

  final StockData stock;
  final StockOrderType orderType;
  final double shares;
  final double pricePerShare;
  final double total;
  final StockOrderMode orderMode;

  const StockOrderSuccessScreen({
    super.key,
    required this.stock,
    required this.orderType,
    required this.shares,
    required this.pricePerShare,
    required this.total,
    required this.orderMode,
  });

  @override
  State<StockOrderSuccessScreen> createState() =>
      _StockOrderSuccessScreenState();
}

class _StockOrderSuccessScreenState extends State<StockOrderSuccessScreen>
    with TickerProviderStateMixin
    implements StockOrderSuccessControllerContract {
  late final StockOrderSuccessViewContract view;

  late final AnimationController checkController;
  late final AnimationController particleController;
  late final Animation<double> checkScale;
  late final Animation<double> checkOpacity;
  late final Animation<double> ringScale;
  late final Animation<double> ringOpacity;
  late final Animation<Offset> contentSlide;
  late final Animation<double> contentOpacity;

  @override
  StockData get stock => widget.stock;
  @override
  StockOrderType get orderType => widget.orderType;
  @override
  double get shares => widget.shares;
  @override
  double get pricePerShare => widget.pricePerShare;
  @override
  double get total => widget.total;
  @override
  StockOrderMode get orderMode => widget.orderMode;

  @override
  void initState() {
    super.initState();

    checkController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1800))
      ..forward();

    particleController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000))
      ..forward();

    checkScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: checkController,
          curve: const Interval(0.0, 0.45, curve: Curves.elasticOut)),
    );
    checkOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: checkController,
          curve: const Interval(0.0, 0.25, curve: Curves.easeIn)),
    );
    ringScale = Tween<double>(begin: 0.6, end: 1.6).animate(
      CurvedAnimation(
          parent: checkController,
          curve: const Interval(0.35, 0.85, curve: Curves.easeOut)),
    );
    ringOpacity = Tween<double>(begin: 0.8, end: 0.0).animate(
      CurvedAnimation(
          parent: checkController,
          curve: const Interval(0.35, 0.85, curve: Curves.easeOut)),
    );
    contentSlide = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(CurvedAnimation(
      parent: checkController,
      curve: const Interval(0.45, 0.85, curve: Curves.easeOut),
    ));
    contentOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: checkController,
          curve: const Interval(0.45, 0.80, curve: Curves.easeIn)),
    );

    view = StockOrderSuccessView(controller: this);
  }

  @override
  void onViewPortfolio() {
    context.goNamed('portfolio');
  }

  @override
  void onTradeAgain() => context.pop();

  @override
  void dispose() {
    checkController.dispose();
    particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => view.build(context);
}