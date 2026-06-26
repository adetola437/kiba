import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object?> get props => [];
}

class ThemeInitial extends ThemeState {}

class ThemeLoaded extends ThemeState {
  final ThemeMode mode;
  const ThemeLoaded(this.mode);

  bool get isDark => mode == ThemeMode.dark;

  @override
  List<Object?> get props => [mode];
}
