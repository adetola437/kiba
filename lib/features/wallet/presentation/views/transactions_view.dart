part of '../controllers/transactions_controller.dart';

class TransactionsView extends StatelessWidget
    implements TransactionsViewContract {
  const TransactionsView({super.key, required this.controller});

  final TransactionsControllerContract controller;

  static const _filterLabels = {
    TransactionFilter.all:         'All',
    TransactionFilter.fundings:    'Fundings',
    TransactionFilter.investments: 'Investments',
    TransactionFilter.withdrawals: 'Withdrawals',
  };

  @override
  Widget build(BuildContext context) {
    final s = context
        .findAncestorStateOfType<_TransactionsScreenState>()!;
    final grouped = controller.groupedTransactions;

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
        title: controller.isSearching
            ? TextField(
                controller: s._searchController,
                onChanged: controller.onSearchChanged,
                autofocus: true,
                style: AppTextStyles.bodyMedium
                    .copyWith(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Search transactions...',
                  hintStyle: AppTextStyles.bodyMedium
                      .copyWith(color: AppColors.textDisabled),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              )
            : Text(
                'Transactions',
                style: AppTextStyles.titleLarge
                    .copyWith(color: AppColors.textPrimary),
              ),
        centerTitle: !controller.isSearching,
        actions: [
          GestureDetector(
            onTap: controller.onSearchToggle,
            child: Padding(
              padding: REdgeInsets.only(right: 16),
              child: Icon(
                controller.isSearching ? Icons.close_rounded : Icons.search_rounded,
                size: 22.r,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          // ── Filter chips ────────────────────────────────────────────
          if (!controller.isSearching)
            Padding(
              padding: REdgeInsets.fromLTRB(20, 8, 20, 0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: TransactionFilter.values.map((f) {
                    final isActive = f == controller.activeFilter;
                    return Padding(
                      padding: REdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () => controller.onFilterChanged(f),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 220),
                          padding: REdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: isActive
                                ? AppColors.primary
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: isActive
                                  ? AppColors.primary
                                  : AppColors.buttonBorder,
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            _filterLabels[f]!,
                            style: AppTextStyles.labelMedium.copyWith(
                              color: isActive
                                  ? AppColors.white
                                  : AppColors.textSecondary,
                              fontWeight: isActive
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

          SizedBox(height: 16.h),

          // ── Transaction list ────────────────────────────────────────
          Expanded(
            child: grouped.isEmpty
                ? _EmptyTransactions(
                    isSearching: controller.isSearching,
                    query: controller.searchQuery,
                    filter: controller.activeFilter,
                  )
                : ListView(
                    padding: REdgeInsets.fromLTRB(20, 0, 20, 40),
                    children: grouped.entries.map((entry) {
                      final label = entry.key;
                      final txList = entry.value;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Date group label
                          Padding(
                            padding: REdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              label,
                              style: AppTextStyles.labelSmall.copyWith(
                                color: AppColors.textDisabled,
                                letterSpacing: 1.1,
                                fontSize: 10.sp,
                              ),
                            ),
                          ),

                          // Transactions card
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: Column(
                                children: txList
                                    .asMap()
                                    .entries
                                    .map((e) => _TransactionItem(
                                          data: e.value,
                                          isLast: e.key == txList.length - 1,
                                          onTap: () => controller
                                              .onTransactionTap(e.value),
                                        ))
                                    .toList(),
                              ),
                            ),
                          ),

                          SizedBox(height: 8.h),
                        ],
                      );
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }
}

// ── Empty state ────────────────────────────────────────────────────────────────
class _EmptyTransactions extends StatelessWidget {
  const _EmptyTransactions({
    required this.isSearching,
    required this.query,
    required this.filter,
  });

  final bool isSearching;
  final String query;
  final TransactionFilter filter;

  @override
  Widget build(BuildContext context) {
    final message = isSearching
        ? 'No results for "$query"'
        : 'No ${filter == TransactionFilter.all ? '' : filter.name} transactions yet.';

    return Center(
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSearching
                  ? Icons.search_off_rounded
                  : Icons.receipt_long_outlined,
              size: 48.r,
              color: AppColors.primary.withOpacity(0.2),
            ),
            SizedBox(height: 12.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}