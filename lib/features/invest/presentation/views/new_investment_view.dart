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


    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: controller.onBack,
          child: Icon(Icons.arrow_back_rounded,
              size: 22.r, color: AppColors.textPrimary),
        ),
        title: Text(
          'New Investment',
          style: AppTextStyles.titleLarge.copyWith(
            color: AppColors.textPrimary,
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
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Container(
                    height: 3.h,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.15),
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
                  color: AppColors.textDisabled,
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
                      fontFamily: 'BWGradual',
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    'Select how long you\'d like to invest.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
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
                    children: kTenors.map((t) => _TenorChip(
                      tenor: t,
                      isSelected: controller.selectedTenor.days == t.days,
                      onTap: () => controller.onTenorSelected(t),
                    )).toList(),
                  ),

                  SizedBox(height: 10.h),

                  // ── Amount ───────────────────────────────────────
                  Text(
                    'Enter Amount',
                    style: AppTextStyles.headlineSmall.copyWith(
                      fontFamily: 'BWGradual',
                      color: AppColors.textPrimary,
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
                                  color: AppColors.textPrimary,
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14.r),
                                    borderSide: BorderSide(
                                      color: AppColors.primary.withOpacity(0.25),
                                      width: 1.5,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14.r),
                                    borderSide: BorderSide(
                                      color: AppColors.primary.withOpacity(0.25),
                                      width: 1.5,
                                    ),
                                  ),
                                  // contentPadding: EdgeInsets.zero,
                                  hintText: '0',
                                  hintStyle: AppTextStyles.displaySmall
                                      .copyWith(
                                    color: AppColors.textDisabled,
                                    fontSize: 28.sp,
                                  ),
                                ),
                              ),
                  // Container(
                  //   padding: REdgeInsets.symmetric(
                  //       horizontal: 16, vertical: 14),
                  //   decoration: BoxDecoration(
                  //     color: AppColors.surfaceVariant,
                  //     borderRadius: BorderRadius.circular(14.r),
                  //     border: Border.all(
                  //       color: AppColors.primary.withOpacity(0.25),
                  //       width: 1.5,
                  //     ),
                  //   ),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //         'ENTER AMOUNT',
                  //         style: AppTextStyles.labelSmall.copyWith(
                  //           color: AppColors.textDisabled,
                  //           letterSpacing: 0.8,
                  //           fontSize: 9.sp,
                  //         ),
                  //       ),
                  //       SizedBox(height: 6.h),
                  //       Row(
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         children: [
                  //           Text(
                  //             '₦',
                  //             style: AppTextStyles.displaySmall.copyWith(
                  //               color: AppColors.textPrimary,
                  //               fontWeight: FontWeight.w300,
                  //               fontSize: 28.sp,
                  //             ),
                  //           ),
                  //           SizedBox(width: 4.w),
                  //           Expanded(
                  //             child: TextField(
                  //               controller: controller.amountController,
                  //               onChanged: controller.onAmountChanged,
                  //               keyboardType: TextInputType.number,
                  //               inputFormatters: [
                  //                 FilteringTextInputFormatter.digitsOnly,
                  //               ],
                  //               style: AppTextStyles.displaySmall.copyWith(
                  //                 color: AppColors.textPrimary,
                  //                 fontSize: 28.sp,
                  //                 fontWeight: FontWeight.w700,
                  //               ),
                  //               decoration: InputDecoration(
                  //                 border: InputBorder.none,
                  //                 contentPadding: EdgeInsets.zero,
                  //                 hintText: '0',
                  //                 hintStyle: AppTextStyles.displaySmall
                  //                     .copyWith(
                  //                   color: AppColors.textDisabled,
                  //                   fontSize: 28.sp,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       SizedBox(height: 8.h),
                  //       Row(
                  //         mainAxisAlignment:
                  //             MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Row(
                  //             children: [
                  //               Icon(
                  //                 Icons.account_balance_wallet_outlined,
                  //                 size: 12.r,
                  //                 color: AppColors.textDisabled,
                  //               ),
                  //               SizedBox(width: 4.w),
                  //               Text(
                  //                 'Wallet Balance',
                  //                 style: AppTextStyles.bodySmall.copyWith(
                  //                   color: AppColors.textDisabled,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //           Text(
                  //             '₦${NumberFormat('#,##0.00').format(controller.walletBalance)}',
                  //             style: AppTextStyles.bodySmall.copyWith(
                  //               color: AppColors.textSecondary,
                  //               fontWeight: FontWeight.w500,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  SizedBox(height: 12.h),

                  // Quick amount chips
                  Row(
                    children: kQuickAmounts.map((amount) {
                      final isSelected =
                          controller.enteredAmount == amount;
                      return Expanded(
                        child: Padding(
                          padding: REdgeInsets.only(
                              right: amount != kQuickAmounts.last
                                  ? 8.w
                                  : 0),
                          child: GestureDetector(
                            onTap: () =>
                                controller.onQuickAmount(amount),
                            child: AnimatedContainer(
                              duration:
                                  const Duration(milliseconds: 200),
                              height: 34.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary.withOpacity(0.08)
                                    : AppColors.surfaceVariant,
                                borderRadius:
                                    BorderRadius.circular(8.r),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primary
                                      : Colors.transparent,
                                  width: 1.5,
                                ),
                              ),
                              child: Text(
                                _fmtShort(amount),
                                style:
                                    AppTextStyles.labelSmall.copyWith(
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.textSecondary,
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
                        Icon(Icons.warning_amber_rounded,
                            size: 13.r, color: Colors.red),
                        SizedBox(width: 4.w),
                        Text(
                          'Insufficient balance. ',
                          style: AppTextStyles.bodySmall
                              .copyWith(color: Colors.red),
                        ),
                        GestureDetector(
                          onTap: controller.onFundWallet,
                          child: Text(
                            'Fund Wallet →',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.primary,
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
              color: AppColors.background,
              border: Border(
                top: BorderSide(color: AppColors.divider),
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
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Proceed to Invest',
                        style: AppTextStyles.labelLarge.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Icon(Icons.arrow_forward_rounded,
                          size: 18.r, color: AppColors.white),
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