import 'package:flutter/material.dart';

class InvestmentProduct {
  final String id;
  final String name;
  final String category;
  final String tagline;
  final String description;
  final double annualYield;
  final int tenorDays;
  final double minimumAmount;
  final List<ProductFeature> features;

  const InvestmentProduct({
    required this.id,
    required this.name,
    required this.category,
    required this.tagline,
    required this.description,
    required this.annualYield,
    required this.tenorDays,
    required this.minimumAmount,
    required this.features,
  });
}

class ProductFeature {
  final IconData icon;
  final String title;
  final String body;
  const ProductFeature({
    required this.icon,
    required this.title,
    required this.body,
  });
}

class ActiveInvestmentDetail {
  final String id;
  final double principal;
  final double currentValue;
  final double accruedInterest;
  final double annualRate;
  final int tenorDays;
  final DateTime startDate;
  final DateTime maturityDate;
  final double progressPercent;
  final bool isMatured;
  final List<InvestmentTx> recentTransactions;

  const ActiveInvestmentDetail({
    required this.id,
    required this.principal,
    required this.currentValue,
    required this.accruedInterest,
    required this.annualRate,
    required this.tenorDays,
    required this.startDate,
    required this.maturityDate,
    required this.progressPercent,
    required this.isMatured,
    required this.recentTransactions,
  });

  int get daysRemaining =>
      maturityDate.difference(DateTime.now()).inDays.clamp(0, tenorDays);
}

class InvestmentTx {
  final String title;
  final String subtitle;
  final double amount;
  final bool isCredit;
  final IconData icon;

  const InvestmentTx({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.isCredit,
    required this.icon,
  });
}