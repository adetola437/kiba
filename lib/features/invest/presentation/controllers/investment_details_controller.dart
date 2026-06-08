import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:kiba/features/invest/presentation/controllers/topup_investment_controller.dart';

import '../../../../core/models/investment.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/consts.dart';

part '../contracts/investment_detail_contract.dart';
part '../views/investment_details_pre.dart';
part '../views/investment_details_active.dart';
part '../widgets/investment_detail_widgets.dart';

class InvestmentDetailScreen extends StatefulWidget {
  static const String route = 'invest_detail';

  /// When true — shows the active investment view (from Portfolio).
  /// When false — shows the pre-investment product view (from Invest tab).
  final bool hasActiveInvestment;
  final String productId;

  const InvestmentDetailScreen({
    super.key,
    required this.productId,
    this.hasActiveInvestment = false,
  });

  @override
  State<InvestmentDetailScreen> createState() =>
      _InvestmentDetailScreenState();
}

class _InvestmentDetailScreenState extends State<InvestmentDetailScreen>
    implements InvestmentDetailControllerContract {
  late final InvestmentDetailViewContract view;


  @override
  InvestmentProduct get product => kPmpsProduct;

  @override
  bool get hasActiveInvestment => widget.hasActiveInvestment;

  @override
  ActiveInvestmentDetail? get activeInvestment =>
      hasActiveInvestment ? kActiveInvestment : null;

  @override
  bool balanceVisible = true;

  @override
  double estimatorAmount = 1000000;

  @override
  double get estimatedInterest =>
      estimatorAmount *
      (product.annualYield / 100) *
      (product.tenorDays / 365);

  @override
  double get estimatedTotal => estimatorAmount + estimatedInterest;

  @override
  DateTime get estimatedMaturityDate =>
      DateTime.now().add(Duration(days: product.tenorDays));

  @override
  bool get isNearMaturity {
    final inv = activeInvestment;
    if (inv == null) return false;
    return inv.daysRemaining <= 7;
  }

  @override
  bool get isMatured => activeInvestment?.isMatured ?? false;

  @override
  void initState() {
    super.initState();
    if (hasActiveInvestment) {
      view = InvestmentDetailActiveView(controller: this);
    } else {
      view = InvestmentDetailPreView(controller: this);
    }
    estimatorController = TextEditingController(
      text: NumberFormat('#,##0', 'en_US').format(estimatorAmount),
    );
  }

  @override
  void onToggleBalance() =>
      setState(() => balanceVisible = !balanceVisible);

  @override
  void onEstimatorAmountChanged(String value) {
    final clean = value.replaceAll(',', '').replaceAll('₦', '');
    final parsed = double.tryParse(clean) ?? 0;
    setState(() => estimatorAmount = parsed);
  }

  @override
  void onInvestNow() {
    if (estimatorAmount < product.minimumAmount) return;
    context.pushNamed(
      'new_investment',
      extra: {
        'productName': product.name,
        'minAmount': product.minimumAmount,
        'prefilledAmount': estimatorAmount,
      },
    );
  }

  @override
  void onTopUp() => context.pushNamed(
        TopUpInvestmentScreen.route,
        extra: {
          'productName': product.name,
          'minAmount': product.minimumAmount,
        },
      );

  @override
  void onRollOver() => context.pushNamed(
        'rollover_investment',
        extra: {'investmentId': activeInvestment?.id},
      );

  @override
  void onWithdraw() => context.pushNamed(
        'withdraw_investment',
        extra: {'investmentId': activeInvestment?.id},
      );

  @override
  void onSeeAllTransactions() => context.pushNamed(
        'history',
        extra: {'filter': 'investments'},
      );

  @override
  void onContactSupport() => context.pushNamed('contact_support');

  @override
  void onBack() => context.pop();

  @override
  void dispose() {
    estimatorController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => view.build(context);

  @override
  TextEditingController? estimatorController = TextEditingController();
}