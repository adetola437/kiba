import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/contract.dart';
import 'withdraw_destination_controller.dart';
import 'withdraw_success_controller.dart';

part '../contracts/withdraw_review_contract.dart';
part '../views/withdraw_review_view.dart';
part '../widgets/withdraw_summary_row.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Screen
// ─────────────────────────────────────────────────────────────────────────────

class WithdrawReviewScreen extends StatefulWidget {
  static const String route = 'withdraw_review';

  final double amount;
  final LinkedBankAccount account;

  const WithdrawReviewScreen({
    super.key,
    required this.amount,
    required this.account,
  });

  @override
  State<WithdrawReviewScreen> createState() => _WithdrawReviewScreenState();
}

class _WithdrawReviewScreenState extends State<WithdrawReviewScreen>
    implements WithdrawReviewControllerContract {
  late final WithdrawReviewViewContract view;

  @override
  bool isLoading = false;

  @override
  double get amount => widget.amount;

  @override
  LinkedBankAccount get account => widget.account;

  @override
  double get fee => 0.0;

  @override
  double get totalToReceive => amount - fee;

  @override
  void initState() {
    super.initState();
    view = WithdrawReviewView(controller: this);
  }

  @override
  void onConfirm() => _showPinSheet();

  void _showPinSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _WithdrawPinSheet(
        onPinConfirmed: _processWithdrawal,
      ),
    );
  }

  Future<void> _processWithdrawal() async {
    setState(() => isLoading = true);
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 2000));
    if (!mounted) return;
    setState(() => isLoading = false);

    context.goNamed(
      WithdrawSuccessScreen.route,
      extra: {
        'amount': amount,
        'account': account,
        'reference': 'WD${DateTime.now().millisecondsSinceEpoch}',
      },
    );
  }

  @override
  Widget build(BuildContext context) => view.build(context);
}
