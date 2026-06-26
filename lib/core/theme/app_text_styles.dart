// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';

// import 'app_colors.dart';

// /// Beige Africa Typography
// ///
// /// Headline font : BW Gradual       — large headlines only
// /// Secondary font: Euclid Circular A — everything else (sub-heads, body, labels)
// ///
// /// BW Gradual is not available on Google Fonts; load it as a local asset.
// /// Euclid Circular A is also a licensed font; load it as a local asset.
// /// If neither is available during development, Inter is used as a fallback.
// abstract class AppTextStyles {
//   // ── Font families ────────────────────────────────────────────────────────────

//   /// BW Gradual — headlines only, use large
//   static const String _headline = 'BWGradual';

//   /// Euclid Circular A — sub-heads, body, labels, numbers
//   static const String _body = 'EuclidCircularA';

//   // ── Display / Hero ───────────────────────────────────────────────────────────

//   static TextStyle get displayLarge => TextStyle(
//         fontFamily: _headline,
//         fontSize: 48.sp,
//         fontWeight: FontWeight.w600,
//         color: AppColors.textPrimary,
//         height: 1.1,
//         letterSpacing: -0.5,
//       );

//   static TextStyle get displayMedium => TextStyle(
//         fontFamily: _headline,
//         fontSize: 40.sp,
//         fontWeight: FontWeight.w600,
//         color: AppColors.textPrimary,
//         height: 1.15,
//         letterSpacing: -0.3,
//       );

//   static TextStyle get displaySmall => TextStyle(
//         fontFamily: _headline,
//         fontSize: 32.sp,
//         fontWeight: FontWeight.w600,
//         color: AppColors.textPrimary,
//         height: 1.2,
//       );

//   // ── Headlines ────────────────────────────────────────────────────────────────

//   static TextStyle get headlineLarge => TextStyle(
//         fontFamily: _headline,
//         fontSize: 28.sp,
//         fontWeight: FontWeight.w600,
//         color: AppColors.textPrimary,
//         height: 1.25,
//       );

//   static TextStyle get headlineMedium => TextStyle(
//         fontFamily: _headline,
//         fontSize: 24.sp,
//         fontWeight: FontWeight.w600,
//         color: AppColors.textPrimary,
//         height: 1.3,
//       );

//   static TextStyle get headlineSmall => TextStyle(
//         fontFamily: _headline,
//         fontSize: 20.sp,
//         fontWeight: FontWeight.w600,
//         color: AppColors.textPrimary,
//         height: 1.3,
//       );

//   // ── Titles (Euclid Circular A) ───────────────────────────────────────────────

//   static TextStyle get titleLarge => TextStyle(
//         fontFamily: _body,
//         fontSize: 18.sp,
//         fontWeight: FontWeight.w600,
//         color: AppColors.textPrimary,
//         height: 1.35,
//       );

//   static TextStyle get titleMedium => TextStyle(
//         fontFamily: _body,
//         fontSize: 16.sp,
//         fontWeight: FontWeight.w500,
//         color: AppColors.textPrimary,
//         height: 1.4,
//       );

//   static TextStyle get titleSmall => TextStyle(
//         fontFamily: _body,
//         fontSize: 14.sp,
//         fontWeight: FontWeight.w500,
//         color: AppColors.textPrimary,
//         height: 1.4,
//       );

//   // ── Body ─────────────────────────────────────────────────────────────────────

//   static TextStyle get bodyLarge => TextStyle(
//         fontFamily: _body,
//         fontSize: 16.sp,
//         fontWeight: FontWeight.w400,
//         color: AppColors.textPrimary,
//         height: 1.5,
//       );

//   static TextStyle get bodyMedium => TextStyle(
//         fontFamily: _body,
//         fontSize: 14.sp,
//         fontWeight: FontWeight.w400,
//         color: AppColors.textPrimary,
//         height: 1.5,
//       );

//   static TextStyle get bodySmall => TextStyle(
//         fontFamily: _body,
//         fontSize: 12.sp,
//         fontWeight: FontWeight.w400,
//         color: AppColors.textSecondary,
//         height: 1.5,
//       );

//   // ── Labels ───────────────────────────────────────────────────────────────────

//   static TextStyle get labelLarge => TextStyle(
//         fontFamily: _body,
//         fontSize: 14.sp,
//         fontWeight: FontWeight.w600,
//         color: AppColors.textPrimary,
//         height: 1.4,
//         letterSpacing: 0.1,
//       );

//   static TextStyle get labelMedium => TextStyle(
//         fontFamily: _body,
//         fontSize: 12.sp,
//         fontWeight: FontWeight.w500,
//         color: AppColors.textPrimary,
//         height: 1.4,
//         letterSpacing: 0.5,
//       );

//   static TextStyle get labelSmall => TextStyle(
//         fontFamily: _body,
//         fontSize: 10.sp,
//         fontWeight: FontWeight.w500,
//         color: AppColors.textSecondary,
//         height: 1.4,
//         letterSpacing: 0.5,
//       );

//   // ── Convenience on-dark variants ─────────────────────────────────────────────

//   static TextStyle get bodyLargeOnDark =>
//       bodyLarge.copyWith(color: AppColors.textOnDark);

//   static TextStyle get bodyMediumOnDark =>
//       bodyMedium.copyWith(color: AppColors.textOnDark);

//   static TextStyle get titleLargeOnDark =>
//       titleLarge.copyWith(color: AppColors.textOnDark);
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 
/// Beige Africa Typography
///
/// Headline font : BW Gradual        — large headlines only
/// Secondary font: Euclid Circular A — everything else (sub-heads, body, labels)
///
/// BW Gradual is not available on Google Fonts; load it as a local asset.
/// Euclid Circular A is also a licensed font; load it as a local asset.
///
/// ── Color policy ──────────────────────────────────────────────────────────────
/// AppTextStyles defines ONLY font, size, weight, height, and letter-spacing.
/// Colors are intentionally absent here — they are applied by:
///   1. AppTheme.light / AppTheme.dark  via ThemeData.textTheme  (automatic)
///   2. Call-site overrides via .copyWith(color: Theme.of(context).colorScheme.X)
///      when a specific semantic color is needed.
///
/// This means the text theme adapts to light/dark automatically without any
/// changes to feature-layer widgets.
/// ─────────────────────────────────────────────────────────────────────────────
abstract class AppTextStyles {
  // ── Font families ────────────────────────────────────────────────────────────
 
  /// BW Gradual — headlines only
  static const String _headline = 'BWGradual';
 
  /// Euclid Circular A — sub-heads, body, labels, numbers
  static const String _body = 'EuclidCircularA';
 
  // ── Display / Hero ───────────────────────────────────────────────────────────
 
  static TextStyle get displayLarge => TextStyle(
        fontFamily: _headline,
        fontSize: 48.sp,
        fontWeight: FontWeight.w600,
        height: 1.1,
        letterSpacing: -0.5,
      );
 
  static TextStyle get displayMedium => TextStyle(
        fontFamily: _headline,
        fontSize: 40.sp,
        fontWeight: FontWeight.w600,
        height: 1.15,
        letterSpacing: -0.3,
      );
 
  static TextStyle get displaySmall => TextStyle(
        fontFamily: _headline,
        fontSize: 32.sp,
        fontWeight: FontWeight.w600,
        height: 1.2,
      );
 
  // ── Headlines ────────────────────────────────────────────────────────────────
 
  static TextStyle get headlineLarge => TextStyle(
        fontFamily: _headline,
        fontSize: 28.sp,
        fontWeight: FontWeight.w600,
        height: 1.25,
      );
 
  static TextStyle get headlineMedium => TextStyle(
        fontFamily: _headline,
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        height: 1.3,
      );
 
  static TextStyle get headlineSmall => TextStyle(
        fontFamily: _headline,
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        height: 1.3,
      );
 
  // ── Titles ───────────────────────────────────────────────────────────────────
 
  static TextStyle get titleLarge => TextStyle(
        fontFamily: _body,
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        height: 1.35,
      );
 
  static TextStyle get titleMedium => TextStyle(
        fontFamily: _body,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        height: 1.4,
      );
 
  static TextStyle get titleSmall => TextStyle(
        fontFamily: _body,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        height: 1.4,
      );
 
  // ── Body ─────────────────────────────────────────────────────────────────────
 
  static TextStyle get bodyLarge => TextStyle(
        fontFamily: _body,
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        height: 1.5,
      );
 
  static TextStyle get bodyMedium => TextStyle(
        fontFamily: _body,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        height: 1.5,
      );
 
  static TextStyle get bodySmall => TextStyle(
        fontFamily: _body,
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        height: 1.5,
      );
 
  // ── Labels ───────────────────────────────────────────────────────────────────
 
  static TextStyle get labelLarge => TextStyle(
        fontFamily: _body,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        height: 1.4,
        letterSpacing: 0.1,
      );
 
  static TextStyle get labelMedium => TextStyle(
        fontFamily: _body,
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        height: 1.4,
        letterSpacing: 0.5,
      );
 
  static TextStyle get labelSmall => TextStyle(
        fontFamily: _body,
        fontSize: 10.sp,
        fontWeight: FontWeight.w500,
        height: 1.4,
        letterSpacing: 0.5,
      );
 
  // ── On-dark convenience variants ─────────────────────────────────────────────
  // These remain valid for surfaces that are always dark regardless of theme
  // (e.g. the African Green header card, the green CTA button label).
  // Do NOT use these for general adaptive text — use Theme.of(context) instead.
 
  static TextStyle get bodyLargeOnDark =>
      bodyLarge.copyWith(color: Colors.white);
 
  static TextStyle get bodyMediumOnDark =>
      bodyMedium.copyWith(color: Colors.white);
 
  static TextStyle get titleLargeOnDark =>
      titleLarge.copyWith(color: Colors.white);
}