part of '../controllers/add_bank_account_controller.dart';

class AddBankAccountView extends StatelessWidget
    implements AddBankAccountViewContract {
  const AddBankAccountView({super.key, required this.controller});

  final AddBankAccountControllerContract controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Container(
            margin: REdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: colorScheme.outline),
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 16.r,
              color: colorScheme.onSurface,
            ),
          ),
        ),
        title: Text(
          'Add Bank Account',
          style: textTheme.titleMedium,
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
                      style: textTheme.headlineSmall?.copyWith(
                        fontFamily: 'BWGradual',
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Your account will be verified instantly via NIBSS.',
                      style: textTheme.bodySmall,
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
                          decoration: const InputDecoration(
                            hintText: 'Select your bank',
                            prefixIcon: Icon(Icons.account_balance_outlined),
                          ),
                          items: controller.banks
                              .map(
                                (b) => DropdownMenuItem(
                                  value: b,
                                  child: Text(b),
                                ),
                              )
                              .toList(),
                          onChanged: controller.onBankSelected,
                          validator: (v) =>
                              v == null ? 'Please select a bank' : null,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          dropdownColor: colorScheme.surface,
                          borderRadius: BorderRadius.circular(12.r),
                          style: textTheme.bodyMedium,
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
                      style: textTheme.bodyMedium?.copyWith(
                        fontFamily: 'EuclidCircularA',
                        letterSpacing: 1.5,
                      ),
                      decoration: const InputDecoration(
                        hintText: '0000000000',
                        prefixIcon: Icon(Icons.pin_outlined),
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
                                  color: colorScheme.surfaceVariant,
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 16.r,
                                      height: 16.r,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: colorScheme.primary,
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                    Text(
                                      'Verifying account...',
                                      style: textTheme.bodySmall,
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
                                          style: textTheme.labelSmall?.copyWith(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          name,
                                          style: textTheme.bodyMedium?.copyWith(
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
                              style: textTheme.bodySmall?.copyWith(
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
              color: theme.scaffoldBackgroundColor,
              border: Border(
                top: BorderSide(color: colorScheme.outline.withOpacity(0.5)),
              ),
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
                      child: IgnorePointer(
                        ignoring: !enabled,
                        child: ElevatedButton(
                          onPressed: enabled ? controller.onSave : null,
                          child: saving
                              ? SizedBox(
                                  width: 22.r,
                                  height: 22.r,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text('Save Bank Account'),
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
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.labelLarge,
    );
  }
}