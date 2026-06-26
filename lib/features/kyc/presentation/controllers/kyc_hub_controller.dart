import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/contract.dart';
import '../../data/kyc_data.dart';
import 'kyc_tier2_controller.dart';


part '../contracts/kyc_hub_contract.dart';
part '../views/kyc_hub_view.dart';

class KycHubScreen extends StatefulWidget {
  static const String route = 'kyc';
  const KycHubScreen({super.key});

  @override
  State<KycHubScreen> createState() => _KycHubScreenState();
}

class _KycHubScreenState extends State<KycHubScreen>
    implements KycHubControllerContract {
  late final KycHubViewContract view;

  @override
  final UserKycState kycState = kMockKycState;

  @override
  List<KycTierInfo> get tiers => kTierInfoList;

  @override
  void initState() {
    super.initState();
    view = KycHubView(controller: this);
  }

  @override
  void onUpgradeTier2() => context.pushNamed(
        KycTier2Screen.route,
        extra: {'accountType': kycState.accountType},
      );

  @override
  void onUpgradeTier3() => context.pushNamed(KycTier3Screen.route);

  @override
  void onBack() => context.pop();

  @override
  Widget build(BuildContext context) => view.build(context);
}

// Forward declarations

class KycTier3Screen { static const String route = 'kyc_tier3'; }