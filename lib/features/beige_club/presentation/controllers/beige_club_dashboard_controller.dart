import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/models/beige_club_data.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/contract.dart';
import '../../../../core/utils/enums.dart';
import 'beige_club_subscirbed_screen.dart';

part '../contracts/beige_club_dashboard_contract.dart';
part '../views/beige_club_dashboard_view.dart';

class BeigeClubDashboardScreen extends StatefulWidget {
  static const String route = 'beige_club_dashboard';
  const BeigeClubDashboardScreen({super.key});

  @override
  State<BeigeClubDashboardScreen> createState() =>
      _BeigeClubDashboardScreenState();
}

class _BeigeClubDashboardScreenState
    extends State<BeigeClubDashboardScreen>
    implements BeigeClubDashboardControllerContract {
  late final BeigeClubDashboardViewContract view;

  @override
  ActiveClubSubscription get subscription => kActiveSubscription;

  @override
  void initState() {
    super.initState();
    view = BeigeClubDashboardView(controller: this);
  }

  @override
  void onMakeContribution() =>
      context.pushNamed(BeigeClubContributeScreen.route);

  @override
  void onViewGroupProgress() =>
      context.pushNamed(BeigeClubGroupProgressScreen.route);

  @override
  void onViewHistory() =>
      context.pushNamed(BeigeClubHistoryScreen.route);

  @override
  void onBack() => context.pop();

  @override
  Widget build(BuildContext context) => view.build(context);
}

