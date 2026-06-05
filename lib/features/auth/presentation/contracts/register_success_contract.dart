part of '../controllers/register_success_controller.dart';

abstract class RegisterSuccessControllerContract {
  String get firstName;
  AnimationController get checkController;
  AnimationController get contentController;

  Animation<double> get checkScale;
  Animation<double> get checkOpacity;
  Animation<double> get ringScale;
  Animation<double> get ringOpacity;
  Animation<double> get contentOpacity;
  Animation<Offset> get contentSlide;
}

abstract class RegisterSuccessViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}

