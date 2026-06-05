import 'package:flutter/material.dart';

/// Beige Africa Brand Colours
/// Source: Beige Africa Logo & Brand Identity Guidelines (05/04/2022)
abstract class AppColors {
  // ── Primary Colours ──────────────────────────────────────────────────────────

  /// African Green — Beige Africa's signature brand colour.
  /// Use as the primary background, CTAs, and dominant UI colour.
  static const Color africanGreen = Color(0xFF0C3934);

  /// Beige Pink — Primary alternative. Use on African Green backgrounds
  /// or when African Green doesn't work (e.g. on imagery or dark backgrounds).
  static const Color beigePink = Color(0xFFF5C8CF);

  // ── Secondary Colours ────────────────────────────────────────────────────────

  /// Charcoal Grey — Used for text and dark UI surfaces.
  static const Color charcoalGrey = Color(0xFF1C1A1B);

  /// Moody Blue — Secondary accent colour.
  static const Color moodyBlue = Color(0xFF19224D);

  // ── Neutral Colours ──────────────────────────────────────────────────────────

  /// Cloudy Blue — Light neutral, soft backgrounds.
  static const Color cloudyBlue = Color(0xFFDEF0F4);

  /// Lime Green — Light neutral, soft accent.
  static const Color limeGreen = Color(0xFFC4E0BE);

  /// White
  static const Color white = Color(0xFFFFFFFF);

  /// Black
  static const Color black = Color(0xFF000000);

  // ── Semantic / UI Aliases ────────────────────────────────────────────────────
  // Mapped from brand palette for use across the app

  static const Color primary = africanGreen;
  static const Color onPrimary = white;

  static const Color background = white;
  static const Color onBackground = charcoalGrey;

  static const Color surface = white;
  static const Color onSurface = charcoalGrey;

  static const Color surfaceVariant = cloudyBlue;
  static const Color onSurfaceVariant = charcoalGrey;

  static const Color error = Color(0xFFB00020);
  static const Color onError = white;

  static const Color textPrimary = charcoalGrey;
  static const Color textSecondary = Color(0xFF5A5858); // charcoalGrey @ ~65%
  static const Color textDisabled = Color(0xFF9E9C9D);  // charcoalGrey @ ~40%
  static const Color textOnDark = white;
  static const Color textOnBrand = beigePink;           // text on africanGreen surfaces

  static const Color divider = Color(0xFFE0E0E0);
  static const Color border = Color(0xFFE0E0E0);

  /// Subtle border for outlined buttons / input fields on white backgrounds
  /// africanGreen @ 20% opacity, pre-composited for use in BoxDecoration.
  static const Color buttonBorder = Color(0x330C3934);

  static const Color shimmerBase = Color(0xFFEEEEEE);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);
}