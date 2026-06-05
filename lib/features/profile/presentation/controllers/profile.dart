import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/contract.dart';
import '../../../../core/utils/enums.dart';
import '../widgets/profile_menu_data.dart';

part '../contracts/profile.dart';
part '../views/profile.dart';
part '../widgets/profile_avatar.dart';
part '../widgets/profile_menu_section.dart';

class ProfileScreen extends StatefulWidget {
  static const String route = 'profile';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    implements ProfileControllerContract {
  late final ProfileViewContract view;

  @override
  void initState() {
    super.initState();
    view = ProfileView(controller: this);
  }

  @override
  void onMenuTap(ProfileMenuItem item) {
    switch (item.route) {
      case ProfileMenuRoute.referAndEarn:
        context.pushNamed('refer_and_earn');
      case ProfileMenuRoute.promoCodes:
        context.pushNamed('promo_codes');
      case ProfileMenuRoute.personalInfo:
        context.pushNamed('personal_info');
      case ProfileMenuRoute.linkedBanks:
        context.pushNamed('linked_banks');
      case  ProfileMenuRoute.documents:
        context.pushNamed('documents');
      case ProfileMenuRoute.kyc:
        context.pushNamed('kyc');
      case ProfileMenuRoute.notifications:
        context.pushNamed('notification_settings');
      case ProfileMenuRoute.biometrics:
        context.pushNamed('biometrics');
      case ProfileMenuRoute.helpCenter:
        context.pushNamed('help_center');
      case ProfileMenuRoute.contactSupport:
        context.pushNamed('contact_support');
      case ProfileMenuRoute.about:
        context.pushNamed('about');
    }
  }

  @override
  void onEditAvatar() => context.pushNamed('edit_avatar');

  @override
  void onKycTap() => context.pushNamed('kyc');

  @override
  void onLogout() {
    showDialog(
      context: context,
      builder: (_) => _LogoutDialog(
        onConfirm: () {
          Navigator.of(context).pop();
          context.goNamed('splash');
        },
        onCancel: () => Navigator.of(context).pop(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => view.build(context);
}

// ── Logout confirmation dialog ─────────────────────────────────────────────────
class _LogoutDialog extends StatelessWidget {
  const _LogoutDialog({
    required this.onConfirm,
    required this.onCancel,
  });

  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: REdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              width: 56.r,
              height: 56.r,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.logout_rounded,
                size: 26.r,
                color: Colors.red,
              ),
            ),

            SizedBox(height: 16.h),

            Text(
              'Log Out',
              style: AppTextStyles.titleLarge.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),

            SizedBox(height: 8.h),

            Text(
              'Are you sure you want to log out\nof your KIBA account?',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),

            SizedBox(height: 24.h),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: onCancel,
                    child: Container(
                      height: 48.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        'Cancel',
                        style: AppTextStyles.labelLarge.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: GestureDetector(
                    onTap: onConfirm,
                    child: Container(
                      height: 48.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        'Log Out',
                        style: AppTextStyles.labelLarge.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}