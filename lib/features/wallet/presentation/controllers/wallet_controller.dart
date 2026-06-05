import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/contract.dart';

part '../contracts/wallet_contract.dart';
part '../views/wallet_view.dart';
part '../widgets/wallet_balance_card.dart';
part '../widgets/virtual_account_card.dart';
part '../widgets/wallet_transaction_item.dart';

class WalletScreen extends StatefulWidget {
  static const String route = 'wallet';
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    implements WalletControllerContract {
  late final WalletViewContract view;

  @override
  bool balanceVisible = true;

  @override
  void initState() {
    super.initState();
    view = WalletView(controller: this);
  }

  @override
  void onToggleBalance() => setState(() => balanceVisible = !balanceVisible);

  @override
  void onFund() => context.pushNamed('fund_wallet');

  @override
  void onWithdraw() => context.pushNamed('withdraw');

  @override
  void onCopyAccountNumber() {
    Clipboard.setData(const ClipboardData(text: '9901234567'));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Account number copied!',
          style: AppTextStyles.bodySmall.copyWith(color: AppColors.white),
        ),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void onSeeAllTransactions() => context.pushNamed('history');

  @override
  Widget build(BuildContext context) => view.build(context);
}