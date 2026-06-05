

import 'package:flutter/material.dart';

import 'models/transaction_data.dart';
import 'utils/enums.dart';

final kTransactions = [
  TransactionData(
    id: 't1',
    title: 'Wallet Funded',
    subtitle: 'Deposit · 10:42 AM',
    amount: 500000,
    isCredit: true,
    date: DateTime.now(),
    status: TransactionStatus.successful,
    type: TransactionFilter.fundings,
    icon: Icons.arrow_downward_rounded,
  ),
  TransactionData(
    id: 't2',
    title: 'PMPS — 180 Days',
    subtitle: 'Investment · 09:15 AM',
    amount: 1000000,
    isCredit: false,
    date: DateTime.now(),
    status: TransactionStatus.locked,
    type: TransactionFilter.investments,
    icon: Icons.trending_up_rounded,
  ),
  TransactionData(
    id: 't3',
    title: 'Interest Earned',
    subtitle: 'Yield · 11:59 PM',
    amount: 1920.55,
    isCredit: true,
    date: DateTime.now().subtract(const Duration(days: 1)),
    status: TransactionStatus.accrued,
    type: TransactionFilter.fundings,
    icon: Icons.currency_exchange_rounded,
  ),
  TransactionData(
    id: 't4',
    title: 'Withdrawal',
    subtitle: 'Bank Transfer · 04:30 PM',
    amount: 50000,
    isCredit: false,
    date: DateTime(2023, 10, 20),
    status: TransactionStatus.completed,
    type: TransactionFilter.withdrawals,
    icon: Icons.arrow_upward_rounded,
  ),
  TransactionData(
    id: 't5',
    title: 'PMPS — 90 Days',
    subtitle: 'Investment · 11:00 AM',
    amount: 500000,
    isCredit: false,
    date: DateTime(2023, 10, 20),
    status: TransactionStatus.completed,
    type: TransactionFilter.investments,
    icon: Icons.trending_up_rounded,
  ),
];