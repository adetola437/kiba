import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/models/beige_club_data.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Shown before the user joins — lets them browse all available groups
/// across different tiers and start months.
class BeigeClubGroupsScreen extends StatefulWidget {
  static const String route = 'beige_club_groups';
  const BeigeClubGroupsScreen({super.key});

  @override
  State<BeigeClubGroupsScreen> createState() =>
      _BeigeClubGroupsScreenState();
}

class _BeigeClubGroupsScreenState extends State<BeigeClubGroupsScreen> {
  double? _selectedTier; // null = all

  List<ClubGroup> get _filtered {
    if (_selectedTier == null) return kAvailableGroups;
    return kAvailableGroups
        .where((g) => g.monthlyAmount == _selectedTier)
        .toList();
  }

  String _fmtShort(double v) {
    if (v >= 1000000) return '₦${(v / 1000000).toStringAsFixed(0)}M';
    if (v >= 1000) return '₦${(v / 1000).toStringAsFixed(0)}K';
    return '₦${v.toStringAsFixed(0)}';
  }

  @override
  Widget build(BuildContext context) {
    final tiers = kAvailableGroups
        .map((g) => g.monthlyAmount)
        .toSet()
        .toList()
      ..sort();

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
        title: Text('Choose a Group',
            style: AppTextStyles.titleLarge
                .copyWith(color: AppColors.textPrimary)),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ── Tier filter chips ──────────────────────────────────────
          Padding(
            padding: REdgeInsets.fromLTRB(20, 12, 20, 0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // All
                  _TierChip(
                    label: 'All',
                    isSelected: _selectedTier == null,
                    onTap: () => setState(() => _selectedTier = null),
                  ),
                  SizedBox(width: 10.w),
                  ...tiers.map((t) => Padding(
                    padding: REdgeInsets.only(right: 10),
                    child: _TierChip(
                      label: '${_fmtShort(t)}/mo',
                      isSelected: _selectedTier == t,
                      onTap: () => setState(() => _selectedTier = t),
                    ),
                  )),
                ],
              ),
            ),
          ),

          SizedBox(height: 20.h),

          // ── Group list ─────────────────────────────────────────────
          Expanded(
            child: ListView.separated(
              padding: REdgeInsets.fromLTRB(20, 0, 20, 40),
              itemCount: _filtered.length,
              separatorBuilder: (_, __) => SizedBox(height: 14.h),
              itemBuilder: (_, i) {
                final group = _filtered[i];
                return _GroupCard(
                  group: group,
                  onTap: group.isFull
                      ? null
                      : () => context.pushNamed(
                            'beige_club_setup',
                            extra: {'group': group},
                          ),
                  fmtShort: _fmtShort,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ── Tier chip ──────────────────────────────────────────────────────────────────
class _TierChip extends StatelessWidget {
  const _TierChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.buttonBorder,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.labelMedium.copyWith(
            color: isSelected ? AppColors.white : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

// ── Group card ─────────────────────────────────────────────────────────────────
class _GroupCard extends StatelessWidget {
  const _GroupCard({
    required this.group,
    required this.onTap,
    required this.fmtShort,
  });
  final ClubGroup group;
  final VoidCallback? onTap;
  final String Function(double) fmtShort;

  String _fmt(double v) =>
      '₦${NumberFormat('#,##0.00', 'en_US').format(v)}';

  @override
  Widget build(BuildContext context) {
    final isFull = group.isFull;
    final dateFormat = DateFormat('MMM y');

    return GestureDetector(
      onTap: onTap,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: isFull ? 0.55 : 1.0,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: isFull ? AppColors.border : AppColors.buttonBorder,
            ),
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: REdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isFull
                      ? AppColors.surfaceVariant
                      : AppColors.primary,
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16.r)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40.r, height: 40.r,
                      decoration: BoxDecoration(
                        color: isFull
                            ? AppColors.textDisabled.withOpacity(0.15)
                            : AppColors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        Icons.people_rounded,
                        size: 18.r,
                        color: isFull
                            ? AppColors.textDisabled
                            : AppColors.limeGreen,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            group.groupCode,
                            style: AppTextStyles.titleSmall.copyWith(
                              color: isFull
                                  ? AppColors.textSecondary
                                  : AppColors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '${group.ratePercent}% p.a. · 12-month cycle',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: isFull
                                  ? AppColors.textDisabled
                                  : AppColors.white.withOpacity(0.65),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Full / Open badge
                    Container(
                      padding: REdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: isFull
                            ? AppColors.textDisabled.withOpacity(0.15)
                            : AppColors.limeGreen.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        isFull ? 'FULL' : '${group.openSlots} OPEN',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: isFull
                              ? AppColors.textDisabled
                              : AppColors.limeGreen,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Body
              Padding(
                padding: REdgeInsets.all(16),
                child: Column(
                  children: [
                    // Stats row
                    Row(
                      children: [
                        _StatItem(
                          label: 'Monthly',
                          value: fmtShort(group.monthlyAmount),
                        ),
                        _vDivider(),
                        _StatItem(
                          label: 'Slots',
                          value:
                              '${group.filledSlots}/${group.totalMembers}',
                        ),
                        _vDivider(),
                        _StatItem(
                          label: 'Starts',
                          value: dateFormat.format(group.startDate),
                        ),
                        _vDivider(),
                        _StatItem(
                          label: 'Ends',
                          value: dateFormat.format(group.endDate),
                        ),
                      ],
                    ),

                    SizedBox(height: 14.h),

                    // Slots progress bar
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${group.filledSlots} of ${group.totalMembers} members joined',
                              style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.textSecondary),
                            ),
                            Text(
                              isFull
                                  ? 'Group full'
                                  : '${group.openSlots} slots left',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: isFull
                                    ? AppColors.textDisabled
                                    : AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4.r),
                          child: LinearProgressIndicator(
                            value: group.filledSlots / group.totalMembers,
                            minHeight: 6.h,
                            backgroundColor: AppColors.surfaceVariant,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              isFull
                                  ? AppColors.textDisabled
                                  : AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 14.h),

                    // CTA or full notice
                    if (isFull)
                      Container(
                        width: double.infinity,
                        height: 44.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceVariant,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          'This group is full',
                          style: AppTextStyles.labelMedium.copyWith(
                              color: AppColors.textDisabled),
                        ),
                      )
                    else
                      Container(
                        width: double.infinity,
                        height: 44.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Join this Group',
                              style: AppTextStyles.labelMedium.copyWith(
                                  color: AppColors.white),
                            ),
                            SizedBox(width: 6.w),
                            Icon(Icons.arrow_forward_rounded,
                                size: 14.r, color: AppColors.white),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _vDivider() => Container(
        width: 1,
        height: 32.h,
        color: AppColors.divider,
        margin: REdgeInsets.symmetric(horizontal: 8),
      );
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(value,
              style: AppTextStyles.titleSmall.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              )),
          SizedBox(height: 2.h),
          Text(label,
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.textDisabled,
                fontSize: 9.sp,
              )),
        ],
      ),
    );
  }
}