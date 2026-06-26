import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../beige_club_data.dart';
import 'beige_pending.dart';

class BeigeClubPaymentScreen extends StatefulWidget {
  static const String route = 'beige_club_payment';

  final double amount;
  final double projectedInterest;
  final double yearEndValue;
  final int daysToYearEnd;

  const BeigeClubPaymentScreen({
    super.key,
    required this.amount,
    required this.projectedInterest,
    required this.yearEndValue,
    required this.daysToYearEnd,
  });

  @override
  State<BeigeClubPaymentScreen> createState() =>
      _BeigeClubPaymentScreenState();
}

class _BeigeClubPaymentScreenState
    extends State<BeigeClubPaymentScreen> {
  bool _copied = false;
  PaymentProofStatus _proofStatus = PaymentProofStatus.notUploaded;
  String? _proofFileName;
  bool _isSubmitting = false;

  String _fmt(double v) =>
      '₦${NumberFormat('#,##0.00', 'en_US').format(v)}';

  String get _reference =>
      'Ismail Adamu - Beige Club Contribution';

  void _onCopyAccount() {
    Clipboard.setData(
        const ClipboardData(text: kAccountNumber));
    setState(() => _copied = true);
    Future.delayed(const Duration(seconds: 2),
        () { if (mounted) setState(() => _copied = false); });
  }

  void _onCopyReference() {
    Clipboard.setData(ClipboardData(text: _reference));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Reference copied!',
          style: AppTextStyles.bodySmall.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _onUploadProof() async {
    // Simulate file picker + upload
    setState(() => _proofStatus = PaymentProofStatus.uploading);
    await Future.delayed(const Duration(milliseconds: 1800));
    if (!mounted) return;
    setState(() {
      _proofStatus = PaymentProofStatus.uploaded;
      _proofFileName = 'payment_proof.pdf';
    });
  }

  void _onRemoveProof() => setState(() {
        _proofStatus = PaymentProofStatus.notUploaded;
        _proofFileName = null;
      });

  Future<void> _onSubmit() async {
    if (_proofStatus != PaymentProofStatus.uploaded || _isSubmitting)
      return;
    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(milliseconds: 2000));
    if (!mounted) return;
    setState(() => _isSubmitting = false);
    context.goNamed(
      BeigeClubPendingScreen.route,
      extra: {
        'amount': widget.amount,
        'yearEndValue': widget.yearEndValue,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        Scaffold(
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
              'Payment Details',
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
                      // ── Contribution summary ─────────────────
                      Container(
                        padding: REdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Your Contribution',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: colorScheme.onPrimary
                                        .withValues(alpha: 0.6),
                                  ),
                                ),
                                Text(
                                  _fmt(widget.amount),
                                  style: AppTextStyles.titleLarge.copyWith(
                                    color: colorScheme.onPrimary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Divider(
                              color: colorScheme.onPrimary
                                  .withValues(alpha: 0.1),
                              height: 1,
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Pro-Rated Interest',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: colorScheme.onPrimary
                                        .withValues(alpha: 0.6),
                                  ),
                                ),
                                Text(
                                  '+${_fmt(widget.projectedInterest)}',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: colorScheme.primaryContainer,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Year-End Value (Dec 31)',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: colorScheme.onPrimary
                                        .withValues(alpha: 0.6),
                                  ),
                                ),
                                Text(
                                  _fmt(widget.yearEndValue),
                                  style: AppTextStyles.titleSmall.copyWith(
                                    color: colorScheme.onPrimary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 24.h),

                      // ── Step 1: Transfer ─────────────────────
                      _StepHeader(step: '1', title: 'Make Bank Transfer'),
                      SizedBox(height: 14.h),

                      Text(
                        'Transfer exactly ${_fmt(widget.amount)} to the account below. Use your name as the reference.',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          height: 1.5,
                        ),
                      ),

                      SizedBox(height: 14.h),

                      // Bank details card
                      Container(
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(color: colorScheme.outline),
                        ),
                        child: Column(
                          children: [
                            // Bank name header
                            Container(
                              padding: REdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: colorScheme.surfaceVariant,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16.r)),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.account_balance_outlined,
                                    size: 16.r,
                                    color: colorScheme.primary,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    kBankName,
                                    style: AppTextStyles.titleSmall.copyWith(
                                      color: colorScheme.onSurface,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: REdgeInsets.all(16),
                              child: Column(
                                children: [
                                  _BankRow(
                                      label: 'Account Name',
                                      value: kAccountName),
                                  Divider(
                                    height: 1,
                                    color: colorScheme.outline,
                                  ),

                                  // Account number with copy
                                  Padding(
                                    padding: REdgeInsets.symmetric(
                                        vertical: 14),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Account Number',
                                              style: AppTextStyles.bodySmall
                                                  .copyWith(
                                                color: colorScheme
                                                    .onSurfaceVariant,
                                              ),
                                            ),
                                            SizedBox(height: 4.h),
                                            Text(
                                              kAccountNumber,
                                              style: AppTextStyles.titleLarge
                                                  .copyWith(
                                                color: colorScheme.onSurface,
                                                fontWeight: FontWeight.w700,
                                                letterSpacing: 1.5,
                                              ),
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: _onCopyAccount,
                                          child: AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 200),
                                            padding: REdgeInsets.symmetric(
                                                horizontal: 14,
                                                vertical: 8),
                                            decoration: BoxDecoration(
                                              color: _copied
                                                  ? colorScheme.primaryContainer
                                                      .withValues(alpha: 0.2)
                                                  : colorScheme.surfaceVariant,
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  _copied
                                                      ? Icons.check_rounded
                                                      : Icons.copy_rounded,
                                                  size: 14.r,
                                                  color: _copied
                                                      ? colorScheme.primary
                                                      : colorScheme
                                                          .onSurfaceVariant,
                                                ),
                                                SizedBox(width: 4.w),
                                                Text(
                                                  _copied ? 'Copied!' : 'Copy',
                                                  style: AppTextStyles
                                                      .labelSmall
                                                      .copyWith(
                                                    color: _copied
                                                        ? colorScheme.primary
                                                        : colorScheme
                                                            .onSurfaceVariant,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Divider(
                                    height: 1,
                                    color: colorScheme.outline,
                                  ),

                                  // Reference row
                                  Padding(
                                    padding: REdgeInsets.symmetric(
                                        vertical: 14),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Reference',
                                                style: AppTextStyles.bodySmall
                                                    .copyWith(
                                                  color: colorScheme
                                                      .onSurfaceVariant,
                                                ),
                                              ),
                                              SizedBox(height: 4.h),
                                              Text(
                                                _reference,
                                                style: AppTextStyles.bodyMedium
                                                    .copyWith(
                                                  color: colorScheme.onSurface,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: _onCopyReference,
                                          child: Container(
                                            padding: REdgeInsets.symmetric(
                                                horizontal: 14,
                                                vertical: 8),
                                            decoration: BoxDecoration(
                                              color: colorScheme.surfaceVariant,
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.copy_rounded,
                                                  size: 14.r,
                                                  color: colorScheme
                                                      .onSurfaceVariant,
                                                ),
                                                SizedBox(width: 4.w),
                                                Text(
                                                  'Copy',
                                                  style: AppTextStyles
                                                      .labelSmall
                                                      .copyWith(
                                                    color: colorScheme
                                                        .onSurfaceVariant,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Amount to transfer
                                  Container(
                                    width: double.infinity,
                                    padding: REdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: colorScheme.primary
                                          .withValues(alpha: 0.06),
                                      borderRadius:
                                          BorderRadius.circular(8.r),
                                      border: Border.all(
                                        color: colorScheme.primary
                                            .withValues(alpha: 0.15),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Transfer exactly ',
                                          style: AppTextStyles.bodySmall
                                              .copyWith(
                                            color: colorScheme
                                                .onSurfaceVariant,
                                          ),
                                        ),
                                        Text(
                                          _fmt(widget.amount),
                                          style: AppTextStyles.titleSmall
                                              .copyWith(
                                            color: colorScheme.primary,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 28.h),

                      // ── Step 2: Upload proof ─────────────────
                      _StepHeader(
                          step: '2',
                          title: 'Upload Payment Proof'),
                      SizedBox(height: 8.h),
                      Text(
                        'Upload your bank transfer receipt or screenshot.',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      SizedBox(height: 14.h),

                      _UploadBox(
                        status: _proofStatus,
                        fileName: _proofFileName,
                        onUpload: _onUploadProof,
                        onRemove: _onRemoveProof,
                      ),

                      SizedBox(height: 20.h),

                      // Note
                      Container(
                        padding: REdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: colorScheme.secondaryContainer
                              .withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: colorScheme.secondary
                                .withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.schedule_rounded,
                              size: 14.r,
                              color: colorScheme.onSecondaryContainer,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                'Our compliance team typically verifies payment within 24–48 business hours. You will receive a confirmation once verified.',
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: colorScheme.onSecondaryContainer,
                                  height: 1.5,
                                ),
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

              // ── CTA ────────────────────────────────────────────
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
                  opacity: _proofStatus ==
                          PaymentProofStatus.uploaded
                      ? 1.0
                      : 0.45,
                  child: GestureDetector(
                    onTap: _proofStatus ==
                            PaymentProofStatus.uploaded
                        ? _onSubmit
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
                            'Submit for Verification',
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
        ),

        // Loading overlay
        if (_isSubmitting)
          Container(
            color: Colors.black.withValues(alpha: 0.55),
            child: Center(
              child: Container(
                width: 220.w,
                padding: REdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 40.r,
                      height: 40.r,
                      child: CircularProgressIndicator(
                        color: colorScheme.primary,
                        strokeWidth: 3,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Submitting...',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.titleSmall.copyWith(
                        color: colorScheme.onSurface,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Please wait',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.38),
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
}

// ── Step header ────────────────────────────────────────────────────────────────
class _StepHeader extends StatelessWidget {
  const _StepHeader({required this.step, required this.title});

  final String step;
  final String title;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Container(
          width: 26.r,
          height: 26.r,
          decoration: BoxDecoration(
            color: colorScheme.primary,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              step,
              style: AppTextStyles.labelSmall.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Text(
          title,
          style: AppTextStyles.titleMedium.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}

// ── Bank detail row ────────────────────────────────────────────────────────────
class _BankRow extends StatelessWidget {
  const _BankRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: REdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: AppTextStyles.bodySmall.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Upload box ─────────────────────────────────────────────────────────────────
class _UploadBox extends StatelessWidget {
  const _UploadBox({
    required this.status,
    required this.fileName,
    required this.onUpload,
    required this.onRemove,
  });

  final PaymentProofStatus status;
  final String? fileName;
  final VoidCallback onUpload;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (status == PaymentProofStatus.uploading) {
      return Container(
        height: 80.h,
        decoration: BoxDecoration(
          color: colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: colorScheme.primary.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 24.r,
              height: 24.r,
              child: CircularProgressIndicator(
                color: colorScheme.primary,
                strokeWidth: 2.5,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Uploading...',
              style: AppTextStyles.bodySmall.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    if (status == PaymentProofStatus.uploaded) {
      return Container(
        padding: REdgeInsets.all(14),
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: colorScheme.primaryContainer.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.insert_drive_file_outlined,
              size: 20.r,
              color: colorScheme.primary,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fileName ?? 'proof.pdf',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Uploaded successfully',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: onRemove,
              child: Icon(
                Icons.close_rounded,
                size: 18.r,
                color: colorScheme.onSurface.withValues(alpha: 0.38),
              ),
            ),
          ],
        ),
      );
    }

    // Empty state
    return GestureDetector(
      onTap: onUpload,
      child: Container(
        width: double.infinity,
        height: 100.h,
        decoration: BoxDecoration(
          color: colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: colorScheme.outline,
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_upload_outlined,
              size: 28.r,
              color: colorScheme.primary.withValues(alpha: 0.5),
            ),
            SizedBox(height: 8.h),
            Text(
              'Tap to upload receipt',
              style: AppTextStyles.bodyMedium.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              'PDF, JPG or PNG — Max 5MB',
              style: AppTextStyles.bodySmall.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.38),
              ),
            ),
          ],
        ),
      ),
    );
  }
}