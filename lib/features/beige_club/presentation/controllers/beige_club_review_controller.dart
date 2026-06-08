import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

import '../../../../core/utils/consts.dart' as data;
import '../../../../core/utils/contract.dart';
import '../../../../core/utils/enums.dart';
import 'beige_club_success_controller.dart';

part '../contracts/beige_club_review.dart';
part '../views/beige_club_review_view.dart';

class BeigeClubReviewScreen extends StatefulWidget {
  static const String route = 'beige_club_review';

  final double amount;
  final String startMonth;
  final ContributionMode contributionMode;
  final double totalContributed;
  final double projectedInterest;
  final double yearEndPayout;
  final double dailyAccrual;

  const BeigeClubReviewScreen({
    super.key,
    required this.amount,
    required this.startMonth,
    required this.contributionMode,
    required this.totalContributed,
    required this.projectedInterest,
    required this.yearEndPayout,
    required this.dailyAccrual,
  });

  @override
  State<BeigeClubReviewScreen> createState() =>
      _BeigeClubReviewScreenState();
}

class _BeigeClubReviewScreenState extends State<BeigeClubReviewScreen>
    implements BeigeClubReviewControllerContract {
  late final BeigeClubReviewViewContract view;

  @override bool termsAccepted = false;
  @override bool isLoading = false;

  @override double get amount            => widget.amount;
  @override String get startMonth        => widget.startMonth;
  @override ContributionMode get contributionMode => widget.contributionMode;
  @override double get totalContributed  => widget.totalContributed;
  @override double get projectedInterest => widget.projectedInterest;
  @override double get yearEndPayout     => widget.yearEndPayout;
  @override double get dailyAccrual      => widget.dailyAccrual;

  // User's position = next available slot
  @override
  int get positionInRotation => data.kSlotsFilled + 1;

  @override
  void initState() {
    super.initState();
    view = BeigeClubReviewView(controller: this);
  }

  @override
  void onToggleTerms() =>
      setState(() => termsAccepted = !termsAccepted);

  @override
  Future<void> onConfirm() async {
    if (!termsAccepted || isLoading) return;
    setState(() => isLoading = true);

    await Future.delayed(const Duration(milliseconds: 2200));

    if (!mounted) return;
    setState(() => isLoading = false);

    context.goNamed(
      BeigeClubSuccessScreen.route,
      extra: {
        'amount': amount,
        'startMonth': startMonth,
        'positionInRotation': positionInRotation,
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

