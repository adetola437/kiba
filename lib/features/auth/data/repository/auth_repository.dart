import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/api/exception/failure.dart';
import '../models/auth_models.dart';
import '../models/login_data.dart';

abstract class IAuthRepository {
  Future<Either<Failure, LoginResponse>> login(String email, String password);

  /// Persist token, expiry and user data after a successful login.
  Future<void> saveSession({
    required String token,
    required DateTime expiresAt,
    required AuthUser user,
  });

  Future<String?> getSavedToken();
  Future<DateTime?> getTokenExpiry();
  Future<String?> getSavedUser();

  /// Wipe all session data (token, expiry, user).
  Future<void> logout();
    /// Returns the persisted [ThemeMode], defaulting to [ThemeMode.light].
  Future<ThemeMode> getSavedTheme();

  /// Persists [mode] to local storage.
  Future<void> saveTheme(ThemeMode mode);
}