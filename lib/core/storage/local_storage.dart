import 'package:flutter/src/material/app.dart';

abstract class LocalStorage {
  // ── Token ──────────────────────────────────────────────────────────────────
  Future<void> saveAccessToken(String token);
  Future<String?> getAccessToken();
  Future<void> clearAccessToken();

  // ── Token expiry ───────────────────────────────────────────────────────────
  Future<void> saveTokenExpiry(DateTime expiresAt);
  Future<DateTime?> getTokenExpiry();

  // ── User data ──────────────────────────────────────────────────────────────
  Future<void> saveUserData(String json);
  Future<String?> getUserData();

  // ── Product catalogue cache ────────────────────────────────────────────────
  Future<void> saveProductCatalogue(String json);
  Future<String?> getProductCatalogue();
  Future<void> clearProductCatalogue();

  // ── Clear all ─────────────────────────────────────────────────────────────
  Future<void> clearAll();

  Future<void> saveTheme(ThemeMode mode);
  Future<ThemeMode> getSavedTheme();
}