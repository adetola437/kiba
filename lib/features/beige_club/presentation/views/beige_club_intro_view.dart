part of '../controllers/beige_club_intro_controller.dart';

class BeigeClubIntroView extends StatelessWidget
    implements BeigeClubIntroViewContract {
  const BeigeClubIntroView({super.key, required this.controller});

  final BeigeClubIntroControllerContract controller;

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: REdgeInsets.fromLTRB(20, 8, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // ── Hero banner ──────────────────────────────────
                  Container(
                    width: double.infinity,
                    height: 160.h,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: -20.r, right: -20.r,
                          child: Container(
                            width: 120.r, height: 120.r,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.05),
                            ),
                          ),
                        ),
                        Padding(
                          padding: REdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: REdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.white.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Text(
                                  'Monthly Savings Scheme',
                                  style: AppTextStyles.labelSmall.copyWith(
                                    color: AppColors.white.withOpacity(0.8),
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                'The Beige Club',
                                style: AppTextStyles.headlineMedium.copyWith(
                                  fontFamily: 'BWGradual',
                                  color: AppColors.white,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: REdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.beigePink,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Text(
                                  '16% p.a.',
                                  style: AppTextStyles.labelMedium.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Group icon top-right
                        Positioned(
                          top: 16.r, right: 20.r,
                          child: Icon(Icons.people_rounded,
                              size: 48.r,
                              color: AppColors.white.withOpacity(0.1)),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // ── Slots availability ───────────────────────────
                  Container(
                    padding: REdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.limeGreen.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(
                        color: AppColors.limeGreen.withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Current Group Availability',
                              style: AppTextStyles.titleSmall.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                            Text(
                              '${data.kClubTotalMembers - data.kSlotsFilled} slots left',
                              style: AppTextStyles.labelMedium.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4.r),
                          child: LinearProgressIndicator(
                            value: data.kSlotsFilled /
                                data.kClubTotalMembers,
                            minHeight: 6.h,
                            backgroundColor:
                                AppColors.primary.withOpacity(0.12),
                            valueColor: const AlwaysStoppedAnimation(
                                AppColors.primary),
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          '${data.kSlotsFilled} of ${data.kClubTotalMembers} members have joined',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.primary.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // ── How It Works ─────────────────────────────────
                  Text('How It Works',
                      style: AppTextStyles.titleLarge.copyWith(
                          color: AppColors.textPrimary)),
                  SizedBox(height: 14.h),

                  Row(
                    children: [
                      Expanded(
                        child: _HowItWorksCard(
                          icon: Icons.groups_rounded,
                          title: 'Form a Group',
                          body:
                              '12 members each commit to a monthly contribution.',
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _HowItWorksCard(
                          icon: Icons.rotate_right_rounded,
                          title: 'Rotate Payouts',
                          body:
                              'Each month, one member receives the full pool.',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(
                        child: _HowItWorksCard(
                          icon: Icons.trending_up_rounded,
                          title: 'Earn Interest',
                          body:
                              'Get 16% p.a. on all contributions while waiting your turn.',
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _HowItWorksCard(
                          icon: Icons.emoji_events_outlined,
                          title: 'Your Turn',
                          body:
                              'Receive the full pool + accrued interest when it\'s your month.',
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 24.h),

                  // ── Example calculator ───────────────────────────
                  Container(
                    padding: REdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Example: ₦50,000/month for 12 months',
                          style: AppTextStyles.titleSmall.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 14.h),
                        _ExampleRow(
                            label: 'Total Contributed',
                            value: '₦600,000.00'),
                        _divider(),
                        _ExampleRow(
                          label: 'Interest Earned (16% p.a.)',
                          value: '+₦48,000.00',
                          valueColor: AppColors.primary,
                        ),
                        _divider(),
                        _ExampleRow(
                          label: 'Year-End Payout',
                          value: '₦648,000.00',
                          isBold: true,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // ── Features ─────────────────────────────────────
                  Text('Features',
                      style: AppTextStyles.titleLarge.copyWith(
                          color: AppColors.textPrimary)),
                  SizedBox(height: 14.h),

                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      children: data.kClubFeatures
                          .asMap()
                          .entries
                          .map((e) {
                        final isLast =
                            e.key == data.kClubFeatures.length - 1;
                        return Column(
                          children: [
                            Padding(
                              padding: REdgeInsets.symmetric(
                                  horizontal: 16, vertical: 14),
                              child: Row(
                                children: [
                                  Container(
                                    width: 34.r,
                                    height: 34.r,
                                    decoration: BoxDecoration(
                                      color: AppColors.limeGreen
                                          .withOpacity(0.25),
                                      borderRadius:
                                          BorderRadius.circular(10.r),
                                    ),
                                    child: Icon(e.value.icon,
                                        size: 16.r,
                                        color: AppColors.primary),
                                  ),
                                  SizedBox(width: 14.w),
                                  Expanded(
                                    child: Text(
                                      e.value.label,
                                      style: AppTextStyles.bodyMedium
                                          .copyWith(
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (!isLast)
                              Divider(
                                height: 1,
                                color: AppColors.divider,
                                indent: 64.w,
                              ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),

                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),

          // ── CTA ──────────────────────────────────────────────────
          Container(
            padding: REdgeInsets.fromLTRB(20, 12, 20, 32),
            decoration: BoxDecoration(
              color: AppColors.background,
              border: Border(top: BorderSide(color: AppColors.divider)),
            ),
            child: GestureDetector(
              onTap: controller.onJoin,
              child: Container(
                width: double.infinity,
                height: 56.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Text(
                  'Join Beige Club',
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() => Padding(
      padding: REdgeInsets.symmetric(vertical: 10),
      child: Divider(color: AppColors.divider, height: 1));
}

class _HowItWorksCard extends StatelessWidget {
  const _HowItWorksCard({
    required this.icon,
    required this.title,
    required this.body,
  });
  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36.r, height: 36.r,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, size: 18.r, color: AppColors.primary),
          ),
          SizedBox(height: 10.h),
          Text(title,
              style: AppTextStyles.titleSmall.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700)),
          SizedBox(height: 4.h),
          Text(body,
              style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary, height: 1.5)),
        ],
      ),
    );
  }
}

class _ExampleRow extends StatelessWidget {
  const _ExampleRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.isBold = false,
  });
  final String label;
  final String value;
  final Color? valueColor;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: AppTextStyles.bodySmall
                .copyWith(color: AppColors.textSecondary)),
        Text(value,
            style: AppTextStyles.bodySmall.copyWith(
              color: valueColor ?? AppColors.textPrimary,
              fontWeight:
                  isBold ? FontWeight.w700 : FontWeight.w500,
            )),
      ],
    );
  }
}