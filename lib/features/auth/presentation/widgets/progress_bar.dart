
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 
import '../../../../core/theme/app_colors.dart';
 
/// Shared progress bar used across all registration steps.
/// [currentStep] is 1-based. [totalSteps] defaults to 3.
class RegistrationProgressBar extends StatelessWidget {
  const RegistrationProgressBar({
    super.key,
    required this.currentStep,
    this.totalSteps = 3,
  });
 
  final int currentStep;
  final int totalSteps;
 
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps, (i) {
        final isActive = i < currentStep;
        return Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            margin: EdgeInsets.only(right: i < totalSteps - 1 ? 8.w : 0),
            height: 4.h,
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.primary
                  : AppColors.primary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
        );
      }),
    );
  }
}
 