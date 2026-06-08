import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/consts.dart' as data;
import '../../../../core/utils/contract.dart';
import '../../../../core/utils/enums.dart';
import 'beige_club_review_controller.dart';

part '../contracts/beige_club_setup.dart';
part '../views/beige_club_setup_view.dart';

// ignore: unused_import

class BeigeClubSetupScreen extends StatefulWidget {
  static const String route = 'beige_club_setup';
  const BeigeClubSetupScreen({super.key});

  @override
  State<BeigeClubSetupScreen> createState() => _BeigeClubSetupScreenState();
}

class _BeigeClubSetupScreenState extends State<BeigeClubSetupScreen>
    implements BeigeClubSetupControllerContract {
  late final BeigeClubSetupViewContract view;

  @override
  double selectedAmount = data.kClubMinContribution;

  @override
  String selectedMonth = data.kMonths[DateTime.now().month - 1];

  @override
  ContributionMode contributionMode = ContributionMode.manual;

  @override
  bool get canContinue => selectedAmount >= data.kClubMinContribution;

  @override
  double get totalContributed => selectedAmount * 12;

  @override
  double get projectedInterest =>
      totalContributed * (data.kClubRate / 100);

  @override
  double get yearEndPayout => totalContributed + projectedInterest;

  @override
  double get dailyAccrual =>
      (selectedAmount * (data.kClubRate / 100)) / 365;

  @override
  void initState() {
    super.initState();
    view = BeigeClubSetupView(controller: this);
  }

  @override
  void onAmountSelected(double amount) =>
      setState(() => selectedAmount = amount);

  @override
  void onMonthSelected(String month) =>
      setState(() => selectedMonth = month);

  @override
  void onModeChanged(ContributionMode mode) =>
      setState(() => contributionMode = mode);

  @override
  void onContinue() {
    if (!canContinue) return;
    context.pushNamed(
      BeigeClubReviewScreen.route,
      extra: {
        'amount': selectedAmount,
        'startMonth': selectedMonth,
        'mode': contributionMode,
        'totalContributed': totalContributed,
        'projectedInterest': projectedInterest,
        'yearEndPayout': yearEndPayout,
        'dailyAccrual': dailyAccrual,
      },
    );
  }

  @override
  void onBack() => context.pop();

  @override
  Widget build(BuildContext context) => view.build(context);
}

