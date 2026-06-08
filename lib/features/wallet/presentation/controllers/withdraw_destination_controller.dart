import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/contract.dart';
import 'add_bank_account_controller.dart';
import 'withdraw_review_controller.dart';

part '../contracts/withdraw_destination_contract.dart';
part '../views/withdraw_destination_view.dart';
part '../widgets/bank_account_tile.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Model
// ─────────────────────────────────────────────────────────────────────────────

class LinkedBankAccount {
  final String id;
  final String bankName;
  final String maskedNumber;
  final String accountName;
  final Color brandColor;

  const LinkedBankAccount({
    required this.id,
    required this.bankName,
    required this.maskedNumber,
    required this.accountName,
    required this.brandColor,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// Screen
// ─────────────────────────────────────────────────────────────────────────────

class WithdrawDestinationScreen extends StatefulWidget {
  static const String route = 'withdraw_destination';

  final double amount;
  final double availableBalance;

  const WithdrawDestinationScreen({
    super.key,
    required this.amount,
    required this.availableBalance,
  });

  @override
  State<WithdrawDestinationScreen> createState() =>
      _WithdrawDestinationScreenState();
}

class _WithdrawDestinationScreenState extends State<WithdrawDestinationScreen>
    implements WithdrawDestinationControllerContract {
  late final WithdrawDestinationViewContract view;

  // Mock linked accounts — replace with repository call
  static const List<LinkedBankAccount> _mockAccounts = [
    LinkedBankAccount(
      id: 'acc_1',
      bankName: 'First Bank of Nigeria',
      maskedNumber: '0092 **** 4412',
      accountName: 'OLUWASEUN ADEMOLA',
      brandColor: Color(0xFF003087),
    ),
    LinkedBankAccount(
      id: 'acc_2',
      bankName: 'GT Bank',
      maskedNumber: '2210 **** 8821',
      accountName: 'OLUWASEUN ADEMOLA',
      brandColor: Color(0xFFE05D00),
    ),
  ];

  @override
  late final ValueNotifier<String?> selectedAccountId =
      ValueNotifier(_mockAccounts.isNotEmpty ? _mockAccounts.first.id : null);

  @override
  List<LinkedBankAccount> get accounts => _mockAccounts;

  @override
  double get amount => widget.amount;

  @override
  void initState() {
    super.initState();
    view = WithdrawDestinationView(controller: this);
  }

  @override
  void dispose() {
    selectedAccountId.dispose();
    super.dispose();
  }

  @override
  void onSelectAccount(String id) => selectedAccountId.value = id;

  @override
  void onAddNewAccount() =>
      context.pushNamed(AddBankAccountScreen.route).then((_) {
        // Refresh accounts list after returning
        setState(() {});
      });

  @override
  void onReviewWithdrawal() {
    final id = selectedAccountId.value;
    if (id == null) return;
    final account = accounts.firstWhere((a) => a.id == id);

    context.pushNamed(
      WithdrawReviewScreen.route,
      extra: {
        'amount': amount,
        'account': account,
        'availableBalance': widget.availableBalance,
      },
    );
  }

  @override
  Widget build(BuildContext context) => view.build(context);
}
