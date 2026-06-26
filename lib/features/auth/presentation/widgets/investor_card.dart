part of '../controllers/register_step1_controller.dart';

class _InvestorTypeCard extends StatelessWidget {
  const _InvestorTypeCard({
    required this.type,
    required this.isSelected,
    required this.onTap,
  });

  final InvestorType type;
  final bool isSelected;
  final VoidCallback onTap;

  String get _title =>
      type == InvestorType.individual ? 'Individual' : 'Corporate';

  String get _description => type == InvestorType.individual
      ? 'Invest as a single person, managing your own portfolio and wealth goals.'
      : 'Invest on behalf of a registered business, trust, or organization.';

  IconData get _icon => type == InvestorType.individual
      ? Icons.person_rounded
      : Icons.business_rounded;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: isSelected ? colorScheme.primary : colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isSelected ? colorScheme.primary : colorScheme.outline,
          width: isSelected ? 2 : 1.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          splashColor: colorScheme.primary.withValues(alpha: 0.06),
          highlightColor: colorScheme.primary.withValues(alpha: 0.04),
          child: Padding(
            padding: REdgeInsets.all(22),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Icon badge ───────────────────────────────────────
                Container(
                  width: 48.r,
                  height: 48.r,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? colorScheme.onPrimary.withValues(alpha: 0.15)
                        : colorScheme.surfaceVariant,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _icon,
                    size: 22.r,
                    color: isSelected
                        ? colorScheme.onPrimary
                        : colorScheme.primary,
                  ),
                ),

                SizedBox(width: 16.w),

                // ── Text content ─────────────────────────────────────
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 2.h),
                      Text(
                        _title,
                        style: AppTextStyles.titleLarge.copyWith(
                          color: isSelected
                              ? colorScheme.onPrimary
                              : colorScheme.onSurface,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        _description,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: isSelected
                              ? colorScheme.onPrimary.withValues(alpha: 0.75)
                              : colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Selection indicator ──────────────────────────────
                SizedBox(width: 12.w),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  width: 22.r,
                  height: 22.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? colorScheme.onPrimary
                        : Colors.transparent,
                    border: Border.all(
                      color: isSelected
                          ? colorScheme.onPrimary
                          : colorScheme.outline,
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? Icon(
                          Icons.check_rounded,
                          size: 13.r,
                          color: colorScheme.primary,
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}