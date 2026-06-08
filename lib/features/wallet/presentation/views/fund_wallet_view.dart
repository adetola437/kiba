part of '../controllers/fund_wallet_controller.dart';

class FundWalletView extends StatelessWidget implements FundWalletViewContract {
  const FundWalletView({super.key, required this.controller});

  final FundWalletControllerContract controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
        appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Icon(Icons.arrow_back_rounded,
              size: 22.r, color: AppColors.textPrimary),
        ),
        title: Text('Fund Wallet',
            style: AppTextStyles.titleLarge
                .copyWith(color: AppColors.textPrimary)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.fromLTRB(20, 8, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Payment Method',
              style: AppTextStyles.headlineSmall.copyWith(
                fontFamily: 'BWGradual',
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'Choose your preferred way to top up your Beige\nAfrica wallet instantly.',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 24.h),

            // ── Payment Method Tiles ──────────────────────────────────
            _PaymentMethodTile(
              icon: Icons.credit_card_rounded,
              iconBg: AppColors.beigePink,
              iconColor: AppColors.primary,
              title: 'Debit/Credit Card',
              subtitle: 'Instant funding',
              onTap: controller.onSelectDebitCard,
            ),
            SizedBox(height: 12.h),
            _PaymentMethodTile(
              icon: Icons.account_balance_outlined,
              iconBg: AppColors.beigePink,
              iconColor: AppColors.primary,
              title: 'Bank Transfer',
              subtitle: 'NIP transfer, ~2 mins',
              onTap: controller.onSelectBankTransfer,
            ),
            SizedBox(height: 12.h),
            _PaymentMethodTile(
              icon: Icons.grid_view_rounded,
              iconBg: AppColors.beigePink,
              iconColor: AppColors.primary,
              title: 'USSD',
              subtitle: 'Fund without internet, ~1 min',
              onTap: controller.onSelectUssd,
            ),
            SizedBox(height: 12.h),
            _PaymentMethodTile(
              icon: Icons.qr_code_rounded,
              iconBg: AppColors.beigePink,
              iconColor: AppColors.primary,
              title: 'Virtual Account',
              subtitle: 'Dedicated Providus Bank account, Same day',
              badge: 'RECOMMENDED',
              onTap: controller.onSelectVirtualAccount,
            ),

            SizedBox(height: 32.h),

            // ── Trust badge ──────────────────────────────────────────
            Center(
              child: Container(
                padding: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.charcoalGrey,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.lock_rounded,
                      size: 12.r,
                      color: AppColors.white,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'SECURE & ENCRYPTED',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.white,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16.h),
            Text(
              'Beige Africa uses industry-standard 256-bit encryption to protect your financial data and transactions.',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textDisabled,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}