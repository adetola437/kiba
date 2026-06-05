import 'package:flutter/material.dart';

import '../utils/enums.dart';

class TransactionData {
  final String id;
  final String title;
  final String subtitle;
  final double amount;
  final bool isCredit;
  final DateTime date;
  final TransactionStatus status;
  final TransactionFilter type;
  final IconData icon;

  const TransactionData({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.isCredit,
    required this.date,
    required this.status,
    required this.type,
    required this.icon,
  });
}