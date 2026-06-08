part of '../controllers/beige_club_intro_controller.dart';

abstract class BeigeClubIntroControllerContract {
  void onJoin();
  void onBack();
}

abstract class BeigeClubIntroViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}
