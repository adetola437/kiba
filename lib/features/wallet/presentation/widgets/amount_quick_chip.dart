import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AmountQuickChip extends StatelessWidget {
  const AmountQuickChip({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: colorScheme.outline),
          ),
          child: Text(
            label,
            style: textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}