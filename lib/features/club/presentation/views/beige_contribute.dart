import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../beige_club_data.dart';
import 'beige_payment.dart';

class BeigeClubContributeScreen extends StatefulWidget {
  static const String route = 'beige_club_contribute';
  const BeigeClubContributeScreen({super.key});

  @override
  State<BeigeClubContributeScreen> createState() =>
      _BeigeClubContributeScreenState();
}

class _BeigeClubContributeScreenState
    extends State<BeigeClubContributeScreen> {
  final _amountController = TextEditingController(text: '50,000');
  double _amount = 50000;

  static const _quickAmounts = [50000.0, 100000.0, 250000.0, 500000.0, 1000000.0];

  String _fmt(double v) =>
      '₦${NumberFormat('#,##0.00', 'en_US').format(v)}';

  String _fmtShort(double v) {
    if (v >= 1000000) return '₦${(v / 1000000).toStringAsFixed(0)}M';
    if (v >= 1000) return '₦${(v / 1000).toStringAsFixed(0)}K';
    return '₦${v.toStringAsFixed(0)}';
  }

  double get _proRataInterest =>
      calculateProRataInterest(_amount, DateTime.now());

  double get _yearEndValue => _amount + _proRataInterest;

  int get _daysToYearEnd =>
      DateTime(DateTime.now().year, 12, 31)
          .difference(DateTime.now())
          .inDays;

  bool get _canProceed => _amount >= kBeigeClubMinContribution;

  void _onAmountChanged(String value) {
    final clean = value.replaceAll(',', '');
    final parsed = double.tryParse(clean) ?? 0;
    setState(() => _amount = parsed);
  }

  void _onQuickAmount(double amount) {
    setState(() {
      _amount = amount;
      _amountController.text =
          NumberFormat('#,##0', 'en_US').format(amount);
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: colorScheme.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Icon(
            Icons.arrow_back_rounded,
            size: 22.r,
            color: colorScheme.onBackground,
          ),
        ),
        title: Text(
          'Make a Contribution',
          style: AppTextStyles.titleLarge.copyWith(
            color: colorScheme.onBackground,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: REdgeInsets.fromLTRB(20, 16, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Info banner ────────────────────────────────
                  Container(
                    padding: REdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer
                          .withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: colorScheme.primaryContainer
                            .withValues(alpha: 0.25),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          size: 14.r,
                          color: colorScheme.primary,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            'Your contribution will earn 19% p.a. pro-rated from today to December 31.',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: colorScheme.primary,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // ── Amount input ───────────────────────────────
                  Text(
                    'Enter Amount',
                    style: AppTextStyles.headlineSmall.copyWith(
                      color: colorScheme.onBackground,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Minimum contribution is ₦50,000.',
                    style: AppTextStyles.bodySmall
                        .copyWith(color: colorScheme.onSurfaceVariant),
                  ),

                  SizedBox(height: 14.h),

                  Container(
                    padding: REdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(
                        color: _amount > 0
                            ? colorScheme.primary.withValues(alpha: 0.35)
                            : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CONTRIBUTION AMOUNT',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: colorScheme.onSurface
                                .withValues(alpha: 0.38),
                            letterSpacing: 0.8,
                            fontSize: 9.sp,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Row(
                          children: [
                            Text(
                              '₦',
                              style: AppTextStyles.displaySmall.copyWith(
                                color: colorScheme.onSurface,
                                fontWeight: FontWeight.w300,
                                fontSize: 28.sp,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: TextField(
                                controller: _amountController,
                                onChanged: _onAmountChanged,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                style: AppTextStyles.displaySmall.copyWith(
                                  color: colorScheme.onSurface,
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                  hintText: '0',
                                  hintStyle: AppTextStyles.displaySmall
                                      .copyWith(
                                    color: colorScheme.onSurface
                                        .withValues(alpha: 0.38),
                                    fontSize: 28.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  if (_amount > 0 && _amount < kBeigeClubMinContribution) ...[
                    SizedBox(height: 6.h),
                    Row(children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        size: 13.r,
                        color: colorScheme.error,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'Minimum contribution is ₦50,000.',
                        style: AppTextStyles.bodySmall
                            .copyWith(color: colorScheme.error),
                      ),
                    ]),
                  ],

                  SizedBox(height: 12.h),

                  // Quick amounts
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _quickAmounts.map((amount) {
                        final isSelected = _amount == amount;
                        return Padding(
                          padding: REdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: () => _onQuickAmount(amount),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: REdgeInsets.symmetric(
                                  horizontal: 14, vertical: 8),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? colorScheme.primary
                                        .withValues(alpha: 0.08)
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
                                _fmtShort(amount),
                                style: AppTextStyles.labelSmall.copyWith(
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
                        );
                      }).toList(),
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // ── Live projection ────────────────────────────
                  if (_canProceed)
                    Container(
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                REdgeInsets.fromLTRB(18, 16, 18, 14),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.bar_chart_rounded,
                                  size: 18.r,
                                  color: colorScheme.primaryContainer,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Your Projection',
                                  style: AppTextStyles.titleSmall.copyWith(
                                    color: colorScheme.onPrimary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: colorScheme.onPrimary
                                .withValues(alpha: 0.1),
                            height: 1,
                          ),
                          Padding(
                            padding: REdgeInsets.all(18),
                            child: Column(
                              children: [
                                _ProjRow(
                                  label: 'Contribution',
                                  value: _fmt(_amount),
                                ),
                                SizedBox(height: 10.h),
                                _ProjRow(
                                  label: 'Rate',
                                  value: '${kBeigeClubRate}% p.a.',
                                  valueColor: colorScheme.primaryContainer,
                                ),
                                SizedBox(height: 10.h),
                                _ProjRow(
                                  label: 'Days to Dec 31',
                                  value: '$_daysToYearEnd days',
                                ),
                                SizedBox(height: 10.h),
                                _ProjRow(
                                  label: 'Pro-Rated Interest',
                                  value: '+${_fmt(_proRataInterest)}',
                                  valueColor: colorScheme.primaryContainer,
                                ),
                                SizedBox(height: 14.h),
                                Divider(
                                  color: colorScheme.onPrimary
                                      .withValues(alpha: 0.15),
                                  height: 1,
                                ),
                                SizedBox(height: 14.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Year-End Value (Dec 31)',
                                      style: AppTextStyles.titleSmall
                                          .copyWith(
                                        color: colorScheme.onPrimary,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      _fmt(_yearEndValue),
                                      style: AppTextStyles.titleMedium
                                          .copyWith(
                                        color: colorScheme.onPrimary,
                                        fontWeight:FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),

          // ── CTA ──────────────────────────────────────────────────
          Container(
            padding: REdgeInsets.fromLTRB(20, 12, 20, 32),
            decoration: BoxDecoration(
              color: colorScheme.background,
              border: Border(
                top: BorderSide(color: colorScheme.outline),
              ),
            ),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: _canProceed ? 1.0 : 0.45,
              child: GestureDetector(
                onTap: _canProceed
                    ? () => context.pushNamed(
                          BeigeClubPaymentScreen.route,
                          extra: {
                            'amount': _amount,
                            'projectedInterest': _proRataInterest,
                            'yearEndValue': _yearEndValue,
                            'daysToYearEnd': _daysToYearEnd,
                          },
                        )
                    : null,
                child: Container(
                  width: double.infinity,
                  height: 56.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Proceed to Payment',
                        style: AppTextStyles.labelLarge.copyWith(
                          color: colorScheme.onPrimary,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 18.r,
                        color: colorScheme.onPrimary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjRow extends StatelessWidget {
  const _ProjRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: colorScheme.onPrimary.withValues(alpha: 0.55),
          ),
        ),
        Text(
          value,
          style: AppTextStyles.bodySmall.copyWith(
            color: valueColor ?? colorScheme.onPrimary.withValues(alpha: 0.85),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}