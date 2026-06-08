import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kiba/features/beige_club/presentation/controllers/beige_club_group.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/contract.dart';
import '../../../../core/utils/consts.dart' as data;
import 'beige_club_setup_controller.dart';

part '../contracts/beige_club_intro_contract.dart';
part '../views/beige_club_intro_view.dart';

class BeigeClubIntroScreen extends StatefulWidget {
  static const String route = 'beige_club';
  const BeigeClubIntroScreen({super.key});

  @override
  State<BeigeClubIntroScreen> createState() => _BeigeClubIntroScreenState();
}

class _BeigeClubIntroScreenState extends State<BeigeClubIntroScreen>
    implements BeigeClubIntroControllerContract {
  late final BeigeClubIntroViewContract view;

  @override
  void initState() {
    super.initState();
    view = BeigeClubIntroView(controller: this);
  }

  @override
  void onJoin() => context.pushNamed(BeigeClubGroupsScreen.route);

  @override
  void onBack() => context.pop();

  @override
  Widget build(BuildContext context) => view.build(context);
}

// Forward declaration
