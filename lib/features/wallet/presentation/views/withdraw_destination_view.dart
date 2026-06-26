part of '../controllers/withdraw_destination_controller.dart';

class WithdrawDestinationView extends StatelessWidget
    implements WithdrawDestinationViewContract {
  const WithdrawDestinationView({super.key, required this.controller});

  final WithdrawDestinationControllerContract controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Container(
            margin: REdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: colorScheme.outline),
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 16.r,
              color: colorScheme.onSurface,
            ),
          ),
        ),
        title: Text(
          'Withdraw Funds',
          style: textTheme.titleMedium,
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
                    style: textTheme.headlineMedium?.copyWith(
                      fontFamily: 'BWGradual',
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    'Select a verified bank account for your withdrawal.',
                    style: textTheme.bodySmall,
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
                          color: colorScheme.surface,
                          borderRadius: BorderRadius.circular(14.r),
                          border: Border.all(
                            color: colorScheme.outline,
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
                                  color: colorScheme.primary,
                                  width: 1.5,
                                ),
                              ),
                              child: Icon(
                                Icons.add_rounded,
                                size: 14.r,
                                color: colorScheme.primary,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              'Add New Bank Account',
                              style: textTheme.labelLarge?.copyWith(
                                color: colorScheme.primary,
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
                            style: textTheme.bodySmall?.copyWith(
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
                      color: colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.lock_rounded,
                          size: 32.r,
                          color: colorScheme.primary.withOpacity(0.4),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Bank-grade security on every transfer',
                          style: textTheme.labelSmall,
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
            child: ValueListenableBuilder<String?>(
              valueListenable: controller.selectedAccountId,
              builder: (context, selectedId, _) {
                final enabled =
                    selectedId != null && controller.accounts.isNotEmpty;
                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: enabled ? 1.0 : 0.45,
                  child: IgnorePointer(
                    ignoring: !enabled,
                    child: ElevatedButton.icon(
                      onPressed:
                          enabled ? controller.onReviewWithdrawal : null,
                      icon: const Icon(Icons.arrow_forward_rounded),
                      label: const Text('Review Withdrawal'),
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
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: REdgeInsets.all(32),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Column(
        children: [
          Container(
            width: 60.r,
            height: 60.r,
            decoration: const BoxDecoration(
              color: AppColors.beigePink,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.account_balance_outlined,
              size: 28.r,
              color: colorScheme.primary,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'No bank accounts linked',
            style: textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'Add a bank account to start\nmaking withdrawals.',
            textAlign: TextAlign.center,
            style: textTheme.bodySmall?.copyWith(
              height: 1.5,
            ),
          ),
          SizedBox(height: 20.h),
          ElevatedButton(
            onPressed: onAdd,
            child: const Text('+ Add Bank Account'),
          ),
        ],
      ),
    );
  }
}