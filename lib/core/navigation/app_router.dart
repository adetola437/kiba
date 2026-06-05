import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';



import '../../features/auth/presentation/controllers/login.dart';

import '../../features/auth/presentation/controllers/onboard_controller.dart';
import '../../features/auth/presentation/controllers/register_step1_controller.dart';
import '../../features/auth/presentation/controllers/register_step2_controller.dart';
import '../../features/auth/presentation/controllers/register_step3_controller.dart';
import '../../features/auth/presentation/controllers/register_success_controller.dart';
import '../../features/auth/presentation/controllers/splash.dart';
import '../../features/home/presentation/controllers/home_controller.dart';
import '../../features/invest/presentation/controllers/confirm_investment_controller.dart';
import '../../features/invest/presentation/controllers/invest_controller.dart';
import '../../features/invest/presentation/controllers/investment_success_controller.dart';
import '../../features/invest/presentation/controllers/new_investment_controller.dart';
import '../../features/portfolio/presentation/controllers/portfolio_controller.dart';
import '../../features/profile/presentation/controllers/profile.dart';

import '../../features/wallet/presentation/controllers/transactions_controller.dart';
import '../../features/wallet/presentation/controllers/wallet_controller.dart';
import '../models/tenor.dart';
import '../shell/main_shell.dart';
import '../utils/enums.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

class AppRouter {
  AppRouter._();

  static final _homeKey      = GlobalKey<NavigatorState>(debugLabel: 'home');
  static final _portfolioKey = GlobalKey<NavigatorState>(debugLabel: 'portfolio');
  static final _investKey    = GlobalKey<NavigatorState>(debugLabel: 'invest');
  static final _walletKey    = GlobalKey<NavigatorState>(debugLabel: 'wallet');
  static final _profileKey   = GlobalKey<NavigatorState>(debugLabel: 'profile');

  static final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    // Always start at splash — it resolves auth and redirects accordingly
    initialLocation: '/splash',
    routes: [
      // ── Splash ─────────────────────────────────────────────────────────────
      GoRoute(
        path: '/splash',
        name: SplashScreen.route,
        parentNavigatorKey: rootNavigatorKey,
        builder: (_, __) => const SplashScreen(),
      ),

      // ── Auth ───────────────────────────────────────────────────────────────
      GoRoute(
        path: '/login',
        name: LoginScreen.route,
        parentNavigatorKey: rootNavigatorKey,
        builder: (_, __) => const LoginScreen(),
      ),
      GoRoute(
  name: OnboardingScreen.route,
  path: '/onboarding',
  builder: (_, __) => const OnboardingScreen(),
),
GoRoute(
  name: RegisterStep1Screen.route,
  path: '/register',
  builder: (_, __) => const RegisterStep1Screen(),
),
GoRoute(
  name: RegisterStep2Screen.route,
 path: '/register/details',
  builder: (_, state) => RegisterStep2Screen(
    investorType: state.extra as InvestorType,
  ),
),
GoRoute(name: RegisterStep3Screen.route,  
path: '/register/verify',
  builder: (_, state) {
    final data = state.extra as Map<String, dynamic>;
    return RegisterStep3Screen(phone: data['phone'], firstName: data['firstName']);
  }),

  GoRoute(
  name: RegisterSuccessScreen.route,
  path: '/register/success',
  builder: (_, state) => RegisterSuccessScreen(
    firstName: state.extra as String,
  ),
),
  
      // ── Full-screen routes above the shell ─────────────────────────────────
   
    
       // ── Shell — bottom nav tabs ───────────────────────────────────────────
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainShell(navigationShell: navigationShell),
        branches: [
 
          // 0 — Home
          StatefulShellBranch(
            navigatorKey: _homeKey,
            routes: [
              GoRoute(
                path: '/home',
                name: HomeScreen.route,
                builder: (_, __) => const HomeScreen(),
                routes: [
                  GoRoute(
  name: TransactionsScreen.route,
  path: 'transactions',
  parentNavigatorKey: rootNavigatorKey,
  builder: (_, __) => const TransactionsScreen(),
),
                ]
              ),
            ],
          ),
 
          // 1 — Portfolio
          StatefulShellBranch(
            navigatorKey: _portfolioKey,
            routes: [
              GoRoute(
                path: '/portfolio',
                name: PortfolioScreen.route,
                builder: (_, __) => const PortfolioScreen(),
              ),
            ],
          ),
 
          // 2 — Invest (centre FAB tab)
          StatefulShellBranch(
            navigatorKey: _investKey,
            routes: [
              GoRoute(
                path: '/invest',
                name: InvestScreen.route,
                builder: (_, __) => const InvestScreen(),
                routes: [
                  GoRoute(
  name: NewInvestmentScreen.route,
  path: 'invest/new',
  parentNavigatorKey: rootNavigatorKey,
  builder: (_, state) {
    final data = state.extra as Map<String, dynamic>;
    return NewInvestmentScreen(productName: data['productName']);
  },
),
GoRoute(
  name: ConfirmInvestmentScreen.route,
  path: 'invest/confirm',
  parentNavigatorKey: rootNavigatorKey,
  builder: (_, state) {
    final d = state.extra as Map<String, dynamic>;
    return ConfirmInvestmentScreen(
      productName: d['productName'],
      tenorDays: (d['tenor'] as TenorOption).days,
      annualRate: (d['tenor'] as TenorOption).rate,
      amount: d['amount'],
      projectedInterest: d['interest'],
      totalAtMaturity: d['total'],
      maturityDate: d['maturityDate'],
    );
  },
),
GoRoute(
  name: InvestmentSuccessScreen.route,
  path: 'invest/success',
  parentNavigatorKey: rootNavigatorKey,
  builder: (_, state) {
    final d = state.extra as Map<String, dynamic>;
    return InvestmentSuccessScreen(
      productName: d['productName'],
      amount: d['amount'],
      tenorDays: d['tenorDays'],
      totalAtMaturity: d['totalAtMaturity'],
      maturityDate: d['maturityDate'],
    );
  },
),
                ]
              ),
            ],
          ),
 
          // 3 — Wallet
          StatefulShellBranch(
            navigatorKey: _walletKey,
            routes: [
              GoRoute(
                path: '/wallet',
                name: WalletScreen.route,
                builder: (_, __) => const WalletScreen(),
              ),
            ],
          ),
 
          // 4 — Profile
          StatefulShellBranch(
            navigatorKey: _profileKey,
            routes: [
              GoRoute(
                path: '/profile',
                name: ProfileScreen.route,
                builder: (_, __) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}