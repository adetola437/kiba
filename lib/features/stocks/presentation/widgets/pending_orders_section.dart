// lib/features/stocks/presentation/widgets/pending_orders_section.dart
//
// Drop inside the StockHoldingsSection in portfolio, OR on the
// Stocks hub screen under the watchlist.
// Call: PendingOrdersSection(orders: controller.pendingOrders, onCancel: ...)

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/enums.dart';
import '../../data/stock_order.dart';

class PendingOrdersSection extends StatelessWidget {
  final List<StockOrder> orders;
  final void Function(StockOrder) onCancel;

  const PendingOrdersSection({
    super.key,
    required this.orders,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) return const SizedBox.shrink();

    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Header ─────────────────────────────────────────────────
        Row(
          children: [
            Container(
              width: 8.r,
              height: 8.r,
              decoration: BoxDecoration(
                color: colorScheme.tertiary,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              'Pending Orders',
              style: textTheme.titleLarge,
            ),
            SizedBox(width: 8.w),
            Container(
              padding: REdgeInsets.symmetric(horizontal: 7, vertical: 2),
              decoration: BoxDecoration(
                color: colorScheme.tertiary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                '${orders.length}',
                style: textTheme.labelSmall?.copyWith(
                  color: colorScheme.tertiary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 6.h),

        Text(
          'These limit orders will execute automatically when the market price reaches your target.',
          style: textTheme.bodySmall,
        ),

        SizedBox(height: 12.h),

        // ── Order cards ─────────────────────────────────────────────
        ...orders.map(
          (order) => Padding(
            padding: REdgeInsets.only(bottom: 10),
            child: _PendingOrderCard(
              order: order,
              onCancel: () => _showCancelSheet(context, order),
            ),
          ),
        ),
      ],
    );
  }

  void _showCancelSheet(BuildContext context, StockOrder order) {
    final colorScheme = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      backgroundColor: colorScheme.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => _CancelOrderSheet(
        order: order,
        onConfirm: () {
          Navigator.of(context).pop();
          onCancel(order);
        },
        onDismiss: () => Navigator.of(context).pop(),
      ),
    );
  }
}

// ── Pending order card ─────────────────────────────────────────────────────────
class _PendingOrderCard extends StatelessWidget {
  final StockOrder order;
  final VoidCallback onCancel;

  const _PendingOrderCard({required this.order, required this.onCancel});

  String _fmt(double v) =>
      '₦${NumberFormat('#,##0.00', 'en_US').format(v)}';

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final isBuy = order.orderType == StockOrderType.buy;
    final currentPrice = order.stock.price;

    final typeColor = isBuy ? colorScheme.primary : colorScheme.error;
    final typeBg = isBuy
        ? colorScheme.primary.withOpacity(0.12)
        : colorScheme.error.withOpacity(0.12);
    final ticker = order.stock.ticker;

    return Container(
      padding: REdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Top row ──────────────────────────────────────────────
          Row(
            children: [
              // Ticker badge
              Container(
                width: 38.r,
                height: 38.r,
                decoration: BoxDecoration(
                  color: order.stock.iconBg.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(
                  child: Text(
                    ticker.substring(0, ticker.length.clamp(0, 3)),
                    style: textTheme.labelSmall?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w800,
                      fontSize: 9.sp,
                    ),
                  ),
                ),
              ),

              SizedBox(width: 10.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          order.stock.ticker,
                          style: textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        // BUY / SELL badge
                        Container(
                          padding: REdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: typeBg,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Text(
                            isBuy ? 'LIMIT BUY' : 'LIMIT SELL',
                            style: textTheme.labelSmall?.copyWith(
                              color: typeColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 8.sp,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      order.stock.name,
                      style: textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Pending badge
              Container(
                padding: REdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: colorScheme.tertiary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6.r,
                      height: 6.r,
                      decoration: BoxDecoration(
                        color: colorScheme.tertiary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Pending',
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.tertiary,
                        fontWeight: FontWeight.w600,
                        fontSize: 9.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),
          const Divider(height: 1),
          SizedBox(height: 10.h),

          // ── Order details ─────────────────────────────────────────
          Row(
            children: [
              _Detail(
                label: 'SHARES',
                value: order.shares.toStringAsFixed(
                  order.shares == order.shares.roundToDouble() ? 0 : 2,
                ),
              ),
              _Detail(
                label: 'LIMIT PRICE',
                value: _fmt(order.limitPrice),
              ),
              _Detail(
                label: 'MARKET PRICE',
                value: _fmt(currentPrice),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // ── Expiry + cancel ───────────────────────────────────────
          Row(
            children: [
              Icon(
                Icons.schedule_rounded,
                size: 12.r,
                color: colorScheme.onSurfaceVariant,
              ),
              SizedBox(width: 4.w),
              Text(
                'Expires ${DateFormat('d MMM y').format(order.expiresAt)}',
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: onCancel,
                child: Container(
                  padding:
                      REdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: colorScheme.outline,
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    'Cancel Order',
                    style: textTheme.labelSmall?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Cancel confirmation sheet ──────────────────────────────────────────────────
class _CancelOrderSheet extends StatelessWidget {
  final StockOrder order;
  final VoidCallback onConfirm;
  final VoidCallback onDismiss;

  const _CancelOrderSheet({
    required this.order,
    required this.onConfirm,
    required this.onDismiss,
  });

  String _fmt(double v) =>
      '₦${NumberFormat('#,##0.00', 'en_US').format(v)}';

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isBuy = order.orderType == StockOrderType.buy;

    return SingleChildScrollView(
      child: Padding(
        padding: REdgeInsets.fromLTRB(24, 8, 24, 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                margin: REdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: colorScheme.outline,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),

            // Icon
            Container(
              width: 48.r,
              height: 48.r,
              decoration: BoxDecoration(
                color: colorScheme.tertiary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Icon(
                Icons.cancel_outlined,
                size: 24.r,
                color: colorScheme.tertiary,
              ),
            ),

            SizedBox(height: 14.h),

            Text(
              'Cancel this order?',
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),

            SizedBox(height: 6.h),

            Text(
              'Your ${isBuy ? 'buy' : 'sell'} order for ${order.shares.toStringAsFixed(0)} shares of ${order.stock.ticker} at ${_fmt(order.limitPrice)} will be cancelled. No funds will be deducted.',
              style: textTheme.bodyMedium,
            ),

            SizedBox(height: 24.h),

            // Order summary
            Container(
              padding: REdgeInsets.all(14),
              decoration: BoxDecoration(
                color: colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  _SheetRow(label: 'Stock', value: order.stock.ticker),
                  SizedBox(height: 8.h),
                  _SheetRow(
                      label: 'Order type',
                      value: isBuy ? 'Limit Buy' : 'Limit Sell'),
                  SizedBox(height: 8.h),
                  _SheetRow(
                      label: 'Shares',
                      value: order.shares.toStringAsFixed(0)),
                  SizedBox(height: 8.h),
                  _SheetRow(
                      label: 'Limit price', value: _fmt(order.limitPrice)),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: onDismiss,
                    child: Container(
                      height: 52.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(
                            color: colorScheme.outline, width: 1.5),
                      ),
                      child: Text(
                        'Keep Order',
                        style: textTheme.labelLarge,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: GestureDetector(
                    onTap: onConfirm,
                    child: Container(
                      height: 52.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: colorScheme.error,
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Text(
                        'Yes, Cancel',
                        style: textTheme.labelLarge?.copyWith(
                          color: colorScheme.onError,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Helpers ────────────────────────────────────────────────────────────────────
class _Detail extends StatelessWidget {
  final String label;
  final String value;
  const _Detail({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontSize: 8.sp,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            value,
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _SheetRow extends StatelessWidget {
  final String label;
  final String value;
  const _SheetRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}