part of '../controllers/topup_investment_controller.dart';

class TopUpReviewScreen extends StatefulWidget {
  static const String route = 'topup_review';

  final String productName;
  final double currentPrincipal;
  final double currentValue;
  final double topUpAmount;
  final double annualRate;
  final int daysRemaining;
  final DateTime maturityDate;
  final double revisedPrincipal;
  final double additionalInterest;
  final double revisedTotalAtMaturity;

  const TopUpReviewScreen({
    super.key,
    required this.productName,
    required this.currentPrincipal,
    required this.currentValue,
    required this.topUpAmount,
    required this.annualRate,
    required this.daysRemaining,
    required this.maturityDate,
    required this.revisedPrincipal,
    required this.additionalInterest,
    required this.revisedTotalAtMaturity,
  });

  @override
  State<TopUpReviewScreen> createState() => _TopUpReviewScreenState();
}

class _TopUpReviewScreenState extends State<TopUpReviewScreen> {
  bool _termsAccepted = false;
  bool _isLoading = false;

  String _fmt(double v) =>
      '₦${NumberFormat('#,##0.00', 'en_US').format(v)}';

  Future<void> _onConfirm() async {
    if (!_termsAccepted || _isLoading) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 2200));
    if (!mounted) return;
    setState(() => _isLoading = false);
    context.goNamed(
      TopUpSuccessScreen.route,
      extra: {
        'productName': widget.productName,
        'topUpAmount': widget.topUpAmount,
        'revisedPrincipal': widget.revisedPrincipal,
        'revisedTotalAtMaturity': widget.revisedTotalAtMaturity,
        'maturityDate': widget.maturityDate,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final dateFormat = DateFormat('MMM d, y');

    return Stack(
      children: [
        Scaffold(
          backgroundColor: colorScheme.background,
          appBar: AppBar(
            backgroundColor: colorScheme.background,
            elevation: 0,
            scrolledUnderElevation: 0,
            leading: GestureDetector(
              onTap: () => context.pop(),
              child: Icon(
                Icons.arrow_back_rounded,
                size: 22.r,
                color: colorScheme.onBackground,
              ),
            ),
            title: Text(
              'Review Top Up',
              style: AppTextStyles.titleLarge.copyWith(
                color: colorScheme.onBackground,
              ),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: REdgeInsets.fromLTRB(20, 20, 20, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Confirm Top Up',
                        style: AppTextStyles.headlineSmall.copyWith(
                          color: colorScheme.onBackground,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Review the changes to your investment before confirming.',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          height: 1.5,
                        ),
                      ),

                      SizedBox(height: 24.h),

                      // ── Summary card ────────────────────────────
                      Container(
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(color: colorScheme.outline),
                        ),
                        child: Column(
                          children: [
                            // Header
                            Container(
                              padding: REdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: colorScheme.primary,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16.r),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40.r,
                                    height: 40.r,
                                    decoration: BoxDecoration(
                                      color: colorScheme.onPrimary
                                          .withValues(alpha: 0.12),
                                      borderRadius:
                                          BorderRadius.circular(10.r),
                                    ),
                                    child: Icon(
                                      Icons.trending_up_rounded,
                                      size: 18.r,
                                      color: colorScheme.primaryContainer,
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.productName,
                                          style: AppTextStyles.titleMedium
                                              .copyWith(
                                            color: colorScheme.onPrimary,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          '${widget.annualRate}% p.a. · ${widget.daysRemaining} days remaining',
                                          style: AppTextStyles.bodySmall
                                              .copyWith(
                                            color: colorScheme.onPrimary
                                                .withValues(alpha: 0.65),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Rows
                            Padding(
                              padding: REdgeInsets.all(16),
                              child: Column(
                                children: [
                                  _ReviewLine(
                                    label: 'Current Principal',
                                    value: _fmt(widget.currentPrincipal),
                                  ),
                                  _divider(colorScheme),
                                  _ReviewLine(
                                    label: 'Top Up Amount',
                                    value: '+ ${_fmt(widget.topUpAmount)}',
                                    valueColor: colorScheme.primary,
                                    isBold: true,
                                  ),
                                  _divider(colorScheme),
                                  _ReviewLine(
                                    label: 'New Principal',
                                    value: _fmt(widget.revisedPrincipal),
                                    isBold: true,
                                  ),
                                  _divider(colorScheme),
                                  _ReviewLine(
                                    label:
                                        'Additional Interest (${widget.daysRemaining}d)',
                                    value:
                                        '+${_fmt(widget.additionalInterest)}',
                                    valueColor: colorScheme.primary,
                                  ),
                                  _divider(colorScheme),
                                  _ReviewLine(
                                    label: 'Maturity Date',
                                    value: dateFormat
                                        .format(widget.maturityDate),
                                    icon: Icons.calendar_today_outlined,
                                  ),
                                ],
                              ),
                            ),

                            // Footer
                            Container(
                              padding: REdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: colorScheme.primaryContainer
                                    .withValues(alpha: 0.1),
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
                                    'Revised Total at Maturity',
                                    style: AppTextStyles.titleSmall
                                        .copyWith(
                                      color: colorScheme.onSurface,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    _fmt(widget.revisedTotalAtMaturity),
                                    style: AppTextStyles.titleMedium
                                        .copyWith(
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

                      SizedBox(height: 20.h),

                      // ── Wallet deduction notice ──────────────────
                      Container(
                        padding: REdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: colorScheme.secondaryContainer
                              .withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: colorScheme.tertiary
                                .withValues(alpha: 0.15),
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
                              child: RichText(
                                text: TextSpan(
                                  style: AppTextStyles.bodySmall
                                      .copyWith(
                                    color: colorScheme.tertiary,
                                    height: 1.5,
                                  ),
                                  children: [
                                    const TextSpan(
                                        text: 'By confirming, '),
                                    TextSpan(
                                      text: _fmt(widget.topUpAmount),
                                      style: AppTextStyles.bodySmall
                                          .copyWith(
                                        color: colorScheme.tertiary,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const TextSpan(
                                        text:
                                            ' will be deducted from your wallet and added to this investment.'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // ── Terms checkbox ───────────────────────────
                      GestureDetector(
                        onTap: () => setState(
                            () => _termsAccepted = !_termsAccepted),
                        behavior: HitTestBehavior.opaque,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 22.r,
                              height: 22.r,
                              decoration: BoxDecoration(
                                color: _termsAccepted
                                    ? colorScheme.primary
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(6.r),
                                border: Border.all(
                                  color: _termsAccepted
                                      ? colorScheme.primary
                                      : colorScheme.outline,
                                  width: 1.5,
                                ),
                              ),
                              child: _termsAccepted
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
                                  style: AppTextStyles.bodySmall
                                      .copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                    height: 1.5,
                                  ),
                                  children: [
                                    const TextSpan(
                                        text:
                                            'I understand the top up amount will be locked until the '),
                                    TextSpan(
                                      text: 'original maturity date',
                                      style: AppTextStyles.bodySmall
                                          .copyWith(
                                        color: colorScheme.onSurface,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const TextSpan(
                                        text: ' and agree to the '),
                                    TextSpan(
                                      text: 'Terms & Conditions',
                                      style: AppTextStyles.bodySmall
                                          .copyWith(
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

              // ── CTA ────────────────────────────────────────────
              Container(
                padding: REdgeInsets.fromLTRB(20, 12, 20, 32),
                decoration: BoxDecoration(
                  color: colorScheme.background,
                  border: Border(
                    top: BorderSide(color: colorScheme.outline),
                  ),
                ),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _termsAccepted ? 1.0 : 0.45,
                  child: GestureDetector(
                    onTap: _termsAccepted ? _onConfirm : null,
                    child: Container(
                      width: double.infinity,
                      height: 56.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Text(
                        'Confirm Top Up',
                        style: AppTextStyles.labelLarge.copyWith(
                          color: colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Loading overlay
        if (_isLoading)
          Container(
            color: Colors.black.withValues(alpha: 0.55),
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
                      'Processing top up...',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.titleSmall.copyWith(
                        color: colorScheme.onSurface,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Please do not close the app',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.38),
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

  Widget _divider(ColorScheme colorScheme) => Padding(
        padding: REdgeInsets.symmetric(vertical: 10),
        child: Divider(color: colorScheme.outline, height: 1),
      );
}

class _ReviewLine extends StatelessWidget {
  const _ReviewLine({
    required this.label,
    required this.value,
    this.valueColor,
    this.isBold = false,
    this.icon,
  });

  final String label;
  final String value;
  final Color? valueColor;
  final bool isBold;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        Row(
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 12.r,
                color: colorScheme.onSurface.withValues(alpha: 0.38),
              ),
              SizedBox(width: 4.w),
            ],
            Text(
              value,
              style: AppTextStyles.bodyMedium.copyWith(
                color: valueColor ?? colorScheme.onSurface,
                fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}