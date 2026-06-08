import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/contract.dart';
import '../widgets/virtual_account_display_card.dart';

part '../contracts/fund_bank_transfer_contract.dart';
part '../views/fund_bank_transfer_view.dart';


// ─────────────────────────────────────────────────────────────────────────────
// Screen
// ─────────────────────────────────────────────────────────────────────────────

class FundBankTransferScreen extends StatefulWidget {
  static const String route = 'fund_bank_transfer';
  const FundBankTransferScreen({super.key});

  @override
  State<FundBankTransferScreen> createState() =>
      _FundBankTransferScreenState();
}

class _FundBankTransferScreenState extends State<FundBankTransferScreen>
    implements FundBankTransferControllerContract {
  late final FundBankTransferViewContract view;

  @override
  void initState() {
    super.initState();
    view = FundBankTransferView(controller: this);
  }

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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => view.build(context);
}