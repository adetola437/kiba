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
    final colorScheme = Theme.of(context).colorScheme;
 
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section label
        Padding(
          padding: REdgeInsets.only(left: 4, bottom: 10),
          child: Text(
            section.title,
            style: AppTextStyles.labelSmall.copyWith(
              color: colorScheme.onSurfaceVariant.withOpacity(0.5),
              letterSpacing: 1.1,
              fontSize: 10.sp,
            ),
          ),
        ),
 
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: colorScheme.outline),
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
                        top: i == 0 ? Radius.circular(16.r) : Radius.zero,
                        bottom: isLast ? Radius.circular(16.r) : Radius.zero,
                      ),
                      splashColor: colorScheme.primary.withValues(alpha: 0.04),
                      highlightColor: colorScheme.primary.withValues(alpha: 0.02),
                      child: Padding(
                        padding: REdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 16,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 46.r,
                              height: 46.r,
                              decoration: BoxDecoration(
                                color: colorScheme.surfaceVariant,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Icon(
                                item.icon,
                                size: 22.r,
                                color: colorScheme.primary,
                              ),
                            ),
                            SizedBox(width: 18.w),
                            Expanded(
                              child: Text(
                                item.label,
                                style: AppTextStyles.titleMedium.copyWith(
                                  color: colorScheme.onSurface,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              size: 22.r,
                              color: colorScheme.onSurfaceVariant.withOpacity(0.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (!isLast)
                    Divider(
                      height: 1,
                      color: colorScheme.outline,
                      indent: 86.w,
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