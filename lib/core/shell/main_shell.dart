import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

// ───────────────────────────────────────────────────────────────────────────────
// MainShell
// ───────────────────────────────────────────────────────────────────────────────

class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: brightness == Brightness.dark
          ? SystemUiOverlayStyle.light.copyWith(
              statusBarColor: Colors.transparent,
            )
          : SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: Colors.transparent,
            ),
      child: Scaffold(
        body: navigationShell,
        bottomNavigationBar: _KibaBottomNav(
          currentIndex: navigationShell.currentIndex,
          onTap: _onTap,
        ),
      ),
    );
  }

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

// ───────────────────────────────────────────────────────────────────────────────
// NavItem data class
// ───────────────────────────────────────────────────────────────────────────────

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isCentre;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    this.isCentre = false,
  });
}

// ───────────────────────────────────────────────────────────────────────────────
// Custom bottom nav
// ───────────────────────────────────────────────────────────────────────────────

class _KibaBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _KibaBottomNav({
    required this.currentIndex,
    required this.onTap,
  });

  static const _items = [
    _NavItem(icon: Icons.home_outlined, activeIcon: Icons.home_rounded, label: 'Home'),
    _NavItem(icon: Icons.pie_chart_outline, activeIcon: Icons.pie_chart_rounded, label: 'Portfolio'),
    _NavItem(icon: Icons.trending_up_rounded, activeIcon: Icons.trending_up_rounded, label: 'Invest', isCentre: true),
    _NavItem(icon: Icons.account_balance_wallet_outlined, activeIcon: Icons.account_balance_wallet_rounded, label: 'Wallet'),
    _NavItem(icon: Icons.person_outline_rounded, activeIcon: Icons.person_rounded, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(color: colorScheme.outline, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64.h,
          child: Row(
            children: List.generate(_items.length, (i) {
              final item = _items[i];
              final isActive = i == currentIndex;

              // ── Centre invest button (elevated pill) ─────────────
              if (item.isCentre) {
                return Expanded(
                  child: GestureDetector(
                    onTap: () => onTap(i),
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 48.r,
                          height: 48.r,
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: colorScheme.primary.withValues(alpha: 0.35),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Icon(
                            item.activeIcon,
                            color: colorScheme.onPrimary,
                            size: 22.r,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              // ── Regular tab items ────────────────────────────────
              return Expanded(
                child: GestureDetector(
                  onTap: () => onTap(i),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          isActive ? item.activeIcon : item.icon,
                          key: ValueKey(isActive),
                          size: 22.r,
                          color: isActive
                              ? colorScheme.primary
                              : colorScheme.onSurfaceVariant,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: AppTextStyles.labelSmall.copyWith(
                          color: isActive
                              ? colorScheme.primary
                              : colorScheme.onSurfaceVariant,
                          fontWeight: isActive
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                        child: Text(item.label),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}