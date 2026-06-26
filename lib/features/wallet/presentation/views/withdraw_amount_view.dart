part of '../controllers/withdraw_amount_controller.dart';

class WithdrawAmountView extends StatelessWidget
    implements WithdrawAmountViewContract {
  const WithdrawAmountView({super.key, required this.controller});

  final WithdrawAmountControllerContract controller;

  String _fmt(double v) => '₦${NumberFormat('#,##0.00', 'en_US').format(v)}';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Withdraw Funds'),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: REdgeInsets.fromLTRB(20, 24, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ── Headline ─────────────────────────────────────
                  Text(
                    'How much would you\nlike to withdraw?',
                    textAlign: TextAlign.center,
                    style: textTheme.headlineMedium?.copyWith(
                      fontFamily: 'BWGradual',
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // ── Available balance pill ───────────────────────
                  Container(
                    padding:
                        REdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: colorScheme.outline),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Available Balance: ',
                          style: textTheme.bodySmall,
                        ),
                        Text(
                          _fmt(controller.availableBalance),
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 28.h),

                  // ── Amount input box ─────────────────────────────
                  Row(
                    children: [
                      SizedBox(width: 20.w),
                      Text(
                        '₦',
                        style: textTheme.headlineMedium?.copyWith(
                          fontFamily: 'EuclidCircularA',
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: TextFormField(
                          controller: controller.amountCtrl,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          style: textTheme.headlineSmall?.copyWith(
                            fontFamily: 'EuclidCircularA',
                            fontWeight: FontWeight.w700,
                          ),
                          decoration: InputDecoration(
                            hintText: '0.00',
                            hintStyle: textTheme.headlineSmall?.copyWith(
                              fontFamily: 'EuclidCircularA',
                              fontWeight: FontWeight.w300,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide:
                                  BorderSide(color: colorScheme.outline),
                            ),
                            errorStyle: textTheme.bodySmall?.copyWith(
                              color: colorScheme.error,
                            ),
                          ),
                          validator: (value) => controller.validateAmount(value),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  // ── Quick select chips ───────────────────────────
                  Row(
                    children: [
                      AmountQuickChip(
                        label: '25%',
                        onTap: () => controller.onQuickSelect(0.25),
                      ),
                      SizedBox(width: 10.w),
                      AmountQuickChip(
                        label: '50%',
                        onTap: () => controller.onQuickSelect(0.50),
                      ),
                      SizedBox(width: 10.w),
                      AmountQuickChip(
                        label: '75%',
                        onTap: () => controller.onQuickSelect(0.75),
                      ),
                      SizedBox(width: 10.w),
                      AmountQuickChip(
                        label: '100%',
                        onTap: () => controller.onQuickSelect(1.0),
                      ),
                    ],
                  ),

                  SizedBox(height: 28.h),

                  // ── Fee info row ─────────────────────────────────
                  Container(
                    padding: REdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: colorScheme.outline),
                    ),
                    child: Column(
                      children: [
                        _InfoRow(
                          label: 'Fee',
                          value: '₦0.00',
                        ),
                        SizedBox(height: 10.h),
                        Divider(
                          color: colorScheme.outline.withOpacity(0.5),
                          height: 1,
                        ),
                        SizedBox(height: 10.h),
                        _InfoRow(
                          label: 'Expected Arrival',
                          value: 'Instant (2-5 mins)',
                          isPrimary: true,
                          valueBold: true,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // ── Security banner ──────────────────────────────
                  Container(
                    padding: REdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.shield_outlined,
                          size: 32.r,
                          color: colorScheme.primary.withOpacity(0.3),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'SECURITY FIRST',
                                style: textTheme.labelSmall,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'All withdrawals are secured with bank-grade encryption and 2FA protection.',
                                style: textTheme.bodySmall?.copyWith(
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Bottom CTA ───────────────────────────────────────────
          Container(
            padding: REdgeInsets.fromLTRB(20, 12, 20, 32),
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              border: Border(
                top: BorderSide(
                  color: colorScheme.outline.withOpacity(0.5),
                ),
              ),
            ),
            child: ValueListenableBuilder<double?>(
              valueListenable: controller.parsedAmount,
              builder: (context, amount, _) {
                final enabled = amount != null && amount > 0;
                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: enabled ? 1.0 : 0.45,
                  child: IgnorePointer(
                    ignoring: !enabled,
                    child: ElevatedButton(
                      onPressed: enabled ? controller.onContinue : null,
                      child: const Text('Continue'),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ── Info row helper ────────────────────────────────────────────────────────────
class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    this.isPrimary = false,
    this.valueBold = false,
  });

  final String label;
  final String value;
  final bool isPrimary;
  final bool valueBold;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: textTheme.bodySmall,
        ),
        Text(
          value,
          style: textTheme.bodySmall?.copyWith(
            color: isPrimary ? colorScheme.primary : null,
            fontWeight: valueBold ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}