import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:kiba/features/beige_club/presentation/controllers/beige_club_intro_controller.dart';
import 'package:kiba/features/wallet/presentation/controllers/transactions_controller.dart';
import 'package:kiba/features/wallet/presentation/controllers/withdraw_amount_controller.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/contract.dart';
import '../../../../core/utils/enums.dart';


part '../contracts/home_contract.dart';
part '../views/home_view.dart';
part '../widgets/portfolio_card.dart';
part '../widgets/quick_actions.dart';
part '../widgets/active_investment_card.dart';
part '../widgets/beige_club_banner.dart';
part '../widgets/recent_activity_item.dart';


class HomeScreen extends StatefulWidget {
  static const String route = 'home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    implements HomeControllerContract {
  late final HomeViewContract view;

  @override
  bool balanceVisible = true;

  @override
  String get greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  void initState() {
    super.initState();
    view = HomeView(controller: this);
  }

  @override
  void onToggleBalance() => setState(() => balanceVisible = !balanceVisible);

  @override
  void onNotificationTap() => context.pushNamed('notifications');

  @override
  void onFundWallet() => context.pushNamed('fund_wallet');

  @override
  void onWithdraw() => context.pushNamed(WithdrawAmountScreen.route);

  @override
  void onQuickAction(QuickAction action) {
    switch (action) {
      case QuickAction.fund:
        context.pushNamed('fund_wallet');
      case QuickAction.withdraw:
        context.pushNamed('withdraw');
      case QuickAction.invest:
        context.goNamed('invest');
      case QuickAction.history:
        context.pushNamed(TransactionsScreen.route);
    }
  }

  @override
  void onSeeAllInvestments() => context.goNamed('portfolio');

  @override
  void onViewHistory() => context.pushNamed('history');

  @override
  void onEnterBeigeClub() => context.pushNamed(BeigeClubIntroScreen.route);

  @override
  Widget build(BuildContext context) => view.build(context);
}