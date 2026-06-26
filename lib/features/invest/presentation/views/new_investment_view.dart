part of '../controllers/new_investment_controller.dart';

class NewInvestmentView extends StatelessWidget
    implements NewInvestmentViewContract {
  const NewInvestmentView({super.key, required this.controller});

  final NewInvestmentControllerContract controller;

  String _fmtShort(double v) {
    if (v >= 1000000) return '₦${(v / 1000000).toStringAsFixed(0)}M';
    if (v >= 1000) return '₦${(v / 1000).toStringAsFixed(0)}K';
    return '₦${v.toStringAsFixed(0)}';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: colorScheme.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: controller.onBack,
          child: Icon(
            Icons.arrow_back_rounded,
            size: 22.r,
            color: colorScheme.onBackground,
          ),
        ),
        title: Text(
          'New Investment',
          style: AppTextStyles.titleLarge.copyWith(
            color: colorScheme.onBackground,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Step indicator
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 3.h,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Container(
                    height: 3.h,
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 4.h),

          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: REdgeInsets.only(right: 20),
              child: Text(
                'Step 1 of 2',
                style: AppTextStyles.labelSmall.copyWith(
                  color: colorScheme.onBackground.withValues(alpha: 0.38),
                ),
              ),
            ),
          ),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: REdgeInsets.fromLTRB(20, 20, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Tenor ────────────────────────────────────────
                  Text(
                    'Choose a Tenor',
                    style: AppTextStyles.headlineSmall.copyWith(
                      color: colorScheme.onBackground,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    'Select how long you\'d like to invest.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Tenor grid
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 10.h,
                    crossAxisSpacing: 10.w,
                    childAspectRatio: 1.2,
                    children: kTenors
                        .map((t) => _TenorChip(
                              tenor: t,
                              isSelected:
                                  controller.selectedTenor.days == t.days,
                              onTap: () => controller.onTenorSelected(t),
                            ))
                        .toList(),
                  ),

                  SizedBox(height: 10.h),

                  // ── Amount ───────────────────────────────────────
                  Text(
                    'Enter Amount',
                    style: AppTextStyles.headlineSmall.copyWith(
                      color: colorScheme.onBackground,
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // Amount input
                  TextFormField(
                    controller: controller.amountController,
                    onChanged: controller.onAmountChanged,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    style: AppTextStyles.displaySmall.copyWith(
                      color: colorScheme.onSurface,
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.r),
                        borderSide: BorderSide(
                          color: colorScheme.primary.withValues(alpha: 0.25),
                          width: 1.5,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.r),
                        borderSide: BorderSide(
                          color: colorScheme.primary.withValues(alpha: 0.25),
                          width: 1.5,
                        ),
                      ),
                      hintText: '0',
                      hintStyle: AppTextStyles.displaySmall.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.38),
                        fontSize: 28.sp,
                      ),
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // Quick amount chips
                  Row(
                    children: kQuickAmounts.map((amount) {
                      final isSelected = controller.enteredAmount == amount;
                      return Expanded(
                        child: Padding(
                          padding: REdgeInsets.only(
                              right: amount != kQuickAmounts.last ? 8.w : 0),
                          child: GestureDetector(
                            onTap: () => controller.onQuickAmount(amount),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              height: 34.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? colorScheme.primary.withValues(alpha: 0.08)
                                    : colorScheme.surfaceVariant,
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  color: isSelected
                                      ? colorScheme.primary
                                      : Colors.transparent,
                                  width: 1.5,
                                ),
                              ),
                              child: Text(
                                _fmtShort(amount),
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: isSelected
                                      ? colorScheme.primary
                                      : colorScheme.onSurfaceVariant,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  // Error message if amount > balance
                  if (controller.enteredAmount > controller.walletBalance) ...[
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          size: 13.r,
                          color: colorScheme.error,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Insufficient balance. ',
                          style: AppTextStyles.bodySmall
                              .copyWith(color: colorScheme.error),
                        ),
                        GestureDetector(
                          onTap: controller.onFundWallet,
                          child: Text(
                            'Fund Wallet →',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],

                  SizedBox(height: 24.h),

                  // ── Projected Returns ────────────────────────────
                  _ProjectedReturnsCard(controller: controller),

                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),

          // ── Bottom CTA ────────────────────────────────────────────
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
              opacity: controller.canProceed ? 1.0 : 0.45,
              child: GestureDetector(
                onTap: controller.canProceed ? controller.onProceed : null,
                child: Container(
                  width: double.infinity,
                  height: 56.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Proceed to Invest',
                        style: AppTextStyles.labelLarge.copyWith(
                          color: colorScheme.onPrimary,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 18.r,
                        color: colorScheme.onPrimary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}