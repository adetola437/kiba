part of '../controllers/kyc_hub_controller.dart';

class KycHubView extends StatelessWidget implements KycHubViewContract {
  const KycHubView({super.key, required this.controller});
  final KycHubControllerContract controller;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final state = controller.kycState;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: controller.onBack,
          child: Icon(
            Icons.arrow_back_rounded,
            size: 22.r,
            color: colorScheme.onSurface,
          ),
        ),
        title: Text(
          'Verify Your Identity',
          style: textTheme.titleLarge,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: REdgeInsets.only(right: 16),
            child: Icon(
              Icons.help_outline_rounded,
              size: 20.r,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.fromLTRB(20, 12, 20, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Current status banner ──────────────────────────────
            Container(
              padding: REdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48.r,
                    height: 48.r,
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.verified_rounded,
                      size: 24.r,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CURRENT STATUS',
                          style: textTheme.labelSmall?.copyWith(
                            color: colorScheme.onPrimary.withOpacity(0.55),
                            letterSpacing: 0.8,
                            fontSize: 9.sp,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Text(
                          'Tier ${state.currentTier.index + 1} Account',
                          style: textTheme.titleLarge?.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Tier progress pills
                  Row(
                    children: List.generate(3, (i) {
                      final isActive = i <= state.currentTier.index;
                      return Container(
                        width: 22.r,
                        height: 8.r,
                        margin: REdgeInsets.only(left: 4.w),
                        decoration: BoxDecoration(
                          color: isActive
                              ? colorScheme.primaryContainer
                              : colorScheme.onPrimary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10.h),

            // Upgrade prompt
            Container(
              padding: REdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: colorScheme.secondary.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: colorScheme.secondary.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 14.r,
                    color: colorScheme.onSurface,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Complete your verification to unlock higher investment limits and premium features.',
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 28.h),

            Text(
              'Verification Tiers',
              style: textTheme.titleLarge,
            ),
            SizedBox(height: 14.h),

            // ── Tier cards ─────────────────────────────────────────
            ...controller.tiers.asMap().entries.map((e) {
              final tier = e.value;
              final isCurrentTier = tier.tier == state.currentTier;
              final isCompleted = tier.tier.index < state.currentTier.index ||
                  tier.status == KycStatus.approved;
              final isNext =
                  tier.tier.index == state.currentTier.index + 1;
              final isLocked = tier.tier.index > state.currentTier.index + 1;

              // Determine tier2 status for display
              KycStatus displayStatus = tier.status;
              if (tier.tier == KycTier.tier2) displayStatus = state.tier2Status;
              if (tier.tier == KycTier.tier3) displayStatus = state.tier3Status;
              if (isCompleted) displayStatus = KycStatus.approved;

              return Padding(
                padding: REdgeInsets.only(bottom: 14),
                child: _TierCard(
                  tier: tier,
                  status: displayStatus,
                  isCurrentTier: isCurrentTier,
                  isNext: isNext,
                  isLocked: isLocked,
                  onUpgrade: isNext
                      ? () {
                          if (tier.tier == KycTier.tier2) {
                            controller.onUpgradeTier2();
                          } else {
                            controller.onUpgradeTier3();
                          }
                        }
                      : null,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

// ── Tier card ──────────────────────────────────────────────────────────────────
class _TierCard extends StatelessWidget {
  const _TierCard({
    required this.tier,
    required this.status,
    required this.isCurrentTier,
    required this.isNext,
    required this.isLocked,
    this.onUpgrade,
  });

  final KycTierInfo tier;
  final KycStatus status;
  final bool isCurrentTier;
  final bool isNext;
  final bool isLocked;
  final VoidCallback? onUpgrade;

  Color _statusColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    switch (status) {
      case KycStatus.approved:
        return colorScheme.primaryContainer;
      case KycStatus.pending:
        return colorScheme.secondary;
      case KycStatus.rejected:
        return colorScheme.error;
      case KycStatus.notStarted:
        return colorScheme.onSurfaceVariant;
    }
  }

  String get _statusLabel {
    switch (status) {
      case KycStatus.approved:
        return 'Complete';
      case KycStatus.pending:
        return 'Under Review';
      case KycStatus.rejected:
        return 'Action Required';
      case KycStatus.notStarted:
        return isLocked ? 'Locked' : 'Not Started';
    }
  }

  IconData get _statusIcon {
    switch (status) {
      case KycStatus.approved:
        return Icons.check_circle_rounded;
      case KycStatus.pending:
        return Icons.hourglass_top_rounded;
      case KycStatus.rejected:
        return Icons.error_outline_rounded;
      case KycStatus.notStarted:
        return isLocked
            ? Icons.lock_outline_rounded
            : Icons.radio_button_unchecked_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final statusColor = _statusColor(context);

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: isLocked ? 0.5 : 1.0,
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isNext
                ? colorScheme.primary.withOpacity(0.3)
                : colorScheme.outline,
            width: isNext ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            // Header
            Padding(
              padding: REdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 40.r,
                    height: 40.r,
                    decoration: BoxDecoration(
                      color: status == KycStatus.approved
                          ? colorScheme.primaryContainer.withOpacity(0.2)
                          : isNext
                              ? colorScheme.primary.withOpacity(0.08)
                              : colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      tier.icon,
                      size: 18.r,
                      color: status == KycStatus.approved
                          ? colorScheme.primary
                          : isNext
                              ? colorScheme.primary
                              : colorScheme.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tier.label,
                          style: textTheme.titleSmall?.copyWith(
                            color: isLocked
                                ? colorScheme.onSurfaceVariant
                                : colorScheme.onSurface,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          tier.subtitle,
                          style: textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  // Status badge
                  Row(
                    children: [
                      Icon(
                        _statusIcon,
                        size: 14.r,
                        color: statusColor,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        _statusLabel,
                        style: textTheme.labelSmall?.copyWith(
                          color: statusColor,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            // Investment limit + benefits
            Padding(
              padding: REdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Investment Limit:',
                        style: textTheme.bodySmall,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        tier.investmentLimit,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  ...tier.benefits.map(
                    (b) => Padding(
                      padding: REdgeInsets.only(bottom: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.check_rounded,
                            size: 13.r,
                            color: status == KycStatus.approved
                                ? colorScheme.primary
                                : colorScheme.onSurfaceVariant,
                          ),
                          SizedBox(width: 6.w),
                          Expanded(
                            child: Text(
                              b,
                              style: textTheme.bodySmall?.copyWith(
                                color: isLocked
                                    ? colorScheme.onSurfaceVariant
                                    : colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // CTA
                  if (isNext && status == KycStatus.notStarted) ...[
                    SizedBox(height: 14.h),
                    GestureDetector(
                      onTap: onUpgrade,
                      child: Container(
                        width: double.infinity,
                        height: 46.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Upgrade to ${tier.label.split(' ').first} ${tier.label.split(' ')[1]}',
                              style: textTheme.labelMedium?.copyWith(
                                color: colorScheme.onPrimary,
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Icon(
                              Icons.arrow_forward_rounded,
                              size: 14.r,
                              color: colorScheme.onPrimary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],

                  if (status == KycStatus.pending) ...[
                    SizedBox(height: 14.h),
                    Container(
                      width: double.infinity,
                      padding: REdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: colorScheme.secondary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.hourglass_top_rounded,
                            size: 14.r,
                            color: colorScheme.onSurface,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            'Under review — 24–48 business hours',
                            style: textTheme.labelSmall?.copyWith(
                              color: colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  if (status == KycStatus.rejected) ...[
                    SizedBox(height: 14.h),
                    GestureDetector(
                      onTap: onUpgrade,
                      child: Container(
                        width: double.infinity,
                        height: 46.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: colorScheme.error.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: colorScheme.error.withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          'Resubmit Documents',
                          style: textTheme.labelMedium?.copyWith(
                            color: colorScheme.error,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}