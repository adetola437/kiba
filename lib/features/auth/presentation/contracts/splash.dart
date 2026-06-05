
part of '../controllers/splash.dart';
 
abstract class SplashControllerContract {
  Future<void> resolveAuthState();
 
  Animation<double> get iconOpacity;
  Animation<double> get iconScale;
  Animation<double> get wordmarkOpacity;
  Animation<Offset> get wordmarkSlide;
  Animation<double> get lineWidth;
}
 
abstract class SplashViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}
 

 