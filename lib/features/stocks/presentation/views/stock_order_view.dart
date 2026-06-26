part of '../controllers/stock_order_controller.dart';

class StockOrderView extends StatelessWidget implements StockOrderViewContract {
  const StockOrderView({super.key, required this.controller});

  final StockOrderControllerContract controller;

  String _fmt(double v) =>
      '₦${NumberFormat('#,##0.00', 'en_US').format(v)}';

  bool get _isBuy => controller.orderType == StockOrderType.buy;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: controller.onBack,
              child: Icon(
                Icons.arrow_back_rounded,
                size: 22.r,
                color: colorScheme.onSurface,
              ),
            ),
            title: Text(
              _isBuy
                  ? 'Buy ${controller.stock.ticker}'
                  : 'Sell ${controller.stock.ticker}',
              style: textTheme.titleLarge,
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: REdgeInsets.fromLTRB(20, 12, 20, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Order type header ───────────────────────
                      Container(
                        padding: REdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _isBuy
                              ? colorScheme.primary
                              : colorScheme.error,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40.r,
                              height: 40.r,
                              decoration: BoxDecoration(
                                color: colorScheme.onPrimary
                                    .withOpacity(0.12),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Center(
                                child: Text(
                                  controller.stock.ticker.substring(
                                    0,
                                    math.min(
                                      3,
                                      controller.stock.ticker.length,
                                    ),
                                  ),
                                  style: textTheme.labelSmall?.copyWith(
                                    color: colorScheme.primaryContainer,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 9.sp,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.stock.name,
                                    style: textTheme.titleSmall?.copyWith(
                                      color: colorScheme.onPrimary,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    'Market Price: ${controller.stock.formattedPrice}',
                                    style: textTheme.bodySmall?.copyWith(
                                      color: colorScheme.onPrimary
                                          .withOpacity(0.65),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: REdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: colorScheme.onPrimary
                                    .withOpacity(0.15),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Text(
                                _isBuy ? 'BUY' : 'SELL',
                                style: textTheme.labelSmall?.copyWith(
                                  color: colorScheme.onPrimary,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.8,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 24.h),

                      // ── Order mode toggle ───────────────────────
                      Text(
                        'Order Type',
                        style: textTheme.titleSmall,
                      ),
                      SizedBox(height: 10.h),
                      _OrderModeToggle(
                        active: controller.orderMode,
                        onChanged: controller.onOrderModeChanged,
                      ),

                      SizedBox(height: 24.h),

                      // ── Limit price field (if limit order) ───────
                      if (controller.orderMode ==
                          StockOrderMode.limit) ...[
                        Text(
                          'Limit Price (₦)',
                          style: textTheme.titleSmall,
                        ),
                        SizedBox(height: 10.h),
                        TextFormField(
                          initialValue:
                              controller.stock.price.toStringAsFixed(2),
                          onChanged: controller.onLimitPriceChanged,
                          keyboardType:
                              const TextInputType.numberWithOptions(
                                  decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                          style: textTheme.titleMedium,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14.r),
                              borderSide: BorderSide(
                                color: colorScheme.primary
                                    .withOpacity(0.25),
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14.r),
                              borderSide: BorderSide(
                                color: colorScheme.primary,
                                width: 1.5,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                            prefixText: '₦ ',
                            prefixStyle: textTheme.titleMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                            contentPadding: REdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                          ),
                        ),
                        SizedBox(height: 24.h),
                      ],

                      // ── Shares input ─────────────────────────────
                      Text(
                        'Number of Shares',
                        style: textTheme.titleSmall,
                      ),
                      SizedBox(height: 10.h),
                      _SharesAmountInput(controller: controller),

                      SizedBox(height: 20.h),

                      // ── Order summary card ───────────────────────
                      Container(
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(color: colorScheme.outline),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: REdgeInsets.all(16),
                              child: Column(
                                children: [
                                  _SummaryRow(
                                    label: 'Shares',
                                    value: controller.sharesCount
                                        .toStringAsFixed(
                                      controller.sharesCount ==
                                              controller.sharesCount
                                                  .roundToDouble()
                                          ? 0
                                          : 2,
                                    ),
                                  ),
                                  _divider(),
                                  _SummaryRow(
                                    label: 'Price per Share',
                                    value: controller.stock.formattedPrice,
                                  ),
                                  _divider(),
                                  _SummaryRow(
                                    label: 'Order Type',
                                    value: controller.orderMode ==
                                            StockOrderMode.market
                                        ? 'Market Order'
                                        : 'Limit Order',
                                  ),
                                ],
                              ),
                            ),
                            // Total footer
                            Container(
                              padding: REdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: colorScheme.primaryContainer
                                    .withOpacity(0.12),
                                borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(16.r),
                                ),
                                border: Border(
                                  top: BorderSide(
                                      color: colorScheme.outline),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Estimated Total',
                                    style: textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    _fmt(controller.estimatedTotal),
                                    style: textTheme.titleMedium?.copyWith(
                                      color: colorScheme.primary,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // ── Wallet balance notice ────────────────────
                      if (_isBuy)
                        Container(
                          padding: REdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: colorScheme.secondaryContainer
                                .withOpacity(0.4),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: colorScheme.tertiary
                                  .withOpacity(0.15),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.account_balance_wallet_outlined,
                                size: 16.r,
                                color: colorScheme.tertiary,
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Text(
                                  'Wallet Balance: ${_fmt(controller.walletBalance)}',
                                  style: textTheme.bodySmall?.copyWith(
                                    color: colorScheme.tertiary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              if (controller.estimatedTotal >
                                  controller.walletBalance)
                                Text(
                                  'Insufficient',
                                  style: textTheme.labelSmall?.copyWith(
                                    color: colorScheme.error,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                            ],
                          ),
                        ),

                      SizedBox(height: 20.h),

                      // ── Terms checkbox ───────────────────────────
                      GestureDetector(
                        onTap: controller.onToggleTerms,
                        behavior: HitTestBehavior.opaque,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 22.r,
                              height: 22.r,
                              decoration: BoxDecoration(
                                color: controller.termsAccepted
                                    ? colorScheme.primary
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(6.r),
                                border: Border.all(
                                  color: controller.termsAccepted
                                      ? colorScheme.primary
                                      : colorScheme.outline,
                                  width: 1.5,
                                ),
                              ),
                              child: controller.termsAccepted
                                  ? Icon(
                                      Icons.check_rounded,
                                      size: 14.r,
                                      color: colorScheme.onPrimary,
                                    )
                                  : null,
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: textTheme.bodySmall?.copyWith(
                                    height: 1.5,
                                  ),
                                  children: [
                                    const TextSpan(
                                        text:
                                            'I understand stock investments carry risk and I agree to the '),
                                    TextSpan(
                                      text: 'Terms & Conditions',
                                      style: textTheme.bodySmall?.copyWith(
                                        color: colorScheme.primary,
                                        fontWeight: FontWeight.w600,
                                        decoration:
                                            TextDecoration.underline,
                                      ),
                                    ),
                                    const TextSpan(text: '.'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
              ),

              // ── Bottom CTA ───────────────────────────────────────
              Container(
                padding: REdgeInsets.fromLTRB(20, 12, 20, 32),
                decoration: BoxDecoration(
                  color: colorScheme.background,
                  border: Border(
                      top: BorderSide(color: colorScheme.outline)),
                ),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: controller.canProceed ? 1.0 : 0.45,
                  child: GestureDetector(
                    onTap: controller.canProceed
                        ? controller.onConfirm
                        : null,
                    child: Container(
                      width: double.infinity,
                      height: 56.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _isBuy
                            ? colorScheme.primary
                            : colorScheme.error,
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Text(
                        _isBuy
                            ? 'Confirm Purchase'
                            : 'Confirm Sale',
                        style: textTheme.labelLarge?.copyWith(
                          color: _isBuy
                              ? colorScheme.onPrimary
                              : colorScheme.onError,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // ── Loading overlay ──────────────────────────────────────────
        if (controller.isLoading)
          Container(
            color: Colors.black.withOpacity(0.55),
            child: Center(
              child: Container(
                width: 220.w,
                padding: REdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 40.r,
                      height: 40.r,
                      child: CircularProgressIndicator(
                        color: colorScheme.primary,
                        strokeWidth: 3,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Processing your order…',
                      textAlign: TextAlign.center,
                      style: textTheme.titleSmall?.copyWith(
                        color: colorScheme.onSurface,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Please do not close the app',
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _divider() => Padding(
        padding: REdgeInsets.symmetric(vertical: 10),
        child: const Divider(),
      );
}

// ── Summary row ────────────────────────────────────────────────────────────────
class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: textTheme.bodyMedium,
        ),
        Text(
          value,
          style: textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}