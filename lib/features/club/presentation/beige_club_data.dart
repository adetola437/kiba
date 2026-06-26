// Beige Club — Contributory Investment Product
// Managed by Beige Partners Limited (SEC Regulated)
// Annual cycle: January 1 – December 31
// Target return: 19% p.a. (pro-rated from contribution date)

import 'package:flutter/material.dart';

// ── Constants ──────────────────────────────────────────────────────────────────

const double kBeigeClubRate = 19.0; // % p.a.
const double kBeigeClubMinContribution = 50000.0;
const String kBankName = 'Zenith Bank PLC';
const String kAccountName = 'Beige Multipurpose Cooperative Society';
const String kAccountNumber = '1310637562';

// ── Enums ──────────────────────────────────────────────────────────────────────

enum BeigeClubStatus { notJoined, active, matured, pendingPayment }

enum MaturityOption { rollOverBoth, rollOverCapitalWithdrawInterest, withdrawBoth }

enum PaymentProofStatus { notUploaded, uploading, uploaded, verified, rejected }

// ── Models ─────────────────────────────────────────────────────────────────────

class BeigeClubContribution {
  final String id;
  final double amount;
  final DateTime date;
  final int daysToYearEnd;
  final double projectedInterest; // pro-rated

  const BeigeClubContribution({
    required this.id,
    required this.amount,
    required this.date,
    required this.daysToYearEnd,
    required this.projectedInterest,
  });
}

class BeigeClubActiveState {
  final double totalContributed;
  final double accruedInterest;
  final double projectedYearEndValue;
  final double dailyAccrual;
  final List<BeigeClubContribution> contributions;
  final DateTime memberSince;
  final DateTime yearEnd; // always Dec 31

  const BeigeClubActiveState({
    required this.totalContributed,
    required this.accruedInterest,
    required this.projectedYearEndValue,
    required this.dailyAccrual,
    required this.contributions,
    required this.memberSince,
    required this.yearEnd,
  });

  int get daysToYearEnd =>
      yearEnd.difference(DateTime.now()).inDays.clamp(0, 365);

  double get progressPercent {
    final totalDays =
        yearEnd.difference(memberSince).inDays;
    final elapsed = DateTime.now().difference(memberSince).inDays;
    return (elapsed / totalDays).clamp(0.0, 1.0);
  }
}

// ── Pro-rata calculator ────────────────────────────────────────────────────────

double calculateProRataInterest(double amount, DateTime contributionDate) {
  final yearEnd = DateTime(contributionDate.year, 12, 31);
  final daysRemaining =
      yearEnd.difference(contributionDate).inDays;
  return amount * (kBeigeClubRate / 100) * (daysRemaining / 365);
}

// ── Mock active state ──────────────────────────────────────────────────────────

final kMockBeigeClubActive = BeigeClubActiveState(
  totalContributed: 250000,
  accruedInterest: 18234.25,
  projectedYearEndValue: 297500,
  dailyAccrual: 130.14,
  yearEnd: DateTime(DateTime.now().year, 12, 31),
  memberSince: DateTime(DateTime.now().year, 1, 15),
  contributions: [
    BeigeClubContribution(
      id: 'c3',
      amount: 100000,
      date: DateTime(DateTime.now().year, 5, 1),
      daysToYearEnd: 244,
      projectedInterest: 12731.51,
    ),
    BeigeClubContribution(
      id: 'c2',
      amount: 100000,
      date: DateTime(DateTime.now().year, 3, 1),
      daysToYearEnd: 305,
      projectedInterest: 15890.41,
    ),
    BeigeClubContribution(
      id: 'c1',
      amount: 50000,
      date: DateTime(DateTime.now().year, 1, 15),
      daysToYearEnd: 350,
      projectedInterest: 9109.59,
    ),
  ],
);

// ── Features list ──────────────────────────────────────────────────────────────

class BeigeClubFeature {
  final IconData icon;
  final String title;
  final String body;
  const BeigeClubFeature({
    required this.icon,
    required this.title,
    required this.body,
  });
}

const kBeigeClubFeatures = [
  BeigeClubFeature(
    icon: Icons.trending_up_rounded,
    title: '19% Target Return p.a.',
    body: 'Earn a targeted annual return of 19%, consistently outperforming market benchmarks.',
  ),
  BeigeClubFeature(
    icon: Icons.add_circle_outline_rounded,
    title: 'Contribute Anytime',
    body: 'Add funds at any time during the year. Each contribution is pro-rated to December 31.',
  ),
  BeigeClubFeature(
    icon: Icons.calendar_month_outlined,
    title: 'Annual Investment Cycle',
    body: 'The investment year runs January 1 to December 31. All contributions mature on December 31.',
  ),
  BeigeClubFeature(
    icon: Icons.swap_horiz_rounded,
    title: 'Flexible Exit Options',
    body: 'At year end, roll over both capital and interest, withdraw interest only, or withdraw everything.',
  ),
  BeigeClubFeature(
    icon: Icons.verified_user_outlined,
    title: 'SEC Regulated',
    body: 'Managed by Beige Partners Limited, a Securities and Exchange Commission regulated portfolio manager.',
  ),
  BeigeClubFeature(
    icon: Icons.shield_outlined,
    title: 'Capital Preservation',
    body: 'Your principal is protected through diversification and active risk management.',
  ),
];

// ── Maturity option details ────────────────────────────────────────────────────

class MaturityOptionData {
  final MaturityOption option;
  final IconData icon;
  final String title;
  final String description;
  final Color accentColor;

  const MaturityOptionData({
    required this.option,
    required this.icon,
    required this.title,
    required this.description,
    required this.accentColor,
  });
}