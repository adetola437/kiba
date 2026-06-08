import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/models/beige_club_data.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/enums.dart';

// ── Group Progress Screen ──────────────────────────────────────────────────────

class BeigeClubGroupProgressScreen extends StatelessWidget {
  static const String route = 'beige_club_progress';
  const BeigeClubGroupProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sub = kActiveSubscription;
    final dateFormat = DateFormat('MMM y');

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Icon(Icons.arrow_back_rounded,
              size: 22.r, color: AppColors.textPrimary),
        ),
        title: Text('Group Progress',
            style: AppTextStyles.titleLarge
                .copyWith(color: AppColors.textPrimary)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.fromLTRB(20, 12, 20, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── Group info banner ──────────────────────────────────
            Container(
              padding: REdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(sub.group.groupCode,
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.white.withOpacity(0.55),
                              letterSpacing: 1.0,
                            )),
                        SizedBox(height: 4.h),
                        Text(
                          '${sub.contributionsMade} of ${sub.group.totalMembers} months completed',
                          style: AppTextStyles.titleSmall.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4.r),
                          child: LinearProgressIndicator(
                            value: sub.contributionsMade / sub.group.totalMembers,
                            minHeight: 5.h,
                            backgroundColor: AppColors.white.withOpacity(0.15),
                            valueColor: const AlwaysStoppedAnimation(
                                AppColors.limeGreen),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Column(
                    children: [
                      Text(
                        '${((sub.contributionsMade / sub.group.totalMembers) * 100).toInt()}%',
                        style: AppTextStyles.headlineSmall.copyWith(
                          color: AppColors.limeGreen,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text('done',
                          style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.white.withOpacity(0.6))),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // ── Legend ────────────────────────────────────────────
            Row(
              children: [
                _LegendItem(color: AppColors.limeGreen, label: 'Paid out'),
                SizedBox(width: 16.w),
                _LegendItem(color: AppColors.beigePink, label: 'This month'),
                SizedBox(width: 16.w),
                _LegendItem(color: AppColors.primary, label: 'You'),
                SizedBox(width: 16.w),
                _LegendItem(
                    color: AppColors.textDisabled, label: 'Upcoming'),
              ],
            ),

            SizedBox(height: 20.h),

            // ── All 12 members ────────────────────────────────────
            Text('Rotation Order',
                style: AppTextStyles.titleLarge
                    .copyWith(color: AppColors.textPrimary)),
            SizedBox(height: 14.h),

            Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: sub.members.asMap().entries.map((e) {
                  final member = e.value;
                  final isLast = e.key == sub.members.length - 1;

                  // Compute payout month for each position
                  final startMonth = sub.group.startDate.month;
                  final startYear = sub.group.startDate.year;
                  final rawMonth = startMonth + member.position - 1;
                  final payoutMonth = DateTime(
                    startYear + (rawMonth - 1) ~/ 12,
                    ((rawMonth - 1) % 12) + 1,
                  );

                  return Column(
                    children: [
                      Container(
                        color: member.isUser
                            ? AppColors.primary.withOpacity(0.04)
                            : Colors.transparent,
                        child: Padding(
                          padding: REdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          child: Row(
                            children: [
                              // Position circle
                              Container(
                                width: 36.r, height: 36.r,
                                decoration: BoxDecoration(
                                  color: _memberBgColor(member),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: member.status ==
                                          ClubMemberStatus.paid
                                      ? Icon(Icons.check_rounded,
                                          size: 16.r,
                                          color: AppColors.primary)
                                      : Text(
                                          '${member.position}',
                                          style: AppTextStyles.labelMedium
                                              .copyWith(
                                            color: member.isUser
                                                ? AppColors.white
                                                : AppColors.textSecondary,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                ),
                              ),

                              SizedBox(width: 12.w),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      member.label,
                                      style: AppTextStyles.bodyMedium
                                          .copyWith(
                                        color: member.isUser
                                            ? AppColors.primary
                                            : AppColors.textPrimary,
                                        fontWeight: member.isUser
                                            ? FontWeight.w700
                                            : FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      'Payout: ${dateFormat.format(payoutMonth)}',
                                      style: AppTextStyles.bodySmall
                                          .copyWith(
                                        color: AppColors.textDisabled,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Status badge
                              _MemberStatusBadge(member: member),
                            ],
                          ),
                        ),
                      ),
                      if (!isLast)
                        Divider(
                          height: 1, color: AppColors.divider,
                          indent: 64.w,
                        ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _memberBgColor(ClubMember member) {
    if (member.isUser) return AppColors.primary;
    switch (member.status) {
      case ClubMemberStatus.paid:     return AppColors.limeGreen;
      case ClubMemberStatus.pending:  return AppColors.beigePink.withOpacity(0.6);
      case ClubMemberStatus.defaulted: return Colors.red.withOpacity(0.2);
      case ClubMemberStatus.upcoming: return AppColors.surfaceVariant;
    }
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label});
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10.r, height: 10.r,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 5.w),
        Text(label,
            style: AppTextStyles.bodySmall
                .copyWith(color: AppColors.textSecondary)),
      ],
    );
  }
}

class _MemberStatusBadge extends StatelessWidget {
  const _MemberStatusBadge({required this.member});
  final ClubMember member;

  @override
  Widget build(BuildContext context) {
    final String label;
    final Color bg;
    final Color fg;

    switch (member.status) {
      case ClubMemberStatus.paid:
        label = 'PAID OUT'; bg = AppColors.limeGreen.withOpacity(0.2);
        fg = AppColors.primary; break;
      case ClubMemberStatus.pending:
        label = 'NEXT'; bg = AppColors.beigePink.withOpacity(0.3);
        fg = AppColors.charcoalGrey; break;
      case ClubMemberStatus.defaulted:
        label = 'DEFAULTED'; bg = Colors.red.withOpacity(0.1);
        fg = Colors.red; break;
      case ClubMemberStatus.upcoming:
        label = 'UPCOMING'; bg = AppColors.surfaceVariant;
        fg = AppColors.textDisabled; break;
    }

    return Container(
      padding: REdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg, borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(label,
          style: AppTextStyles.labelSmall.copyWith(
            color: fg, fontSize: 9.sp, letterSpacing: 0.3)),
    );
  }
}

// ── Make Contribution Screen ───────────────────────────────────────────────────

class BeigeClubContributeScreen extends StatefulWidget {
  static const String route = 'beige_club_contribute';
  const BeigeClubContributeScreen({super.key});

  @override
  State<BeigeClubContributeScreen> createState() =>
      _BeigeClubContributeScreenState();
}

class _BeigeClubContributeScreenState
    extends State<BeigeClubContributeScreen> {
  bool _isLoading = false;

  String _fmt(double v) =>
      '₦${NumberFormat('#,##0.00', 'en_US').format(v)}';

  Future<void> _onConfirm() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 2000));
    if (!mounted) return;
    setState(() => _isLoading = false);
    // Show success snackbar then pop
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Contribution of ${_fmt(kActiveSubscription.monthlyAmount)} successful!',
          style: AppTextStyles.bodySmall.copyWith(color: AppColors.white),
        ),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r)),
        duration: const Duration(seconds: 3),
      ),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final sub = kActiveSubscription;
    final walletBalance = 2450000.0;

    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            scrolledUnderElevation: 0,
            leading: GestureDetector(
              onTap: () => context.pop(),
              child: Icon(Icons.arrow_back_rounded,
                  size: 22.r, color: AppColors.textPrimary),
            ),
            title: Text('Make Contribution',
                style: AppTextStyles.titleLarge
                    .copyWith(color: AppColors.textPrimary)),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: REdgeInsets.fromLTRB(20, 20, 20, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // Amount display
                      Container(
                        padding: REdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('CONTRIBUTION AMOUNT',
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: AppColors.white.withOpacity(0.55),
                                  letterSpacing: 1.0, fontSize: 9.sp,
                                )),
                            SizedBox(height: 6.h),
                            Text(_fmt(sub.monthlyAmount),
                                style: TextStyle(
                                  fontFamily: 'EuclidCircularA',
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.white,
                                )),
                            SizedBox(height: 12.h),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Icon(
                                    Icons.account_balance_wallet_outlined,
                                    size: 12.r,
                                    color: AppColors.white.withOpacity(0.55),
                                  ),
                                  SizedBox(width: 4.w),
                                  Text('Wallet Balance',
                                      style: AppTextStyles.bodySmall.copyWith(
                                          color: AppColors.white
                                              .withOpacity(0.55))),
                                ]),
                                Text(_fmt(walletBalance),
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: AppColors.limeGreen,
                                      fontWeight: FontWeight.w600,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // Contribution summary
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          children: [
                            _SummaryTile(label: 'Group', value: sub.group.groupCode),
                            Divider(height: 1, color: AppColors.divider, indent: 16.w),
                            _SummaryTile(
                              label: 'Month',
                              value: 'Month ${sub.contributionsMade + 1} of ${sub.group.totalMembers}',
                            ),
                            Divider(height: 1, color: AppColors.divider, indent: 16.w),
                            _SummaryTile(
                              label: 'Your Position',
                              value: 'Member #${sub.userPosition}',
                            ),
                            Divider(height: 1, color: AppColors.divider, indent: 16.w),
                            _SummaryTile(
                              label: 'Payout Month',
                              value: DateFormat('MMM y').format(sub.payoutMonth),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // Info note
                      Container(
                        padding: REdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.cloudyBlue.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                              color: AppColors.moodyBlue.withOpacity(0.15)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.info_outline_rounded,
                                size: 14.r, color: AppColors.moodyBlue),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                'This contribution will be deducted from your wallet balance and recorded against Month ${sub.contributionsMade + 1}.',
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.moodyBlue, height: 1.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // CTA
              Container(
                padding: REdgeInsets.fromLTRB(20, 12, 20, 32),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  border: Border(top: BorderSide(color: AppColors.divider)),
                ),
                child: GestureDetector(
                  onTap: _onConfirm,
                  child: Container(
                    width: double.infinity,
                    height: 56.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Text('Confirm Contribution',
                        style: AppTextStyles.labelLarge
                            .copyWith(color: AppColors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),

        if (_isLoading)
          Container(
            color: Colors.black.withOpacity(0.55),
            child: Center(
              child: Container(
                width: 200.w,
                padding: REdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 36.r, height: 36.r,
                      child: CircularProgressIndicator(
                          color: AppColors.primary, strokeWidth: 3),
                    ),
                    SizedBox(height: 14.h),
                    Text('Processing...',
                        style: AppTextStyles.titleSmall
                            .copyWith(color: AppColors.textPrimary)),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _SummaryTile extends StatelessWidget {
  const _SummaryTile({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondary)),
          Text(value,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              )),
        ],
      ),
    );
  }
}

// ── Contribution History Screen ────────────────────────────────────────────────

class BeigeClubHistoryScreen extends StatelessWidget {
  static const String route = 'beige_club_history';
  const BeigeClubHistoryScreen({super.key});

  String _fmt(double v) =>
      '₦${NumberFormat('#,##0.00', 'en_US').format(v)}';

  @override
  Widget build(BuildContext context) {
    final sub = kActiveSubscription;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Icon(Icons.arrow_back_rounded,
              size: 22.r, color: AppColors.textPrimary),
        ),
        title: Text('Contribution History',
            style: AppTextStyles.titleLarge
                .copyWith(color: AppColors.textPrimary)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.fromLTRB(20, 12, 20, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Summary card
            Container(
              padding: REdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Contributed',
                            style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.white.withOpacity(0.6))),
                        SizedBox(height: 4.h),
                        Text(_fmt(sub.totalContributed),
                            style: AppTextStyles.titleLarge.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w700,
                            )),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Accrued Interest',
                          style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.white.withOpacity(0.6))),
                      SizedBox(height: 4.h),
                      Text('+${_fmt(sub.accruedInterest)}',
                          style: AppTextStyles.titleSmall.copyWith(
                            color: AppColors.limeGreen,
                            fontWeight: FontWeight.w700,
                          )),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            Text('All Contributions',
                style: AppTextStyles.titleLarge
                    .copyWith(color: AppColors.textPrimary)),
            SizedBox(height: 14.h),

            Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: sub.contributionHistory
                    .asMap()
                    .entries
                    .map((e) {
                  final record = e.value;
                  final isLast =
                      e.key == sub.contributionHistory.length - 1;

                  return Column(
                    children: [
                      Padding(
                        padding: REdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        child: Row(
                          children: [
                            Container(
                              width: 40.r, height: 40.r,
                              decoration: BoxDecoration(
                                color: record.status ==
                                        ContributionStatus.successful
                                    ? AppColors.limeGreen.withOpacity(0.2)
                                    : AppColors.beigePink.withOpacity(0.3),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                record.status ==
                                        ContributionStatus.successful
                                    ? Icons.check_rounded
                                    : Icons.hourglass_top_rounded,
                                size: 18.r,
                                color: record.status ==
                                        ContributionStatus.successful
                                    ? AppColors.primary
                                    : AppColors.charcoalGrey,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Month ${record.month} of ${sub.group.totalMembers}',
                                    style: AppTextStyles.titleSmall
                                        .copyWith(
                                            color: AppColors.textPrimary),
                                  ),
                                  Text(
                                    DateFormat('MMM d, y')
                                        .format(record.date),
                                    style: AppTextStyles.bodySmall
                                        .copyWith(
                                            color: AppColors.textDisabled),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  _fmt(record.amount),
                                  style: AppTextStyles.titleSmall.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Container(
                                  padding: REdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.limeGreen
                                        .withOpacity(0.2),
                                    borderRadius:
                                        BorderRadius.circular(4.r),
                                  ),
                                  child: Text('PAID',
                                      style: AppTextStyles.labelSmall
                                          .copyWith(
                                        color: AppColors.primary,
                                        fontSize: 9.sp,
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (!isLast)
                        Divider(
                          height: 1,
                          color: AppColors.divider,
                          indent: 68.w,
                        ),
                    ],
                  );
                }).toList(),
              ),
            ),

            // Pending months
            if (sub.monthsRemaining > 0) ...[
              SizedBox(height: 20.h),
              Text('Upcoming Contributions',
                  style: AppTextStyles.titleSmall.copyWith(
                      color: AppColors.textSecondary)),
              SizedBox(height: 10.h),
              ...List.generate(
                sub.monthsRemaining > 3 ? 3 : sub.monthsRemaining,
                (i) {
                  final monthNum = sub.contributionsMade + i + 1;
                  return Padding(
                    padding: REdgeInsets.only(bottom: 8),
                    child: Container(
                      padding: REdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                            color: AppColors.border),
                      ),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Month $monthNum of ${sub.group.totalMembers}',
                              style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.textSecondary)),
                          Text(_fmt(sub.monthlyAmount),
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textDisabled,
                              )),
                        ],
                      ),
                    ),
                  );
                },
              ),
              if (sub.monthsRemaining > 3)
                Center(
                  child: Text(
                    '+${sub.monthsRemaining - 3} more months',
                    style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textDisabled),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}