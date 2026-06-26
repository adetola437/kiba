part of '../controllers/fund_ussd_controller.dart';

class FundUssdView extends StatelessWidget implements FundUssdViewContract {
  const FundUssdView({super.key, required this.controller});

  final FundUssdControllerContract controller;

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
          'Fund via USSD',
          style: textTheme.titleMedium,
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
                  style: textTheme.headlineSmall,
                ),
                SizedBox(height: 6.h),
                Text(
                  'Select a bank to generate a USSD code for your wallet funding.',
                  style: textTheme.bodySmall,
                ),
                SizedBox(height: 16.h),

                // ── Search bar ───────────────────────────────────────
                Container(
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: TextField(
                    controller: controller.searchCtrl,
                    style: textTheme.bodyMedium,
                    decoration: InputDecoration(
                      hintText: 'Search banks...',
                      hintStyle: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        size: 20.r,
                        color: colorScheme.onSurfaceVariant,
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
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      )
                    : ListView.separated(
                        padding: REdgeInsets.fromLTRB(20, 0, 20, 24),
                        itemCount: banks.length + 1, // +1 for pro tip
                        separatorBuilder: (_, __) => SizedBox(height: 10.h),
                        itemBuilder: (context, index) {
                          if (index == banks.length) {
                            return const _UssdProTip();
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
  const _UssdProTip();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: REdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.secondary.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colorScheme.secondary),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.lightbulb_outline_rounded,
            size: 16.r,
            color: colorScheme.onSecondary,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PRO TIP',
                  style: textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSecondary,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Dialing the code will automatically open your phone dialer with the pre-filled code.',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSecondary,
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