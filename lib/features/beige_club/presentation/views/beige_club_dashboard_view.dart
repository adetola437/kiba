part of '../controllers/beige_club_dashboard_controller.dart';

class BeigeClubDashboardView extends StatelessWidget
    implements BeigeClubDashboardViewContract {
  const BeigeClubDashboardView({super.key, required this.controller});

  final BeigeClubDashboardControllerContract controller;

  String _fmt(double v) =>
      '₦${NumberFormat('#,##0.00', 'en_US').format(v)}';

  @override
  Widget build(BuildContext context) {
    final sub = controller.subscription;
    final dateFormat = DateFormat('MMM d, y');

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: controller.onBack,
          child: Icon(Icons.arrow_back_rounded,
              size: 22.r, color: AppColors.textPrimary),
        ),
        title: Text('Beige Club',
            style: AppTextStyles.titleLarge
                .copyWith(color: AppColors.textPrimary)),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: REdgeInsets.fromLTRB(20, 8, 20, 40),
            sliver: SliverList(
              delegate: SliverChildListDelegate([

                // ── Hero stats card ────────────────────────────────
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: -30.r, right: -30.r,
                        child: Container(
                          width: 130.r, height: 130.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.04),
                          ),
                        ),
                      ),
                      Padding(
                        padding: REdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Group code + status
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  sub.group.groupCode,
                                  style: AppTextStyles.labelSmall.copyWith(
                                    color: AppColors.white.withOpacity(0.55),
                                    letterSpacing: 1.0,
                                  ),
                                ),
                                Container(
                                  padding: REdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.limeGreen
                                        .withOpacity(0.25),
                                    borderRadius:
                                        BorderRadius.circular(20.r),
                                  ),
                                  child: Text(
                                    'ACTIVE',
                                    style: AppTextStyles.labelSmall.copyWith(
                                      color: AppColors.limeGreen,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 14.h),

                            // Total contributed
                            Text(
                              'TOTAL CONTRIBUTED',
                              style: AppTextStyles.labelSmall.copyWith(
                                color: AppColors.white.withOpacity(0.5),
                                letterSpacing: 1.0, fontSize: 9.sp,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              _fmt(sub.totalContributed),
                              style: TextStyle(
                                fontFamily: 'EuclidCircularA',
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.white,
                              ),
                            ),

                            SizedBox(height: 16.h),

                            // Stats row
                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  _StatCell(
                                    label: 'ACCRUED',
                                    value: _fmt(sub.accruedInterest),
                                    valueColor: AppColors.limeGreen,
                                  ),
                                  VerticalDivider(
                                    color: AppColors.white.withOpacity(0.15),
                                    width: 1, thickness: 1,
                                  ),
                                  _StatCell(
                                    label: 'POSITION',
                                    value: '#${sub.userPosition} of ${sub.group.totalMembers}',
                                  ),
                                  VerticalDivider(
                                    color: AppColors.white.withOpacity(0.15),
                                    width: 1, thickness: 1,
                                  ),
                                  _StatCell(
                                    label: 'PAYOUT MONTH',
                                    value: DateFormat('MMM y')
                                        .format(sub.payoutMonth),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 16.h),

                            // Progress bar
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${sub.contributionsMade} of ${sub.group.totalMembers} months paid',
                                      style: AppTextStyles.bodySmall.copyWith(
                                        color: AppColors.white.withOpacity(0.6),
                                      ),
                                    ),
                                    Text(
                                      '${sub.monthsRemaining} remaining',
                                      style: AppTextStyles.bodySmall.copyWith(
                                        color: AppColors.white.withOpacity(0.5),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.h),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4.r),
                                  child: LinearProgressIndicator(
                                    value: sub.progressPercent,
                                    minHeight: 6.h,
                                    backgroundColor:
                                        AppColors.white.withOpacity(0.15),
                                    valueColor:
                                        const AlwaysStoppedAnimation(
                                            AppColors.limeGreen),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16.h),

                // ── Contribution due banner ────────────────────────
                if (sub.isNextContributionDue)
                  Container(
                    padding: REdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.beigePink.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(
                        color: AppColors.beigePink.withOpacity(0.4),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today_outlined,
                            size: 16.r, color: AppColors.charcoalGrey),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Contribution due ${dateFormat.format(sub.nextContributionDue)}',
                                style: AppTextStyles.titleSmall.copyWith(
                                  color: AppColors.charcoalGrey,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                _fmt(sub.monthlyAmount),
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.charcoalGrey
                                      .withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: controller.onMakeContribution,
                          child: Container(
                            padding: REdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              'Pay Now',
                              style: AppTextStyles.labelSmall.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                SizedBox(height: 24.h),

                // ── Quick actions ──────────────────────────────────
                Row(
                  children: [
                    Expanded(
                      child: _ActionCard(
                        icon: Icons.add_circle_outline_rounded,
                        label: 'Make\nContribution',
                        onTap: controller.onMakeContribution,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _ActionCard(
                        icon: Icons.people_outline_rounded,
                        label: 'Group\nProgress',
                        onTap: controller.onViewGroupProgress,
                        color: AppColors.moodyBlue,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _ActionCard(
                        icon: Icons.history_rounded,
                        label: 'Contribution\nHistory',
                        onTap: controller.onViewHistory,
                        color: AppColors.charcoalGrey,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 28.h),

                // ── Rotation timeline ──────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Rotation Timeline',
                        style: AppTextStyles.titleLarge.copyWith(
                            color: AppColors.textPrimary)),
                    GestureDetector(
                      onTap: controller.onViewGroupProgress,
                      child: Text('See all',
                          style: AppTextStyles.labelMedium.copyWith(
                              color: AppColors.primary)),
                    ),
                  ],
                ),

                SizedBox(height: 14.h),

                // Show first 6 members
                ...sub.members.take(6).map((m) =>
                    _MemberRotationRow(member: m)),

                if (sub.members.length > 6) ...[
                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTap: controller.onViewGroupProgress,
                    child: Center(
                      child: Text(
                        'View all ${sub.members.length} members →',
                        style: AppTextStyles.labelMedium.copyWith(
                            color: AppColors.primary),
                      ),
                    ),
                  ),
                ],

                SizedBox(height: 28.h),

                // ── Recent contributions ───────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Recent Contributions',
                        style: AppTextStyles.titleLarge.copyWith(
                            color: AppColors.textPrimary)),
                    GestureDetector(
                      onTap: controller.onViewHistory,
                      child: Text('View all',
                          style: AppTextStyles.labelMedium.copyWith(
                              color: AppColors.primary)),
                    ),
                  ],
                ),

                SizedBox(height: 14.h),

                Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: sub.contributionHistory
                        .take(3)
                        .toList()
                        .asMap()
                        .entries
                        .map((e) {
                      final isLast = e.key == 2 ||
                          e.key ==
                              sub.contributionHistory.take(3).length - 1;
                      return Column(
                        children: [
                          _ContributionHistoryRow(record: e.value),
                          if (!isLast)
                            Divider(
                                height: 1,
                                color: AppColors.divider,
                                indent: 60.w),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Widgets ────────────────────────────────────────────────────────────────────

class _StatCell extends StatelessWidget {
  const _StatCell({
    required this.label,
    required this.value,
    this.valueColor,
  });
  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.white.withOpacity(0.5),
                  fontSize: 9.sp, letterSpacing: 0.8,
                )),
            SizedBox(height: 3.h),
            Text(value,
                style: AppTextStyles.bodySmall.copyWith(
                  color: valueColor ?? AppColors.white,
                  fontWeight: FontWeight.w600,
                )),
          ],
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.color,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: REdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.07),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: color.withOpacity(0.15)),
        ),
        child: Column(
          children: [
            Icon(icon, size: 22.r, color: color),
            SizedBox(height: 6.h),
            Text(label,
                textAlign: TextAlign.center,
                style: AppTextStyles.labelSmall.copyWith(
                  color: color,
                  height: 1.3,
                )),
          ],
        ),
      ),
    );
  }
}

class _MemberRotationRow extends StatelessWidget {
  const _MemberRotationRow({required this.member});
  final ClubMember member;

  Color get _statusColor {
    switch (member.status) {
      case ClubMemberStatus.paid:     return AppColors.limeGreen;
      case ClubMemberStatus.pending:  return AppColors.beigePink;
      case ClubMemberStatus.defaulted: return Colors.red;
      case ClubMemberStatus.upcoming: return AppColors.surfaceVariant;
    }
  }

  IconData get _statusIcon {
    switch (member.status) {
      case ClubMemberStatus.paid:     return Icons.check_circle_rounded;
      case ClubMemberStatus.pending:  return Icons.hourglass_top_rounded;
      case ClubMemberStatus.defaulted: return Icons.cancel_rounded;
      case ClubMemberStatus.upcoming: return Icons.circle_outlined;
    }
  }

  String get _statusLabel {
    switch (member.status) {
      case ClubMemberStatus.paid:     return 'Paid out';
      case ClubMemberStatus.pending:  return 'This month';
      case ClubMemberStatus.defaulted: return 'Defaulted';
      case ClubMemberStatus.upcoming: return 'Upcoming';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Position badge
          Container(
            width: 32.r, height: 32.r,
            decoration: BoxDecoration(
              color: member.isUser
                  ? AppColors.primary
                  : AppColors.surfaceVariant,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${member.position}',
                style: AppTextStyles.labelSmall.copyWith(
                  color: member.isUser
                      ? AppColors.white
                      : AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

          SizedBox(width: 12.w),

          // Label
          Expanded(
            child: Text(
              member.label,
              style: AppTextStyles.bodyMedium.copyWith(
                color: member.isUser
                    ? AppColors.primary
                    : AppColors.textPrimary,
                fontWeight: member.isUser
                    ? FontWeight.w700
                    : FontWeight.w400,
              ),
            ),
          ),

          // Status
          Row(
            children: [
              Icon(_statusIcon,
                  size: 14.r,
                  color: member.status == ClubMemberStatus.upcoming
                      ? AppColors.textDisabled
                      : _statusColor),
              SizedBox(width: 5.w),
              Text(_statusLabel,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: member.status == ClubMemberStatus.upcoming
                        ? AppColors.textDisabled
                        : _statusColor,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}

class _ContributionHistoryRow extends StatelessWidget {
  const _ContributionHistoryRow({required this.record});
  final ContributionRecord record;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 40.r, height: 40.r,
            decoration: BoxDecoration(
              color: AppColors.limeGreen.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check_rounded,
                size: 18.r, color: AppColors.primary),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Month ${record.month} Contribution',
                    style: AppTextStyles.titleSmall.copyWith(
                        color: AppColors.textPrimary)),
                Text(DateFormat('MMM d, y').format(record.date),
                    style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textDisabled)),
              ],
            ),
          ),
          Text(
            '₦${NumberFormat('#,##0').format(record.amount)}',
            style: AppTextStyles.titleSmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}