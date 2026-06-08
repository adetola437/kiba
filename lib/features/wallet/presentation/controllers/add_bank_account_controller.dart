import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/contract.dart';

part '../contracts/add_bank_account_contract.dart';
part '../views/add_bank_account_view.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Screen
// ─────────────────────────────────────────────────────────────────────────────

class AddBankAccountScreen extends StatefulWidget {
  static const String route = 'add_bank_account';
  const AddBankAccountScreen({super.key});

  @override
  State<AddBankAccountScreen> createState() => _AddBankAccountScreenState();
}

class _AddBankAccountScreenState extends State<AddBankAccountScreen>
    implements AddBankAccountControllerContract {
  late final AddBankAccountViewContract view;

  @override
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  final TextEditingController accountNumberCtrl = TextEditingController();

  @override
  final TextEditingController bankNameCtrl = TextEditingController();

  // Resolved automatically from account number + bank
  @override
  late final ValueNotifier<String?> resolvedAccountName = ValueNotifier(null);

  @override
  late final ValueNotifier<bool> isResolving = ValueNotifier(false);

  @override
  late final ValueNotifier<bool> isSaving = ValueNotifier(false);

  @override
  late final ValueNotifier<String?> selectedBank = ValueNotifier(null);

  static const List<String> _nigeriaBanks = [
    'Access Bank',
    'Citibank Nigeria',
    'Ecobank Nigeria',
    'Fidelity Bank',
    'First Bank of Nigeria',
    'First City Monument Bank (FCMB)',
    'Guaranty Trust Bank (GTBank)',
    'Heritage Bank',
    'Keystone Bank',
    'Kuda Bank',
    'Opay',
    'Palmpay',
    'Polaris Bank',
    'Providus Bank',
    'Stanbic IBTC Bank',
    'Standard Chartered Bank',
    'Sterling Bank',
    'Union Bank of Nigeria',
    'United Bank for Africa (UBA)',
    'Unity Bank',
    'Wema Bank',
    'Zenith Bank',
  ];

  @override
  List<String> get banks => _nigeriaBanks;

  @override
  void initState() {
    super.initState();
    accountNumberCtrl.addListener(_onAccountNumberChanged);
    view = AddBankAccountView(controller: this);
  }

  void _onAccountNumberChanged() {
    resolvedAccountName.value = null;
    final number = accountNumberCtrl.text.trim();
    if (number.length == 10 && selectedBank.value != null) {
      _resolveAccountName(number);
    }
  }

  Future<void> _resolveAccountName(String number) async {
    isResolving.value = true;
    // TODO: call account resolution API (NIBSS / bank API)
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    // Simulate resolved name
    resolvedAccountName.value = 'OLUWASEUN ADEMOLA';
    isResolving.value = false;
  }

  @override
  void onBankSelected(String? bank) {
    selectedBank.value = bank;
    resolvedAccountName.value = null;
    final number = accountNumberCtrl.text.trim();
    if (number.length == 10 && bank != null) {
      _resolveAccountName(number);
    }
  }

  @override
  Future<void> onSave() async {
    if (!formKey.currentState!.validate()) return;
    if (resolvedAccountName.value == null) return;

    isSaving.value = true;
    // TODO: save to repository
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;
    isSaving.value = false;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Bank account added successfully!',
          style: AppTextStyles.bodySmall.copyWith(color: AppColors.white),
        ),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );

    context.pop();
  }

  @override
  void dispose() {
    accountNumberCtrl.dispose();
    bankNameCtrl.dispose();
    resolvedAccountName.dispose();
    isResolving.dispose();
    isSaving.dispose();
    selectedBank.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => view.build(context);
}
