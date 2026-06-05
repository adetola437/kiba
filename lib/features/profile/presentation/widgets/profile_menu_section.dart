part of '../controllers/profile.dart';

class _ProfileMenuSectionWidget extends StatelessWidget {
  const _ProfileMenuSectionWidget({
    required this.section,
    required this.onTap,
  });

  final ProfileMenuSection section;
  final ValueChanged<ProfileMenuItem> onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section label
        Padding(
          padding: REdgeInsets.only(left: 4, bottom: 10),
          child: Text(
            section.title,
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.textDisabled,
              letterSpacing: 1.1,
              fontSize: 10.sp,
            ),
          ),
        ),

        // Items card
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: section.items.asMap().entries.map((entry) {
              final i = entry.key;
              final item = entry.value;
              final isLast = i == section.items.length - 1;

              return Column(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => onTap(item),
                      borderRadius: BorderRadius.vertical(
                        top: i == 0
                            ? Radius.circular(16.r)
                            : Radius.zero,
                        bottom: isLast
                            ? Radius.circular(16.r)
                            : Radius.zero,
                      ),
                      splashColor: AppColors.primary.withOpacity(0.04),
                      highlightColor: AppColors.primary.withOpacity(0.02),
                      child: Padding(
                        padding: REdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        child: Row(
                          children: [
                            // Icon container
                            Container(
                              width: 36.r,
                              height: 36.r,
                              decoration: BoxDecoration(
                                color: AppColors.surfaceVariant,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Icon(
                                item.icon,
                                size: 18.r,
                                color: AppColors.primary,
                              ),
                            ),

                            SizedBox(width: 14.w),

                            // Label
                            Expanded(
                              child: Text(
                                item.label,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),

                            // Chevron
                            Icon(
                              Icons.chevron_right_rounded,
                              size: 18.r,
                              color: AppColors.textDisabled,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (!isLast)
                    Divider(
                      height: 1,
                      color: AppColors.divider,
                      indent: 66.w,
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}