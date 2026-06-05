import 'package:flutter/material.dart';

import '../../../../core/utils/enums.dart';

class ProfileMenuItem {
  final IconData icon;
  final String label;
  final ProfileMenuRoute route;
 
  const ProfileMenuItem({
    required this.icon,
    required this.label,
    required this.route,
  });
}

class ProfileMenuSection {
  final String title;
  final List<ProfileMenuItem> items;
 
  const ProfileMenuSection({required this.title, required this.items});
}
 
const kProfileSections = [
  ProfileMenuSection(
    title: 'REWARDS & REFERRALS',
    items: [
      ProfileMenuItem(
        icon: Icons.card_giftcard_rounded,
        label: 'Refer and Earn',
        route: ProfileMenuRoute.referAndEarn,
      ),
      ProfileMenuItem(
        icon: Icons.confirmation_number_outlined,
        label: 'Promo Codes',
        route: ProfileMenuRoute.promoCodes,
      ),
    ],
  ),
  ProfileMenuSection(
    title: 'ACCOUNT',
    items: [
      ProfileMenuItem(
        icon: Icons.person_outline_rounded,
        label: 'Personal Information',
        route: ProfileMenuRoute.personalInfo,
      ),
      ProfileMenuItem(
        icon: Icons.account_balance_outlined,
        label: 'Linked Bank Accounts',
        route: ProfileMenuRoute.linkedBanks,
      ),
      ProfileMenuItem(
        icon: Icons.description_outlined,
        label: 'Documents & Reports',
        route: ProfileMenuRoute.documents,
      ),
      ProfileMenuItem(
        icon: Icons.verified_user_outlined,
        label: 'Verify Identity (KYC)',
        route: ProfileMenuRoute.kyc,
      ),
    ],
  ),
  ProfileMenuSection(
    title: 'PREFERENCES',
    items: [
      ProfileMenuItem(
        icon: Icons.notifications_outlined,
        label: 'Notification Settings',
        route: ProfileMenuRoute.notifications,
      ),
      ProfileMenuItem(
        icon: Icons.fingerprint_rounded,
        label: 'Biometrics & Security',
        route: ProfileMenuRoute.biometrics,
      ),
    ],
  ),
  ProfileMenuSection(
    title: 'SUPPORT',
    items: [
      ProfileMenuItem(
        icon: Icons.help_outline_rounded,
        label: 'Help Center / FAQs',
        route: ProfileMenuRoute.helpCenter,
      ),
      ProfileMenuItem(
        icon: Icons.headset_mic_outlined,
        label: 'Contact Support',
        route: ProfileMenuRoute.contactSupport,
      ),
      ProfileMenuItem(
        icon: Icons.info_outline_rounded,
        label: 'About Beige Africa',
        route: ProfileMenuRoute.about,
      ),
    ],
  ),
];


 