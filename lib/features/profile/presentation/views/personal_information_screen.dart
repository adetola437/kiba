import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PersonalInformationScreen extends StatelessWidget {
  static const String route = 'personal_info';

  const PersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    const details = [
      _ProfileDetail(label: 'Full Name', value: 'Ismail Adamu'),
      _ProfileDetail(label: 'Email Address', value: 'ismail.adamu@example.com'),
      _ProfileDetail(label: 'Phone Number', value: '+234 812 345 6789'),
      _ProfileDetail(label: 'Date of Birth', value: '12 January 1993'),
      _ProfileDetail(label: 'BVN', value: '222 **** 889'),
    ];

    return Scaffold(
      appBar: _ProfileSubpageAppBar(
        title: 'Personal Information',
        onBackTap: () => context.pop(),
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.fromLTRB(20, 20, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: REdgeInsets.all(18),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(18.r),
                border: Border.all(color: colorScheme.outline),
              ),
              child: Column(
                children: [
                  Container(
                    width: 72.r,
                    height: 72.r,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceVariant,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      'IA',
                      style: textTheme.headlineSmall?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 14.h),
                  Text(
                    'Ismail Adamu',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Basic KYC verified',
                    style: textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(18.r),
                border: Border.all(color: colorScheme.outline),
              ),
              child: Column(
                children: details.asMap().entries.map((entry) {
                  final isLast = entry.key == details.length - 1;
                  return _DetailRow(detail: entry.value, showDivider: !isLast);
                }).toList(),
              ),
            ),
            SizedBox(height: 18.h),
            Container(
              padding: REdgeInsets.all(14),
              decoration: BoxDecoration(
                color: colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 18.r,
                    color: colorScheme.tertiary,
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      'Some details are locked after verification. Contact support if anything needs to be updated.',
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.tertiary,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LinkedBankAccountsScreen extends StatelessWidget {
  static const String route = 'linked_banks';

  const LinkedBankAccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    const accounts = [
      _LinkedBankAccount(
        bankName: 'First Bank of Nigeria',
        maskedNumber: '0092 **** 4412',
        accountName: 'ISMAIL ADAMU',
        brandColor: Color(0xFF003087),
        isPrimary: true,
      ),
      _LinkedBankAccount(
        bankName: 'GT Bank',
        maskedNumber: '2210 **** 8821',
        accountName: 'ISMAIL ADAMU',
        brandColor: Color(0xFFE05D00),
        isPrimary: false,
      ),
    ];

    return Scaffold(
      appBar: _ProfileSubpageAppBar(
        title: 'Linked Bank Accounts',
        onBackTap: () => context.pop(),
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.fromLTRB(20, 20, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Accounts',
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'Manage the bank accounts connected to withdrawals and payouts.',
              style: textTheme.bodySmall,
            ),
            SizedBox(height: 18.h),
            ...accounts.map(
              (account) => Padding(
                padding: REdgeInsets.only(bottom: 12),
                child: _LinkedBankAccountCard(account: account),
              ),
            ),
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: () => context.pushNamed('profile_add_bank_account'),
              child: Container(
                height: 56.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_rounded,
                      size: 20.r,
                      color: colorScheme.onPrimary,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Add Bank Account',
                      style: textTheme.labelLarge?.copyWith(
                        color: colorScheme.onPrimary,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileSubpageAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const _ProfileSubpageAppBar({
    required this.title,
    required this.onBackTap,
  });

  final String title;
  final VoidCallback onBackTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AppBar(
      centerTitle: true,
      leading: GestureDetector(
        onTap: onBackTap,
        child: Container(
          margin: REdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: colorScheme.outline),
          ),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 16.r,
            color: colorScheme.onSurface,
          ),
        ),
      ),
      title: Text(
        title,
        style: textTheme.titleMedium,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ProfileDetail {
  const _ProfileDetail({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.detail,
    required this.showDivider,
  });

  final _ProfileDetail detail;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 18, vertical: 15),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  detail.label,
                  style: textTheme.bodySmall,
                ),
              ),
              SizedBox(width: 16.w),
              Flexible(
                child: Text(
                  detail.value,
                  textAlign: TextAlign.right,
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            color: colorScheme.outline,
            indent: 18.w,
          ),
      ],
    );
  }
}

class _LinkedBankAccount {
  const _LinkedBankAccount({
    required this.bankName,
    required this.maskedNumber,
    required this.accountName,
    required this.brandColor,
    required this.isPrimary,
  });

  final String bankName;
  final String maskedNumber;
  final String accountName;
  final Color brandColor;
  final bool isPrimary;
}

class _LinkedBankAccountCard extends StatelessWidget {
  const _LinkedBankAccountCard({required this.account});

  final _LinkedBankAccount account;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Row(
        children: [
          Container(
            width: 48.r,
            height: 48.r,
            decoration: BoxDecoration(
              color: account.brandColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.account_balance_outlined,
              size: 22.r,
              color: account.brandColor,
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        account.bankName,
                        style: textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    if (account.isPrimary)
                      Container(
                        padding: REdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer.withOpacity(0.35),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          'Primary',
                          style: textTheme.labelSmall?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  account.maskedNumber,
                  style: textTheme.bodySmall?.copyWith(
                    letterSpacing: 1.0,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  account.accountName,
                  style: textTheme.labelSmall,
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Icon(
            Icons.more_vert_rounded,
            size: 20.r,
            color: colorScheme.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}