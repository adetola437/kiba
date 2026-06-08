import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.onBackTap,
    this.showBackButton = true,
    this.backgroundColor,
    this.elevation = 0,
    this.scrolledUnderElevation = 0,
  });

  final String title;
  final VoidCallback? onBackTap;
  final bool showBackButton;
  final Color? backgroundColor;
  final double elevation;
  final double scrolledUnderElevation;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? AppColors.background,
      elevation: elevation,
      scrolledUnderElevation: scrolledUnderElevation,
      leading: showBackButton
          ? GestureDetector(
              onTap: onBackTap ?? () => context.pop(),
              child: Icon(
                Icons.arrow_back_rounded,
                size: 22.r,
                color: AppColors.textPrimary,
              ),
            )
          : null,
      title: Text(
        title,
        style: AppTextStyles.titleLarge.copyWith(
          color: AppColors.textPrimary,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}