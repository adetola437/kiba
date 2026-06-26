import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiba/features/auth/data/repository/auth_repository.dart';

import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final IAuthRepository repository;

  ThemeCubit({required this.repository}) : super(ThemeInitial()) {
    _loadSavedTheme();
  }

  // ── Load persisted preference on startup ───────────────────────────────────

  Future<void> _loadSavedTheme() async {
    final mode = await repository.getSavedTheme();
    emit(ThemeLoaded(mode));
  }

  // ── Toggle between light and dark ──────────────────────────────────────────

  Future<void> toggleTheme() async {
    final current = state;
    if (current is! ThemeLoaded) return;

    final next =
        current.isDark ? ThemeMode.light : ThemeMode.dark;

    await repository.saveTheme(next);
    emit(ThemeLoaded(next));
  }

  // ── Explicit set (e.g. follow system) ─────────────────────────────────────

  Future<void> setTheme(ThemeMode mode) async {
    await repository.saveTheme(mode);
    emit(ThemeLoaded(mode));
  }
}
