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
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Main circle
        Container(
          width: 80.r,
          height: 80.r,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              initials,
              style: AppTextStyles.headlineSmall.copyWith(
                color: AppColors.white,
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
              border: Border.all(color: AppColors.white, width: 1.5),
            ),
            child: Text(
              'T1',
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.primary,
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
                color: AppColors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.border, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.camera_alt_outlined,
                size: 13.r,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}