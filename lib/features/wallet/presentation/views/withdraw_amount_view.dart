part of '../controllers/withdraw_amount_controller.dart';

class WithdrawAmountView extends StatelessWidget
    implements WithdrawAmountViewContract {
  const WithdrawAmountView({super.key, required this.controller});

  final WithdrawAmountControllerContract controller;

  String _fmt(double v) => '₦${NumberFormat('#,##0.00', 'en_US').format(v)}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar:  const CustomAppBar(title: 'Withdraw Funds'),
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
                    style: AppTextStyles.headlineMedium.copyWith(
                      fontFamily: 'BWGradual',
                      color: AppColors.textPrimary,
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // ── Available balance pill ───────────────────────
                  Container(
                    padding:
                        REdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Available Balance: ',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          _fmt(controller.availableBalance),
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.primary,
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
                        style: AppTextStyles.headlineMedium.copyWith(
                          fontFamily: 'EuclidCircularA',
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: TextFormField(
                          controller: controller.amountCtrl,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          style: TextStyle(
                            fontFamily: 'EuclidCircularA',
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                          decoration: InputDecoration(
                            hintText: '0.00',
                            hintStyle: TextStyle(
                              fontFamily: 'EuclidCircularA',
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w300,
                              color: AppColors.textDisabled,
                            ),
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(color: AppColors.border),
                            ),
                            errorStyle: TextStyle(
                              color: AppColors.error,
                              fontSize: 12.sp,
                            ),
                          ),
                          validator: (value) {
                            // Call your validation logic here
                            return controller.validateAmount(value);
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  // ── Quick select chips ───────────────────────────
                  Row(
                    children: [
                      _AmountQuickChip(
                        label: '25%',
                        onTap: () => controller.onQuickSelect(0.25),
                      ),
                      SizedBox(width: 10.w),
                      _AmountQuickChip(
                        label: '50%',
                        onTap: () => controller.onQuickSelect(0.50),
                      ),
                      SizedBox(width: 10.w),
                      _AmountQuickChip(
                        label: '75%',
                        onTap: () => controller.onQuickSelect(0.75),
                      ),
                      SizedBox(width: 10.w),
                      _AmountQuickChip(
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
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      children: [
                        _InfoRow(
                          label: 'Fee',
                          value: '₦0.00',
                          valueColor: AppColors.textPrimary,
                        ),
                        SizedBox(height: 10.h),
                        Divider(color: AppColors.divider, height: 1),
                        SizedBox(height: 10.h),
                        _InfoRow(
                          label: 'Expected Arrival',
                          value: 'Instant (2-5 mins)',
                          valueColor: AppColors.primary,
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
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.shield_outlined,
                          size: 32.r,
                          color: AppColors.primary.withOpacity(0.3),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'SECURITY FIRST',
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: AppColors.textSecondary,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'All withdrawals are secured with bank-grade encryption and 2FA protection.',
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.textSecondary,
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
              color: AppColors.background,
              border: Border(top: BorderSide(color: AppColors.divider)),
            ),
            child: ValueListenableBuilder<double?>(
              valueListenable: controller.parsedAmount,
              builder: (context, amount, _) {
                final enabled = amount != null && amount > 0;
                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: enabled ? 1.0 : 0.45,
                  child: GestureDetector(
                    onTap: enabled ? controller.onContinue : null,
                    child: Container(
                      width: double.infinity,
                      height: 56.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Text(
                        'Continue',
                        style: AppTextStyles.labelLarge.copyWith(
                          color: AppColors.white,
                          fontSize: 16.sp,
                        ),
                      ),
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
    required this.valueColor,
    this.valueBold = false,
  });

  final String label;
  final String value;
  final Color valueColor;
  final bool valueBold;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: AppTextStyles.bodySmall.copyWith(
            color: valueColor,
            fontWeight: valueBold ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
