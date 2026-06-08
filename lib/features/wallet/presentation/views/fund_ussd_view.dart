part of '../controllers/fund_ussd_controller.dart';

class FundUssdView extends StatelessWidget implements FundUssdViewContract {
  const FundUssdView({super.key, required this.controller});

  final FundUssdControllerContract controller;

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
          'Fund via USSD',
          style: AppTextStyles.titleMedium.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: REdgeInsets.fromLTRB(20, 8, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select your bank',
                  style: AppTextStyles.headlineSmall.copyWith(
                    fontFamily: 'BWGradual',
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  'Select a bank to generate a USSD code for your wallet funding.',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 16.h),

                // ── Search bar ───────────────────────────────────────
                Container(
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: TextField(
                    controller: controller.searchCtrl,
                    style: AppTextStyles.bodyMedium,
                    decoration: InputDecoration(
                      hintText: 'Search banks...',
                      hintStyle: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textDisabled,
                      ),
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        size: 20.r,
                        color: AppColors.textDisabled,
                      ),
                      border: InputBorder.none,
                      contentPadding: REdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
              ],
            ),
          ),

          // ── Bank list ────────────────────────────────────────────
          Expanded(
            child: ValueListenableBuilder<String>(
              valueListenable: controller.searchQuery,
              builder: (context, _, __) {
                final banks = controller.filteredBanks;
                return banks.isEmpty
                    ? Center(
                        child: Text(
                          'No banks found',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textDisabled,
                          ),
                        ),
                      )
                    : ListView.separated(
                        padding: REdgeInsets.fromLTRB(20, 0, 20, 24),
                        itemCount: banks.length + 1, // +1 for pro tip
                        separatorBuilder: (_, __) => SizedBox(height: 10.h),
                        itemBuilder: (context, index) {
                          if (index == banks.length) {
                            return _UssdProTip();
                          }
                          return _UssdBankTile(
                            bank: banks[index],
                            onTap: () => controller.onSelectBank(banks[index]),
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _UssdProTip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.beigePink.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.beigePink),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.lightbulb_outline_rounded,
            size: 16.r,
            color: AppColors.primary,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PRO TIP',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.primary,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Dialing the code will automatically open your phone dialer with the pre-filled code.',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.primary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}