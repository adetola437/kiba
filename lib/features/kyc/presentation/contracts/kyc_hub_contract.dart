part of '../controllers/kyc_hub_controller.dart';

abstract class KycHubControllerContract {
  UserKycState get kycState;
  List<KycTierInfo> get tiers;

  void onUpgradeTier2();
  void onUpgradeTier3();
  void onBack();
}

abstract class KycHubViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}

