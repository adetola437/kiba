import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

abstract class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,

        // ── Colour scheme ───────────────────────────────────────────────────────
        colorScheme: const ColorScheme.light(
          primary: AppColors.africanGreen,
          onPrimary: AppColors.beigePink,
          primaryContainer: AppColors.limeGreen,
          onPrimaryContainer: AppColors.africanGreen,
          secondary: AppColors.beigePink,
          onSecondary: AppColors.africanGreen,
          secondaryContainer: AppColors.cloudyBlue,
          onSecondaryContainer: AppColors.charcoalGrey,
          tertiary: AppColors.moodyBlue,
          onTertiary: AppColors.white,
          background: AppColors.background,
          onBackground: AppColors.onBackground,
          surface: AppColors.surface,
          onSurface: AppColors.onSurface,
          surfaceVariant: AppColors.surfaceVariant,
          onSurfaceVariant: AppColors.onSurfaceVariant,
          error: AppColors.error,
          onError: AppColors.onError,
          outline: AppColors.border,
        ),

        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'EuclidCircularA',

        // ── AppBar ──────────────────────────────────────────────────────────────
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.background,
          foregroundColor: AppColors.charcoalGrey,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: false, // brand: left-aligned
          titleTextStyle: AppTextStyles.titleLarge,
          iconTheme: const IconThemeData(color: AppColors.charcoalGrey),
          systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Colors.transparent,
          ),
        ),

        // ── Elevated Button ─────────────────────────────────────────────────────
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.africanGreen,
            foregroundColor: AppColors.beigePink,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: AppTextStyles.labelLarge,
            elevation: 0,
          ),
        ),

        // ── Outlined Button ─────────────────────────────────────────────────────
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.africanGreen,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            side: const BorderSide(color: AppColors.africanGreen, width: 1.5),
            textStyle: AppTextStyles.labelLarge,
          ),
        ),

        // ── Text Button ─────────────────────────────────────────────────────────
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.africanGreen,
            textStyle: AppTextStyles.labelLarge,
          ),
        ),

        // ── Input / TextField ───────────────────────────────────────────────────
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                const BorderSide(color: AppColors.africanGreen, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.error, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.error, width: 1.5),
          ),
          labelStyle: AppTextStyles.bodyMedium
              .copyWith(color: AppColors.textSecondary),
          hintStyle: AppTextStyles.bodyMedium
              .copyWith(color: AppColors.textDisabled),
          errorStyle: AppTextStyles.bodySmall
              .copyWith(color: AppColors.error),
        ),

        // ── Card ────────────────────────────────────────────────────────────────
        cardTheme: CardThemeData(
          color: AppColors.surface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.border),
          ),
          margin: EdgeInsets.zero,
        ),

        // ── Bottom Navigation Bar ───────────────────────────────────────────────
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.surface,
          selectedItemColor: AppColors.africanGreen,
          unselectedItemColor: AppColors.textDisabled,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
        ),

        // ── NavigationBar (M3) ──────────────────────────────────────────────────
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: AppColors.surface,
          indicatorColor: AppColors.limeGreen,
          iconTheme: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return const IconThemeData(color: AppColors.africanGreen);
            }
            return const IconThemeData(color: AppColors.textDisabled);
          }),
          labelTextStyle: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return AppTextStyles.labelSmall
                  .copyWith(color: AppColors.africanGreen);
            }
            return AppTextStyles.labelSmall;
          }),
        ),

        // ── Chip ────────────────────────────────────────────────────────────────
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.surfaceVariant,
          selectedColor: AppColors.limeGreen,
          labelStyle: AppTextStyles.labelMedium,
          side: BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),

        // ── Divider ─────────────────────────────────────────────────────────────
        dividerTheme: const DividerThemeData(
          color: AppColors.divider,
          thickness: 1,
          space: 1,
        ),

        // ── Text ────────────────────────────────────────────────────────────────
        textTheme: TextTheme(
          displayLarge: AppTextStyles.displayLarge,
          displayMedium: AppTextStyles.displayMedium,
          displaySmall: AppTextStyles.displaySmall,
          headlineLarge: AppTextStyles.headlineLarge,
          headlineMedium: AppTextStyles.headlineMedium,
          headlineSmall: AppTextStyles.headlineSmall,
          titleLarge: AppTextStyles.titleLarge,
          titleMedium: AppTextStyles.titleMedium,
          titleSmall: AppTextStyles.titleSmall,
          bodyLarge: AppTextStyles.bodyLarge,
          bodyMedium: AppTextStyles.bodyMedium,
          bodySmall: AppTextStyles.bodySmall,
          labelLarge: AppTextStyles.labelLarge,
          labelMedium: AppTextStyles.labelMedium,
          labelSmall: AppTextStyles.labelSmall,
        ),
      );

  // ── Dark theme (African Green as background) ──────────────────────────────────
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.beigePink,
          onPrimary: AppColors.africanGreen,
          primaryContainer: AppColors.africanGreen,
          onPrimaryContainer: AppColors.beigePink,
          secondary: AppColors.limeGreen,
          onSecondary: AppColors.africanGreen,
          background: AppColors.charcoalGrey,
          onBackground: AppColors.white,
          surface: AppColors.charcoalGrey,
          onSurface: AppColors.white,
          surfaceVariant: Color(0xFF2C2A2B),
          onSurfaceVariant: Color(0xFFCAC7C8),
          error: AppColors.error,
          onError: AppColors.white,
          outline: Color(0xFF3D3B3C),
        ),
        scaffoldBackgroundColor: AppColors.charcoalGrey,
        fontFamily: 'EuclidCircularA',
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.charcoalGrey,
          foregroundColor: AppColors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: false,
          titleTextStyle:
              AppTextStyles.titleLarge.copyWith(color: AppColors.white),
          systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Colors.transparent,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.beigePink,
            foregroundColor: AppColors.africanGreen,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: AppTextStyles.labelLarge,
            elevation: 0,
          ),
        ),
      );
}