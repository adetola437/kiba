

import 'package:flutter/material.dart';

import '../models/club_feature.dart';
import '../models/investment.dart';
import '../models/transaction_data.dart';
import 'enums.dart';

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

// Shared data used across Beige Club screens

const int kClubTotalMembers = 12;
const double kClubRate = 16.0; // % p.a.
const double kClubMinContribution = 50000;

const List<double> kContributionOptions = [50000, 100000, 150000, 200000];

const List<String> kMonths = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];

const List<ClubFeature> kClubFeatures = [
  ClubFeature(
    icon: Icons.verified_user_outlined,
    label: 'SEC-regulated investment scheme',
  ),
  ClubFeature(
    icon: Icons.trending_up_rounded,
    label: '16% per annum fixed return',
  ),
  ClubFeature(
    icon: Icons.calendar_month_outlined,
    label: '12-month savings cycle',
  ),
  ClubFeature(
    icon: Icons.account_balance_wallet_outlined,
    label: 'Minimum ₦50,000 per month',
  ),
  ClubFeature(
    icon: Icons.notifications_outlined,
    label: 'Monthly contribution reminders',
  ),
  ClubFeature(
    icon: Icons.autorenew_rounded,
    label: 'Roll over option at maturity',
  ),
];


// Mock group slots: 8 taken, 4 open
const int kSlotsFilled = 8;

const kPmpsProduct = InvestmentProduct(
  id: 'pmps_180',
  name: 'PMPS — 180 Days',
  category: 'FIXED INCOME',
  tagline: 'Secure 17.0% p.a. with PMPS Fixed Income',
  description:
      'Maximize your wealth with institutional-grade returns and absolute transparency.',
  annualYield: 17.0,
  tenorDays: 180,
  minimumAmount: 1000000,
  features: [
    ProductFeature(
      icon: Icons.verified_user_outlined,
      title: 'Regulated Safety',
      body:
          'Your principal is secured through institutional-grade compliance and asset backing.',
    ),
    ProductFeature(
      icon: Icons.calendar_today_outlined,
      title: 'Daily Accrual',
      body:
          'Watch your wealth grow in real-time. Interest is calculated and accrued daily.',
    ),
    ProductFeature(
      icon: Icons.swap_horiz_rounded,
      title: 'Flexible Liquidation',
      body:
          'Withdraw your investment after 90 days with partial interest retention.',
    ),
  ],
);

final kActiveInvestment = ActiveInvestmentDetail(
  id: 'inv_001',
  principal: 1000000,
  currentValue: 1009650,
  accruedInterest: 9650,
  annualRate: 17.0,
  tenorDays: 180,
  startDate: DateTime(2026, 1, 1),
  maturityDate: DateTime(2026, 9, 25),
  progressPercent: 0.31,
  isMatured: false,
  recentTransactions: [
    InvestmentTx(
      title: 'Interest Earned',
      subtitle: 'Yesterday',
      amount: 1920,
      isCredit: true,
      icon: Icons.trending_up_rounded,
    ),
    InvestmentTx(
      title: 'Interest Earned',
      subtitle: 'Oct 20, 2026',
      amount: 1850,
      isCredit: true,
      icon: Icons.trending_up_rounded,
    ),
    InvestmentTx(
      title: 'Investment Created',
      subtitle: 'Jan 1, 2026',
      amount: 1000000,
      isCredit: false,
      icon: Icons.add_chart_rounded,
    ),
  ],
);
