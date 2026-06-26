
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 


import '../../features/auth/cubit/theme/theme_cubit.dart';
import '../../features/auth/cubit/theme/theme_state.dart';
import 'app_colors.dart';
 
class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});
 
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final isDark = state is ThemeLoaded && state.isDark;
 
        return Switch.adaptive(
          value: isDark,
          onChanged: (_) => context.read<ThemeCubit>().toggleTheme(),
          activeColor: AppColors.beigePink,
          activeTrackColor: AppColors.africanGreen,
        );
      },
    );
  }
}
 