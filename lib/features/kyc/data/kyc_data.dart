// KYC shared data models, enums and mock state

import 'package:flutter/material.dart';

// ── Enums ──────────────────────────────────────────────────────────────────────

enum KycTier { tier1, tier2, tier3 }

enum KycStatus { notStarted, pending, approved, rejected }

enum AccountType { individual, corporate }

// ── Tier benefit model ─────────────────────────────────────────────────────────

class KycTierInfo {
  final KycTier tier;
  final String label;
  final String subtitle;
  final KycStatus status;
  final List<String> benefits;
  final String investmentLimit;
  final IconData icon;

  const KycTierInfo({
    required this.tier,
    required this.label,
    required this.subtitle,
    required this.status,
    required this.benefits,
    required this.investmentLimit,
    required this.icon,
  });
}

// ── Document upload state ──────────────────────────────────────────────────────

enum DocUploadStatus { empty, uploading, uploaded, error }

class DocUploadState {
  final String id;
  final String label;
  final String hint;
  final IconData icon;
  DocUploadStatus status;
  String? fileName;
  double uploadProgress;
  String? errorMessage;

  DocUploadState({
    required this.id,
    required this.label,
    required this.hint,
    required this.icon,
    this.status = DocUploadStatus.empty,
    this.fileName,
    this.uploadProgress = 0,
    this.errorMessage,
  });

  bool get isRequired => true;
  bool get isUploaded => status == DocUploadStatus.uploaded;
}

// ── Mock user KYC state ────────────────────────────────────────────────────────

class UserKycState {
  final KycTier currentTier;
  final KycStatus tier2Status;
  final KycStatus tier3Status;
  final AccountType accountType;
  final String? rejectionReason;

  const UserKycState({
    required this.currentTier,
    required this.tier2Status,
    required this.tier3Status,
    required this.accountType,
    this.rejectionReason,
  });
}

// Mock — Tier 1 approved, Tier 2 not started
const kMockKycState = UserKycState(
  currentTier: KycTier.tier1,
  tier2Status: KycStatus.notStarted,
  tier3Status: KycStatus.notStarted,
  accountType: AccountType.individual,
);

// ── Tier definitions ───────────────────────────────────────────────────────────

const kTierInfoList = [
  KycTierInfo(
    tier: KycTier.tier1,
    label: 'Tier 1 — Basic',
    subtitle: 'Completed at registration',
    status: KycStatus.approved,
    investmentLimit: '₦500,000',
    icon: Icons.verified_user_outlined,
    benefits: [
      'Invest up to ₦500,000',
      'Access all standard products',
      'Basic wallet funding',
    ],
  ),
  KycTierInfo(
    tier: KycTier.tier2,
    label: 'Tier 2 — Standard',
    subtitle: 'Identity & address verification',
    status: KycStatus.notStarted,
    investmentLimit: '₦5,000,000',
    icon: Icons.badge_outlined,
    benefits: [
      'Invest up to ₦5,000,000',
      'Higher withdrawal limits',
      'Access to Beige Club',
      'Priority customer support',
    ],
  ),
  KycTierInfo(
    tier: KycTier.tier3,
    label: 'Tier 3 — Elite',
    subtitle: 'Advanced identity & wealth check',
    status: KycStatus.notStarted,
    investmentLimit: 'Unlimited',
    icon: Icons.workspace_premium_outlined,
    benefits: [
      'Unlimited investment volume',
      'Personal Wealth Advisor',
      'Priority withdrawal processing',
      'Exclusive premium products',
      'Concierge support',
    ],
  ),
];