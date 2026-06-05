import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/consts.dart';
import '../../../../core/models/transaction_data.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/contract.dart';
import '../../../../core/utils/enums.dart';

part '../contracts/transactions_contract.dart';
part '../views/transactions_view.dart';
part '../widgets/transaction_item.dart';

class TransactionsScreen extends StatefulWidget {
  static const String route = 'history';
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen>
    implements TransactionsControllerContract {
  late final TransactionsViewContract view;
  late final TextEditingController _searchController;

  @override
  TransactionFilter activeFilter = TransactionFilter.all;

  @override
  String searchQuery = '';

  @override
  bool isSearching = false;

  @override
  Map<String, List<TransactionData>> get groupedTransactions {
    // Filter by type
    var filtered = activeFilter == TransactionFilter.all
        ? List<TransactionData>.from(kTransactions)
        : kTransactions
            .where((t) => t.type == activeFilter)
            .toList();

    // Filter by search
    if (searchQuery.isNotEmpty) {
      filtered = filtered
          .where((t) =>
              t.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
              t.subtitle.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }

    // Group by date label
    final Map<String, List<TransactionData>> grouped = {};
    final now = DateTime.now();

    for (final tx in filtered) {
      final String label;
      final diff = now.difference(tx.date).inDays;

      if (diff == 0) {
        label = 'TODAY';
      } else if (diff == 1) {
        label = 'YESTERDAY';
      } else {
        label = DateFormat('MMM d, y').format(tx.date).toUpperCase();
      }

      grouped.putIfAbsent(label, () => []).add(tx);
    }

    return grouped;
  }

  @override
  void initState() {
    super.initState();
    view = TransactionsView(controller: this);
    _searchController = TextEditingController();
  }

  @override
  void onFilterChanged(TransactionFilter filter) =>
      setState(() => activeFilter = filter);

  @override
  void onSearchToggle() {
    setState(() {
      isSearching = !isSearching;
      if (!isSearching) {
        searchQuery = '';
        _searchController.clear();
      }
    });
  }

  @override
  void onSearchChanged(String query) =>
      setState(() => searchQuery = query);

  @override
  void onTransactionTap(TransactionData tx) =>
      context.pushNamed('transaction_detail', extra: tx.id);

  @override
  void onBack() => context.pop();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => view.build(context);
}