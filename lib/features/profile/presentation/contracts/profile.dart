part of '../controllers/profile.dart';

abstract class ProfileControllerContract {
  void onMenuTap(ProfileMenuItem item);
  void onEditAvatar();
  void onKycTap();
  void onLogout();
}

abstract class ProfileViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}
