// lib/features/stocks/data/models/stock_order.dart

import '../../../core/utils/enums.dart';
import 'stocks_data.dart';

enum StockOrderStatus { pending, filled, cancelled, expired }

class StockOrder {
  final String id;
  final StockData stock;
  final StockOrderType orderType;   // buy / sell
  final StockOrderMode orderMode;   // market / limit
  final double shares;
  final double limitPrice;          // only meaningful for limit orders
  final double estimatedTotal;
  final DateTime placedAt;
  final DateTime expiresAt;         // e.g. end of trading day (GTC = 30 days)
  final StockOrderStatus status;

  const StockOrder({
    required this.id,
    required this.stock,
    required this.orderType,
    required this.orderMode,
    required this.shares,
    required this.limitPrice,
    required this.estimatedTotal,
    required this.placedAt,
    required this.expiresAt,
    this.status = StockOrderStatus.pending,
  });

  bool get isPending => status == StockOrderStatus.pending;
  bool get isFilled => status == StockOrderStatus.filled;
  bool get isCancelled => status == StockOrderStatus.cancelled;
  bool get isExpired => status == StockOrderStatus.expired;
  bool get isLimitOrder => orderMode == StockOrderMode.limit;

  /// How far the current price is from the limit trigger
  double priceGap(double currentPrice) => (limitPrice - currentPrice).abs();
  double priceGapPercent(double currentPrice) =>
      (priceGap(currentPrice) / currentPrice) * 100;

  StockOrder copyWith({StockOrderStatus? status}) => StockOrder(
        id: id,
        stock: stock,
        orderType: orderType,
        orderMode: orderMode,
        shares: shares,
        limitPrice: limitPrice,
        estimatedTotal: estimatedTotal,
        placedAt: placedAt,
        expiresAt: expiresAt,
        status: status ?? this.status,
      );
}

// ── Mock pending orders ────────────────────────────────────────────────────────
// Replace with your real orders repository/API later.
final kPendingOrders = <StockOrder>[
  StockOrder(
    id: 'ord_001',
    stock: kNgxStocks[0], // DANGCEM
    orderType: StockOrderType.buy,
    orderMode: StockOrderMode.limit,
    shares: 10,
    limitPrice: 490.00,  // waiting for price to drop to ₦490
    estimatedTotal: 4900.00,
    placedAt: DateTime.now().subtract(const Duration(hours: 3)),
    expiresAt: DateTime.now().add(const Duration(days: 30)),
  ),
  StockOrder(
    id: 'ord_002',
    stock: kNgxStocks[2], // ZENITHBANK
    orderType: StockOrderType.sell,
    orderMode: StockOrderMode.limit,
    shares: 200,
    limitPrice: 40.00,   // waiting for price to rise to ₦40
    estimatedTotal: 8000.00,
    placedAt: DateTime.now().subtract(const Duration(minutes: 45)),
    expiresAt: DateTime.now().add(const Duration(days: 30)),
  ),
];