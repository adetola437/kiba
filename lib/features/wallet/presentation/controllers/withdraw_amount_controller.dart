import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/contract.dart';
import '../../../../core/widgets/general_app_bar.dart';
import '../widgets/amount_quick_chip.dart';
import 'withdraw_destination_controller.dart';

part '../contracts/withdraw_amount_contract.dart';
part '../views/withdraw_amount_view.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Screen
// ─────────────────────────────────────────────────────────────────────────────

class WithdrawAmountScreen extends StatefulWidget {
  static const String route = 'withdraw_amount';

  /// Available wallet cash balance passed from the wallet screen.
  final double availableBalance;

  const WithdrawAmountScreen({
    super.key,
    required this.availableBalance,
  });

  @override
  State<WithdrawAmountScreen> createState() => _WithdrawAmountScreenState();
}

class _WithdrawAmountScreenState extends State<WithdrawAmountScreen>
    implements WithdrawAmountControllerContract {
  late final WithdrawAmountViewContract view;

  @override
  final TextEditingController amountCtrl = TextEditingController();

  @override
  late final ValueNotifier<double?> parsedAmount = ValueNotifier(null);

  @override
  late final ValueNotifier<String?> errorMessage = ValueNotifier(null);

  @override
  double get availableBalance => widget.availableBalance;

  @override
  void initState() {
    super.initState();
    amountCtrl.addListener(_onAmountChanged);
    view = WithdrawAmountView(controller: this);
  }

  void _onAmountChanged() {
    final raw = amountCtrl.text.replaceAll(',', '').trim();
    errorMessage.value = null;

    if (raw.isEmpty) {
      parsedAmount.value = null;
      return;
    }

    final val = double.tryParse(raw);
    if (val == null || val <= 0) {
      parsedAmount.value = null;
      errorMessage.value = 'Enter a valid amount';
      return;
    }

    if (val > availableBalance) {
      parsedAmount.value = null;
      errorMessage.value = 'Amount exceeds available balance';
      return;
    }

    parsedAmount.value = val;
  }

  @override
  void onQuickSelect(double percent) {
    final val = availableBalance * percent;
    amountCtrl.text = val.toStringAsFixed(2);
  }

  @override
  void onContinue() {
    final amount = parsedAmount.value;
    if (amount == null) return;

    context.pushNamed(
      WithdrawDestinationScreen.route,
      extra: {'amount': amount, 'availableBalance': availableBalance},
    );
  }

  @override
  void dispose() {
    amountCtrl.dispose();
    parsedAmount.dispose();
    errorMessage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => view.build(context);
  
  @override
String? validateAmount(String? value) {
  if (value == null || value.isEmpty) {
    return 'Amount is required';
  }
  
  final amount = double.tryParse(value);
  
  if (amount == null) {
    return 'Enter a valid amount';
  }
  
  if (amount <= 0) {
    return 'Amount must be greater than 0';
  }
  
  if (amount > availableBalance) {
    return 'Insufficient balance';
  }
  
  return null; // Validation passed
}
}
