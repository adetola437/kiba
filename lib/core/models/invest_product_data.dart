import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../utils/enums.dart';

class InvestProductData {
  final String id;
  final String name;
  final String subtitle;
  final String statOneValue;
  final String statOneLabel;
  final String statTwoValue;
  final String statTwoLabel;
  final String statThreeValue;
  final String statThreeLabel;
  final String ctaLabel;
  final InvestCategory category;
  final bool isMostPopular;
  final bool isLocked;
  final String? lockReason;
  final IconData icon;
  final Color iconBg;

  const InvestProductData({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.statOneValue,
    required this.statOneLabel,
    required this.statTwoValue,
    required this.statTwoLabel,
    required this.statThreeValue,
    required this.statThreeLabel,
    required this.ctaLabel,
    required this.category,
    required this.icon,
    required this.iconBg,
    this.isMostPopular = false,
    this.isLocked = false,
    this.lockReason,
  });
}

final kInvestProducts = [
 const InvestProductData(
    id: 'beige_club',
    name: 'Beige Club',
    subtitle: 'Monthly savings scheme',
    statOneValue: '16%',
    statOneLabel: 'p.a.',
    statTwoValue: '12 mo',
    statTwoLabel: 'Term',
    statThreeValue: '₦50k+',
    statThreeLabel: '/ month',
    ctaLabel: 'Join Club',
    category: InvestCategory.savings,
    icon: Icons.people_outline_rounded,
    iconBg: AppColors.beigePink,
  ),
const  InvestProductData(
    id: 'pmps',
    name: 'PMPS',
    subtitle: 'Fixed-term investment',
    statOneValue: '18.5%',
    statOneLabel: 'max p.a.',
    statTwoValue: '30–365',
    statTwoLabel: 'days',
    statThreeValue: '₦100k+',
    statThreeLabel: 'min',
    ctaLabel: 'Invest Now',
    category: InvestCategory.fixedIncome,
    icon: Icons.trending_up_rounded,
    iconBg: AppColors.limeGreen,
    isMostPopular: true,
  ),
 const InvestProductData(
    id: 'tbills',
    name: 'Treasury Bills',
    subtitle: 'Government securities',
    statOneValue: '18%',
    statOneLabel: 'p.a.',
    statTwoValue: '91–364',
    statTwoLabel: 'days',
    statThreeValue: '₦200k+',
    statThreeLabel: 'min',
    ctaLabel: 'Invest Now',
    category: InvestCategory.government,
    icon: Icons.account_balance_outlined,
    iconBg: AppColors.cloudyBlue,
    isLocked: true,
    lockReason: 'Requires Tier 2 KYC to access',
  ),
];