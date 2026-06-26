
part of '../controllers/splash.dart';
 

 
abstract class SplashViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}

abstract class SplashControllerContract {
  Future<void> resolveAuthState();

  // Logo reveal animations
  Animation<double> get logoOpacity;
  Animation<double> get logoScale;
  Animation<double> get logoLineProgress;  // 0→1 for the line fanning out

  // "KIBA" text animations
  Animation<double> get kibaOpacity;
  Animation<Offset> get kibaSlide;

  // "by Beige Africa" typing animation
  Animation<double> get byBeigeOpacity;
  Animation<int> get byBeigeLetterCount;   // for typewriter effect

  // Tagline animation
  Animation<double> get taglineOpacity;
  Animation<int> get taglineLetterCount;

    Animation<double> get exitFade;
}

 