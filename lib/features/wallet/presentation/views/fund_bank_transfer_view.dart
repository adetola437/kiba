part of '../controllers/fund_bank_transfer_controller.dart';

class FundBankTransferView extends StatelessWidget
    implements FundBankTransferViewContract {
  const FundBankTransferView({super.key, required this.controller});

  final FundBankTransferControllerContract controller;

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
          'Fund Wallet',
          style: AppTextStyles.titleMedium.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.fromLTRB(20, 8, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bank Transfer',
              style: AppTextStyles.headlineSmall.copyWith(
                fontFamily: 'BWGradual',
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'Transfer money to your dedicated virtual account to fund your Beige wallet.',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),

            SizedBox(height: 24.h),

            // ── Virtual Account Display Card ─────────────────────────
            VirtualAccountDisplayCard(
              onCopy: controller.onCopyAccountNumber,
            ),

            SizedBox(height: 16.h),

            // ── Info Banner ──────────────────────────────────────────
            Container(
              padding: REdgeInsets.all(16),
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
                      'Funds typically reflect within 2 minutes. Please ensure you transfer the exact amount you wish to see in your wallet.',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.moodyBlue,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // ── Encryption illustration ──────────────────────────────
            Container(
              width: double.infinity,
              height: 140.h,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shield_outlined,
                    size: 40.r,
                    color: AppColors.primary,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Secure End-to-End Encryption',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}