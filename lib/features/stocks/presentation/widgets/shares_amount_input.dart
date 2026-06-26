part of '../controllers/stock_order_controller.dart';

const _kQuickShares = <double>[1, 5, 10, 50];

class _SharesAmountInput extends StatelessWidget {
  final StockOrderControllerContract controller;
  const _SharesAmountInput({required this.controller});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        // Shares number field
        TextFormField(
          onChanged: controller.onSharesChanged,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: textTheme.displaySmall?.copyWith(
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
          ),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide(
                color: colorScheme.primary.withOpacity(0.25),
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
            ),
            hintText: '0',
            hintStyle: textTheme.displaySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontSize: 28.sp,
            ),
            suffixText: 'shares',
            suffixStyle: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            contentPadding:
                REdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),

        SizedBox(height: 12.h),

        // Quick share count chips
        Row(
          children: _kQuickShares.map((qty) {
            final isSelected = controller.sharesCount == qty;
            return Expanded(
              child: Padding(
                padding: REdgeInsets.only(
                    right: qty != _kQuickShares.last ? 8.w : 0),
                child: GestureDetector(
                  onTap: () =>
                      controller.onSharesChanged(qty.toInt().toString()),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 34.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? colorScheme.primary.withOpacity(0.08)
                          : colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: isSelected
                            ? colorScheme.primary
                            : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      '${qty.toInt()} sh',
                      style: textTheme.labelSmall?.copyWith(
                        color: isSelected
                            ? colorScheme.primary
                            : colorScheme.onSurfaceVariant,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}