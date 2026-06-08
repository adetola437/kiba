part of '../controllers/withdraw_destination_controller.dart';

class WithdrawDestinationView extends StatelessWidget
    implements WithdrawDestinationViewContract {
  const WithdrawDestinationView({super.key, required this.controller});

  final WithdrawDestinationControllerContract controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Container(
            margin: REdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.border),
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 16.r,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        title: Text(
          'Withdraw Funds',
          style: AppTextStyles.titleMedium.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: REdgeInsets.fromLTRB(20, 24, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Where should we send\nyour funds?',
                    style: AppTextStyles.headlineMedium.copyWith(
                      fontFamily: 'BWGradual',
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    'Select a verified bank account for your withdrawal.',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // ── Bank accounts list ─────────────────────────────
                  if (controller.accounts.isEmpty)
                    _EmptyAccountsState(
                      onAdd: controller.onAddNewAccount,
                    )
                  else ...[
                    ValueListenableBuilder<String?>(
                      valueListenable: controller.selectedAccountId,
                      builder: (context, selectedId, _) {
                        return Column(
                          children: [
                            ...controller.accounts.map(
                              (acc) => Padding(
                                padding: REdgeInsets.only(bottom: 12),
                                child: _BankAccountTile(
                                  account: acc,
                                  isSelected: acc.id == selectedId,
                                  onTap: () =>
                                      controller.onSelectAccount(acc.id),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    // ── Add new bank account ─────────────────────────
                    GestureDetector(
                      onTap: controller.onAddNewAccount,
                      child: Container(
                        width: double.infinity,
                        padding: REdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(14.r),
                          border: Border.all(
                            color: AppColors.border,
                            style: BorderStyle.solid,
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 24.r,
                              height: 24.r,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.primary,
                                  width: 1.5,
                                ),
                              ),
                              child: Icon(
                                Icons.add_rounded,
                                size: 14.r,
                                color: AppColors.primary,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              'Add New Bank Account',
                              style: AppTextStyles.labelLarge.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],

                  SizedBox(height: 20.h),

                  // ── Info banner ────────────────────────────────────
                  Container(
                    padding: REdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.cloudyBlue,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          size: 16.r,
                          color: AppColors.moodyBlue,
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            'Withdrawals typically arrive within 2-5 minutes. Large sums may require additional manual verification.',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.moodyBlue,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // ── Encryption visual ──────────────────────────────
                  Container(
                    width: double.infinity,
                    height: 120.h,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.lock_rounded,
                          size: 32.r,
                          color: AppColors.primary.withOpacity(0.4),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Bank-grade security on every transfer',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.textSecondary,
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
            child: ValueListenableBuilder<String?>(
              valueListenable: controller.selectedAccountId,
              builder: (context, selectedId, _) {
                final enabled =
                    selectedId != null && controller.accounts.isNotEmpty;
                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: enabled ? 1.0 : 0.45,
                  child: GestureDetector(
                    onTap: enabled ? controller.onReviewWithdrawal : null,
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
                            'Review Withdrawal',
                            style: AppTextStyles.labelLarge.copyWith(
                              color: AppColors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Icon(
                            Icons.arrow_forward_rounded,
                            size: 18.r,
                            color: AppColors.white,
                          ),
                        ],
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

// ── Empty state ────────────────────────────────────────────────────────────────
class _EmptyAccountsState extends StatelessWidget {
  const _EmptyAccountsState({required this.onAdd});
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: REdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Container(
            width: 60.r,
            height: 60.r,
            decoration: BoxDecoration(
              color: AppColors.beigePink,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.account_balance_outlined,
              size: 28.r,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'No bank accounts linked',
            style: AppTextStyles.titleSmall.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'Add a bank account to start\nmaking withdrawals.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          SizedBox(height: 20.h),
          GestureDetector(
            onTap: onAdd,
            child: Container(
              padding: REdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                '+ Add Bank Account',
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
