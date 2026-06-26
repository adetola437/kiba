import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'config/di/app_initializer.dart';
import 'core/theme/app_theme.dart';
import 'core/navigation/app_router.dart';
import 'features/auth/cubit/theme/theme_cubit.dart';
import 'features/auth/cubit/theme/theme_state.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await AppInitializer.init();
  runApp(const KibaApp());
}

class KibaApp extends StatelessWidget {
  const KibaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider<ThemeCubit>(
          create: (_) => sl<ThemeCubit>(),
          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              final themeMode = themeState is ThemeLoaded
                  ? themeState.mode
                  : ThemeMode.light;

              return ResponsiveBreakpoints.builder(
                breakpoints: [
                  const Breakpoint(start: 0, end: 450, name: MOBILE),
                  const Breakpoint(start: 451, end: 800, name: TABLET),
                  const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                  const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
                ],
                child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    textScaler: TextScaler.linear(
                      MediaQuery.of(context).size.width > 800 ? 1.0 : 0.95,
                    ),
                  ),
                  child: MaterialApp.router(
                    title: 'KIBA',
                    debugShowCheckedModeBanner: false,
                    theme: AppTheme.light,
                    darkTheme: AppTheme.dark,
                    themeMode: themeMode,
                    routerConfig: AppRouter.router,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
