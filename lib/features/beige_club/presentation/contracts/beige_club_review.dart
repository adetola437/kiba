part of '../controllers/beige_club_review_controller.dart';

abstract class BeigeClubReviewControllerContract {
  double get amount;
  String get startMonth;
  ContributionMode get contributionMode;
  double get totalContributed;
  double get projectedInterest;
  double get yearEndPayout;
  double get dailyAccrual;
  bool get termsAccepted;
  bool get isLoading;
  int get positionInRotation;

  void onToggleTerms();
  void onConfirm();
  void onBack();
}

abstract class BeigeClubReviewViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}

