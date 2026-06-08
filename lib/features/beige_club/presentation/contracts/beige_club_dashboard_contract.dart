part of '../controllers/beige_club_dashboard_controller.dart';



abstract class BeigeClubDashboardControllerContract {
  ActiveClubSubscription get subscription;

  void onMakeContribution();
  void onViewGroupProgress();
  void onViewHistory();
  void onBack();
}

abstract class BeigeClubDashboardViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}

