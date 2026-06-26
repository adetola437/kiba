part of '../controllers/profile.dart';

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({
    required this.initials,
    required this.onEdit,
  });

  final String initials;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Main circle
        Container(
          width: 80.r,
          height: 80.r,
          decoration: BoxDecoration(
            color: colorScheme.primary,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              initials,
              style: textTheme.headlineSmall?.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),

        // Tier badge — bottom left
        Positioned(
          bottom: 0,
          left: -4.r,
          child: Container(
            padding: REdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.limeGreen,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: colorScheme.surface, width: 1.5),
            ),
            child: Text(
              'T1',
              style: textTheme.labelSmall?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w700,
                fontSize: 9.sp,
              ),
            ),
          ),
        ),

        // Edit button — bottom right
        Positioned(
          bottom: 0,
          right: -4.r,
          child: GestureDetector(
            onTap: onEdit,
            child: Container(
              width: 26.r,
              height: 26.r,
              decoration: BoxDecoration(
                color: colorScheme.surface,
                shape: BoxShape.circle,
                border: Border.all(color: colorScheme.outline, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.shadow.withOpacity(0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.camera_alt_outlined,
                size: 13.r,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
      ],
    );
  }
}