// lib/features/home/presentation/widgets/stocks_quick_action_card.dart
//
// PLUG IN: In home_view.dart, find where the other quick action cards
// (Invest, Send, Fund, etc.) are rendered and add this widget alongside them.
//
// Example:
//   Row(
//     children: [
//       ExistingQuickActionCard(...),
//       StocksQuickActionCard(),   // <-- add here
//       ...
//     ],
//   )

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../stocks/presentation/controllers/stocks_controller.dart';

class StocksQuickActionCard extends StatelessWidget {
  const StocksQuickActionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => context.pushNamed(StocksScreen.route),
      child: Container(
        width: 100.w,
        padding: REdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer.withOpacity(0.15),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: colorScheme.primaryContainer.withOpacity(0.3),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36.r,
              height: 36.r,
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                Icons.show_chart_rounded,
                size: 18.r,
                color: colorScheme.primaryContainer,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Stocks',
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'Buy & sell\nNGX shares',
              style: textTheme.bodySmall?.copyWith(
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}