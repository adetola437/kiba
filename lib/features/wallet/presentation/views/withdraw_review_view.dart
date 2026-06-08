part of '../controllers/withdraw_review_controller.dart';

class WithdrawReviewView extends StatelessWidget
    implements WithdrawReviewViewContract {
  const WithdrawReviewView({super.key, required this.controller});

  final WithdrawReviewControllerContract controller;

  String _fmt(double v) => '₦${NumberFormat('#,##0.00', 'en_US').format(v)}';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            scrolledUnderElevation: 0,
            centerTitle: true,
            leading: GestureDetector(
              onTap: () => context.pop(),
              child: Container(
                margin: REdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.border),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 16.r,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            title: Text(
              'Review Withdrawal',
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: REdgeInsets.fromLTRB(20, 20, 20, 32),
                  child: Column(
                    children: [
                      // ── Amount hero card ────────────────────────────
                      Container(
                        width: double.infinity,
                        padding: REdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceVariant,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Column(
                          children: [
                            // Icon
                            Container(
                              width: 60.r,
                              height: 60.r,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.account_balance_wallet_rounded,
                                size: 28.r,
                                color: AppColors.white,
                              ),
                            ),
                            SizedBox(height: 14.h),
                            Text(
                              'WITHDRAWAL AMOUNT',
                              style: AppTextStyles.labelSmall.copyWith(
                                color: AppColors.textSecondary,
                                letterSpacing: 1.2,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              _fmt(controller.amount),
                              style: TextStyle(
                                fontFamily: 'EuclidCircularA',
                                fontSize: 32.sp,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // ── Summary breakdown ───────────────────────────
                      Container(
                        padding: REdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          children: [
                            _WithdrawSummaryRow(
                              label: 'Amount to Withdraw',
                              value: _fmt(controller.amount),
                            ),
                            _divider(),
                            _WithdrawSummaryRow(
                              label: 'Destination',
                              value: controller.account.bankName,
                              subValue:
                                  controller.account.maskedNumber,
                            ),
                            _divider(),
                            _WithdrawSummaryRow(
                              label: 'Transaction Fee',
                              value: _fmt(controller.fee),
                              valueColor: AppColors.textSecondary,
                            ),
                            _divider(),
                            _WithdrawSummaryRow(
                              label: 'Total to Receive',
                              value: _fmt(controller.totalToReceive),
                              isBold: true,
                              valueLarge: true,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // ── Security notice ────────────────────────────
                      Container(
                        padding: REdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.beigePink.withOpacity(0.35),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: AppColors.beigePink),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.shield_rounded,
                              size: 16.r,
                              color: AppColors.primary,
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Text(
                                'Your transaction is secured with 256-bit encryption for your safety.',
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.primary,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // ── Terms note ─────────────────────────────────
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.5,
                          ),
                          children: [
                            const TextSpan(
                                text: 'By confirming, you agree to our '),
                            TextSpan(
                              text: 'withdrawal terms and conditions.',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Bottom CTA ─────────────────────────────────────────
              Container(
                padding: REdgeInsets.fromLTRB(20, 12, 20, 32),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  border:
                      Border(top: BorderSide(color: AppColors.divider)),
                ),
                child: GestureDetector(
                  onTap: controller.onConfirm,
                  child: Container(
                    width: double.infinity,
                    height: 56.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Confirm Withdrawal',
                          style: AppTextStyles.labelLarge.copyWith(
                            color: AppColors.white,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 18.r,
                          color: AppColors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // ── Full-screen loading overlay ─────────────────────────────
        if (controller.isLoading)
          Container(
            color: Colors.black.withOpacity(0.55),
            child: Center(
              child: Container(
                width: 220.w,
                padding: REdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 40.r,
                      height: 40.r,
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                        strokeWidth: 3,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Processing your\nwithdrawal...',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.titleSmall.copyWith(
                        color: AppColors.textPrimary,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Please do not close the app',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textDisabled,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _divider() => Padding(
        padding: REdgeInsets.symmetric(vertical: 12),
        child: Divider(color: AppColors.divider, height: 1),
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// PIN Bottom Sheet
// ─────────────────────────────────────────────────────────────────────────────

class _WithdrawPinSheet extends StatefulWidget {
  const _WithdrawPinSheet({required this.onPinConfirmed});
  final VoidCallback onPinConfirmed;

  @override
  State<_WithdrawPinSheet> createState() => _WithdrawPinSheetState();
}

class _WithdrawPinSheetState extends State<_WithdrawPinSheet> {
  final List<String> _digits = [];
  static const int _pinLength = 4;
  bool _hasError = false;

  void _onDigit(String d) {
    if (_digits.length >= _pinLength) return;
    setState(() {
      _digits.add(d);
      _hasError = false;
    });
    if (_digits.length == _pinLength) _validate();
  }

  void _onDelete() {
    if (_digits.isEmpty) return;
    setState(() => _digits.removeLast());
  }

  void _validate() {
    // TODO: validate PIN against secure storage / API
    // Simulate correct PIN = 1234 for now
    final pin = _digits.join();
    if (pin == '1234') {
      Navigator.pop(context);
      widget.onPinConfirmed();
    } else {
      setState(() {
        _digits.clear();
        _hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: REdgeInsets.fromLTRB(24, 12, 24, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          SizedBox(height: 24.h),

          // Lock icon
          Container(
            width: 56.r,
            height: 56.r,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.lock_rounded,
              size: 26.r,
              color: AppColors.white,
            ),
          ),

          SizedBox(height: 16.h),

          Text(
            'Enter your PIN',
            style: AppTextStyles.headlineSmall.copyWith(
              fontFamily: 'BWGradual',
              color: AppColors.textPrimary,
            ),
          ),

          SizedBox(height: 6.h),

          Text(
            'Confirm your identity to complete\nthis withdrawal',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),

          SizedBox(height: 28.h),

          // PIN dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_pinLength, (i) {
              final filled = i < _digits.length;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: REdgeInsets.symmetric(horizontal: 10),
                width: 16.r,
                height: 16.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _hasError
                      ? AppColors.error
                      : filled
                          ? AppColors.primary
                          : Colors.transparent,
                  border: Border.all(
                    color: _hasError
                        ? AppColors.error
                        : filled
                            ? AppColors.primary
                            : AppColors.border,
                    width: 2,
                  ),
                ),
              );
            }),
          ),

          if (_hasError) ...[
            SizedBox(height: 10.h),
            Text(
              'Incorrect PIN. Please try again.',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.error,
              ),
            ),
          ],

          SizedBox(height: 32.h),

          // Numpad
          _Numpad(onDigit: _onDigit, onDelete: _onDelete),
        ],
      ),
    );
  }
}

// ── Numpad ─────────────────────────────────────────────────────────────────────
class _Numpad extends StatelessWidget {
  const _Numpad({required this.onDigit, required this.onDelete});
  final void Function(String) onDigit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final rows = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['', '0', 'del'],
    ];

    return Column(
      children: rows.map((row) {
        return Padding(
          padding: REdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: row.map((key) {
              if (key.isEmpty) return SizedBox(width: 80.w);
              return Padding(
                padding: REdgeInsets.symmetric(horizontal: 14),
                child: GestureDetector(
                  onTap: key == 'del' ? onDelete : () => onDigit(key),
                  child: Container(
                    width: 72.r,
                    height: 72.r,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.surfaceVariant,
                    ),
                    child: key == 'del'
                        ? Icon(
                            Icons.backspace_outlined,
                            size: 22.r,
                            color: AppColors.textPrimary,
                          )
                        : Text(
                            key,
                            style: TextStyle(
                              fontFamily: 'EuclidCircularA',
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}
