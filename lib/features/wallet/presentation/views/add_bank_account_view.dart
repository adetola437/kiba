part of '../controllers/add_bank_account_controller.dart';

class AddBankAccountView extends StatelessWidget
    implements AddBankAccountViewContract {
  const AddBankAccountView({super.key, required this.controller});

  final AddBankAccountControllerContract controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Add Bank Account',
          style: AppTextStyles.titleMedium.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: REdgeInsets.fromLTRB(20, 24, 20, 32),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Link a bank account',
                      style: AppTextStyles.headlineSmall.copyWith(
                        fontFamily: 'BWGradual',
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Your account will be verified instantly via NIBSS.',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),

                    SizedBox(height: 28.h),

                    // ── Select Bank dropdown ─────────────────────────
                    _FieldLabel('Bank Name'),
                    SizedBox(height: 8.h),
                    ValueListenableBuilder<String?>(
                      valueListenable: controller.selectedBank,
                      builder: (context, selected, _) {
                        return DropdownButtonFormField<String>(
                          value: selected,
                          decoration: _inputDecoration(
                            hintText: 'Select your bank',
                            prefixIcon: Icons.account_balance_outlined,
                          ),
                          items: controller.banks
                              .map(
                                (b) => DropdownMenuItem(
                                  value: b,
                                  child: Text(
                                    b,
                                    style: AppTextStyles.bodyMedium,
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: controller.onBankSelected,
                          validator: (v) =>
                              v == null ? 'Please select a bank' : null,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: AppColors.textSecondary,
                          ),
                          dropdownColor: AppColors.surface,
                          borderRadius: BorderRadius.circular(12.r),
                        );
                      },
                    ),

                    SizedBox(height: 20.h),

                    // ── Account Number ──────────────────────────────
                    _FieldLabel('Account Number'),
                    SizedBox(height: 8.h),
                    TextFormField(
                      controller: controller.accountNumberCtrl,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontFamily: 'EuclidCircularA',
                        letterSpacing: 1.5,
                      ),
                      decoration: _inputDecoration(
                        hintText: '0000000000',
                        prefixIcon: Icons.pin_outlined,
                        counterText: '',
                      ),
                      validator: (v) => (v == null || v.length < 10)
                          ? 'Enter a valid 10-digit account number'
                          : null,
                    ),

                    SizedBox(height: 16.h),

                    // ── Resolved account name ────────────────────────
                    ValueListenableBuilder<bool>(
                      valueListenable: controller.isResolving,
                      builder: (context, resolving, _) {
                        return ValueListenableBuilder<String?>(
                          valueListenable: controller.resolvedAccountName,
                          builder: (context, name, _) {
                            if (resolving) {
                              return Container(
                                padding: REdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: AppColors.surfaceVariant,
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 16.r,
                                      height: 16.r,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                    Text(
                                      'Verifying account...',
                                      style: AppTextStyles.bodySmall.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }

                            if (name != null) {
                              return Container(
                                padding: REdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: AppColors.limeGreen.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: AppColors.limeGreen,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle_rounded,
                                      size: 18.r,
                                      color: AppColors.primary,
                                    ),
                                    SizedBox(width: 10.w),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Account verified',
                                          style:
                                              AppTextStyles.labelSmall.copyWith(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          name,
                                          style:
                                              AppTextStyles.bodyMedium.copyWith(
                                            color: AppColors.textPrimary,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }

                            return const SizedBox.shrink();
                          },
                        );
                      },
                    ),

                    SizedBox(height: 24.h),

                    // ── NIBSS notice ─────────────────────────────────
                    Container(
                      padding: REdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.cloudyBlue,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            size: 16.r,
                            color: AppColors.moodyBlue,
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Text(
                              'We use NIBSS to instantly verify your account details. Only accounts in your name can be linked.',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.moodyBlue,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Save button ───────────────────────────────────────────
          Container(
            padding: REdgeInsets.fromLTRB(20, 12, 20, 32),
            decoration: BoxDecoration(
              color: AppColors.background,
              border: Border(top: BorderSide(color: AppColors.divider)),
            ),
            child: ValueListenableBuilder<String?>(
              valueListenable: controller.resolvedAccountName,
              builder: (context, name, _) {
                return ValueListenableBuilder<bool>(
                  valueListenable: controller.isSaving,
                  builder: (context, saving, _) {
                    final enabled = name != null && !saving;
                    return AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: enabled ? 1.0 : 0.45,
                      child: GestureDetector(
                        onTap: enabled ? controller.onSave : null,
                        child: Container(
                          width: double.infinity,
                          height: 56.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          child: saving
                              ? SizedBox(
                                  width: 22.r,
                                  height: 22.r,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: AppColors.white,
                                  ),
                                )
                              : Text(
                                  'Save Bank Account',
                                  style: AppTextStyles.labelLarge.copyWith(
                                    color: AppColors.white,
                                    fontSize: 16.sp,
                                  ),
                                ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hintText,
    required IconData prefixIcon,
    String? counterText,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.textDisabled,
      ),
      prefixIcon: Icon(
        prefixIcon,
        size: 18.r,
        color: AppColors.textSecondary,
      ),
      filled: true,
      fillColor: AppColors.surfaceVariant,
      counterText: counterText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: AppColors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: AppColors.error, width: 1.5),
      ),
      contentPadding: REdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppTextStyles.labelLarge.copyWith(color: AppColors.textPrimary),
    );
  }
}
