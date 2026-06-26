import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AppBar(
      backgroundColor: backgroundColor ?? colorScheme.background,
      elevation: elevation,
      scrolledUnderElevation: scrolledUnderElevation,
      leading: showBackButton
          ? GestureDetector(
              onTap: onBackTap ?? () => context.pop(),
              child: Icon(
                Icons.arrow_back_rounded,
                size: 22.r,
                color: colorScheme.onSurface,
              ),
            )
          : null,
      title: Text(
        title,
        style: textTheme.titleLarge,
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}