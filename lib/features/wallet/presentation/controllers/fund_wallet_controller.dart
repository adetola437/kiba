import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/contract.dart';
import 'fund_bank_transfer_controller.dart';
import 'fund_ussd_controller.dart';

part '../contracts/fund_wallet_contract.dart';
part '../views/fund_wallet_view.dart';
part '../widgets/payment_method_tile.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Screen
// ─────────────────────────────────────────────────────────────────────────────

class FundWalletScreen extends StatefulWidget {
  static const String route = 'fund_wallet';
  const FundWalletScreen({super.key});

  @override
  State<FundWalletScreen> createState() => _FundWalletScreenState();
}

class _FundWalletScreenState extends State<FundWalletScreen>
    implements FundWalletControllerContract {
  late final FundWalletViewContract view;

  @override
  void initState() {
    super.initState();
    view = FundWalletView(controller: this);
  }

  @override
  void onSelectDebitCard() => context.pushNamed(FundBankTransferScreen.route);

  @override
  void onSelectBankTransfer() => context.pushNamed(FundBankTransferScreen.route);

  @override
  void onSelectUssd() => context.pushNamed(FundUssdScreen.route);

  @override
  void onSelectVirtualAccount() =>
      context.pushNamed(FundBankTransferScreen.route);

  @override
  Widget build(BuildContext context) => view.build(context);
}