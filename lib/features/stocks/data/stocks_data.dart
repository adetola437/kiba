import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../core/utils/enums.dart';



class StockData {
  final String id;
  final String ticker;
  final String name;
  final String exchange; // e.g. 'NGX', 'NASDAQ'
  final double price;
  final double changeAmount;
  final double changePercent;
  final double openPrice;
  final double highPrice;
  final double lowPrice;
  final double marketCap; // in billions
  final double peRatio;
  final double dividendYield;
  final double volume; // in millions
  final StockSector sector;
  final bool isFavorite;
  final bool isNigerian; // NGX vs foreign (e.g. US stocks)
  final List<double> sparklineData; // last 7 price points for mini chart
  final Color iconBg;

  const StockData({
    required this.id,
    required this.ticker,
    required this.name,
    required this.exchange,
    required this.price,
    required this.changeAmount,
    required this.changePercent,
    required this.openPrice,
    required this.highPrice,
    required this.lowPrice,
    required this.marketCap,
    required this.peRatio,
    required this.dividendYield,
    required this.volume,
    required this.sector,
    required this.sparklineData,
    required this.iconBg,
    this.isFavorite = false,
    this.isNigerian = true,
  });

  bool get isGainer => changePercent >= 0;

  String get formattedPrice => isNigerian
      ? '₦${price.toStringAsFixed(2)}'
      : '\$${price.toStringAsFixed(2)}';

  String get formattedChange =>
      '${isGainer ? '+' : ''}${changePercent.toStringAsFixed(2)}%';

  Color get changeColor =>
      isGainer ? const Color(0xFF1A8C5B) : const Color(0xFFB00020);

  Color get changeBgColor =>
      isGainer ? const Color(0xFFEAF7F1) : const Color(0xFFFCE8EB);
}

/// My stock holding in the portfolio
class StockHolding {
  final StockData stock;
  final double shares;
  final double avgBuyPrice;

  const StockHolding({
    required this.stock,
    required this.shares,
    required this.avgBuyPrice,
  });

  double get currentValue => shares * stock.price;
  double get costBasis => shares * avgBuyPrice;
  double get gainLoss => currentValue - costBasis;
  double get gainLossPercent => ((currentValue - costBasis) / costBasis) * 100;
  bool get isProfit => gainLoss >= 0;

  String get formattedValue => stock.isNigerian
      ? '₦${currentValue.toStringAsFixed(2)}'
      : '\$${currentValue.toStringAsFixed(2)}';
}

// ── Mock data ──────────────────────────────────────────────────────────────────

final kNgxStocks = <StockData>[
  const StockData(
    id: 'dangcem',
    ticker: 'DANGCEM',
    name: 'Dangote Cement',
    exchange: 'NGX',
    price: 512.00,
    changeAmount: 12.50,
    changePercent: 2.50,
    openPrice: 500.00,
    highPrice: 515.00,
    lowPrice: 498.00,
    marketCap: 8.72,
    peRatio: 11.4,
    dividendYield: 6.2,
    volume: 3.1,
    sector: StockSector.consumer,
    sparklineData: [488, 492, 497, 501, 499, 505, 512],
    iconBg: AppColors.limeGreen,
  ),
  const StockData(
    id: 'mtnn',
    ticker: 'MTNN',
    name: 'MTN Nigeria',
    exchange: 'NGX',
    price: 198.50,
    changeAmount: -3.10,
    changePercent: -1.54,
    openPrice: 202.00,
    highPrice: 203.50,
    lowPrice: 197.00,
    marketCap: 4.01,
    peRatio: 8.6,
    dividendYield: 8.1,
    volume: 5.7,
    sector: StockSector.telecoms,
    sparklineData: [205, 203, 201, 202, 200, 199, 198.5],
    iconBg: AppColors.beigePink,
    isFavorite: true,
  ),
  const StockData(
    id: 'zenithbank',
    ticker: 'ZENITHBANK',
    name: 'Zenith Bank',
    exchange: 'NGX',
    price: 36.45,
    changeAmount: 1.20,
    changePercent: 3.41,
    openPrice: 35.20,
    highPrice: 37.00,
    lowPrice: 35.00,
    marketCap: 1.14,
    peRatio: 4.2,
    dividendYield: 10.5,
    volume: 28.4,
    sector: StockSector.finance,
    sparklineData: [33, 34, 34.5, 35, 35.2, 36, 36.45],
    iconBg: AppColors.cloudyBlue,
    isFavorite: true,
  ),
  const StockData(
    id: 'gtco',
    ticker: 'GTCO',
    name: 'Guaranty Trust',
    exchange: 'NGX',
    price: 44.10,
    changeAmount: 0.90,
    changePercent: 2.08,
    openPrice: 43.20,
    highPrice: 44.50,
    lowPrice: 43.00,
    marketCap: 1.30,
    peRatio: 5.1,
    dividendYield: 9.3,
    volume: 21.0,
    sector: StockSector.finance,
    sparklineData: [41, 42, 42.5, 43, 43.2, 43.8, 44.1],
    iconBg: AppColors.limeGreen,
  ),
  const StockData(
    id: 'airtelaf',
    ticker: 'AIRTELAFRI',
    name: 'Airtel Africa',
    exchange: 'NGX',
    price: 2240.00,
    changeAmount: -40.00,
    changePercent: -1.75,
    openPrice: 2290.00,
    highPrice: 2300.00,
    lowPrice: 2220.00,
    marketCap: 8.30,
    peRatio: 15.2,
    dividendYield: 3.4,
    volume: 0.8,
    sector: StockSector.telecoms,
    sparklineData: [2310, 2295, 2280, 2275, 2260, 2245, 2240],
    iconBg: AppColors.beigePink,
  ),
  const StockData(
    id: 'nnpcl',
    ticker: 'NNPCL',
    name: 'NNPC Limited',
    exchange: 'NGX',
    price: 285.00,
    changeAmount: 5.50,
    changePercent: 1.97,
    openPrice: 279.50,
    highPrice: 287.00,
    lowPrice: 278.00,
    marketCap: 12.50,
    peRatio: 9.8,
    dividendYield: 4.1,
    volume: 6.2,
    sector: StockSector.energy,
    sparklineData: [270, 274, 276, 278, 280, 282, 285],
    iconBg: AppColors.cloudyBlue,
  ),
];

final kMyStockHoldings = <StockHolding>[
  StockHolding(
    stock: kNgxStocks[2], // ZENITHBANK
    shares: 500,
    avgBuyPrice: 30.20,
  ),
  StockHolding(
    stock: kNgxStocks[0], // DANGCEM
    shares: 20,
    avgBuyPrice: 480.00,
  ),
  StockHolding(
    stock: kNgxStocks[1], // MTNN
    shares: 100,
    avgBuyPrice: 210.00,
  ),
];

const kQuickStockAmounts = <double>[5000, 10000, 25000, 50000];