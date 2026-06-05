part of '../controllers/onboard_controller.dart';

abstract class OnboardingControllerContract {
  int get currentPage;
  PageController get pageController;

  void onPageChanged(int index);
  void onNext();
  void onGetStarted();
  void onLogin();
}

abstract class OnboardingViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}

