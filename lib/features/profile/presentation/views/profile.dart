part of '../controllers/profile.dart';

class ProfileView extends StatelessWidget implements ProfileViewContract {
  const ProfileView({super.key, required this.controller});

  final ProfileControllerContract controller;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          // ── App Bar ──────────────────────────────────────────────────
          SliverAppBar(
            backgroundColor: colorScheme.surface,
            floating: true,
            snap: true,
            elevation: 0,
            scrolledUnderElevation: 0,
            titleSpacing: 0,
            automaticallyImplyLeading: false,
            title: Padding(
              padding: REdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Profile',
                    style: textTheme.headlineMedium?.copyWith(
                      fontFamily: 'BWGradual',
                    ),
                  ),
                  Text(
                    DateFormat('MMMM d, y').format(DateTime.now()),
                    style: textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: REdgeInsets.fromLTRB(20, 12, 20, 40),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // ── Avatar + user info ────────────────────────────────
                Center(
                  child: Column(
                    children: [
                      _ProfileAvatar(
                        initials: 'IA',
                        onEdit: controller.onEditAvatar,
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
                        'ismail.adamu@example.com',
                        style: textTheme.bodyMedium,
                      ),

                      SizedBox(height: 10.h),

                      // KYC badge + member since
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: controller.onKycTap,
                            child: Container(
                              padding: REdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.beigePink.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'BASIC KYC',
                                    style: textTheme.labelSmall?.copyWith(
                                      letterSpacing: 0.4,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 10.r,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(width: 8.w),

                          Text(
                            'Member since Jan 2026',
                            style: textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 32.h),

                // ── Menu sections ─────────────────────────────────────
                ...kProfileSections.map((section) => Padding(
                  padding: REdgeInsets.only(bottom: 20),
                  child: _ProfileMenuSectionWidget(
                    section: section,
                    onTap: controller.onMenuTap,
                  ),
                )),

                ListTile(
                  title: const Text('Dark mode'),
                  trailing: const ThemeToggle(),
                ),

                SizedBox(height: 8.h),

                // ── Logout button ─────────────────────────────────────
                GestureDetector(
                  onTap: controller.onLogout,
                  child: Container(
                    height: 52.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: colorScheme.error.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(
                        color: colorScheme.error.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.logout_rounded,
                          size: 18.r,
                          color: colorScheme.error,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Log Out',
                          style: textTheme.labelLarge?.copyWith(
                            color: colorScheme.error,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                // ── App version ───────────────────────────────────────
                Center(
                  child: Text(
                    'KIBA v1.0.0 · By Beige Africa',
                    style: textTheme.labelSmall?.copyWith(
                      letterSpacing: 0.5,
                    ),
                  ),
                ),

                SizedBox(height: 16.h),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}