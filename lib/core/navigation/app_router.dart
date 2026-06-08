import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kiba/features/wallet/presentation/controllers/fund_wallet_controller.dart';

import '../../features/auth/presentation/controllers/login.dart';

import '../../features/auth/presentation/controllers/forgot_password_controller.dart';
import '../../features/auth/presentation/controllers/forgot_password_otp_controller.dart';
import '../../features/auth/presentation/controllers/forgot_password_success_controller.dart';
import '../../features/auth/presentation/controllers/onboard_controller.dart';
import '../../features/auth/presentation/controllers/register_step1_controller.dart';
import '../../features/auth/presentation/controllers/register_step2_controller.dart';
import '../../features/auth/presentation/controllers/register_step3_controller.dart';
import '../../features/auth/presentation/controllers/register_success_controller.dart';
import '../../features/auth/presentation/controllers/reset_password_controller.dart';
import '../../features/auth/presentation/controllers/splash.dart';
import '../../features/beige_club/presentation/controllers/beige_club_dashboard_controller.dart';
import '../../features/beige_club/presentation/controllers/beige_club_intro_controller.dart';
import '../../features/beige_club/presentation/controllers/beige_club_review_controller.dart';
import '../../features/beige_club/presentation/controllers/beige_club_setup_controller.dart';
import '../../features/beige_club/presentation/controllers/beige_club_success_controller.dart';
import '../../features/home/presentation/controllers/home_controller.dart';
import '../../features/invest/presentation/controllers/confirm_investment_controller.dart';
import '../../features/invest/presentation/controllers/invest_controller.dart';
import '../../features/invest/presentation/controllers/investment_details_controller.dart';
import '../../features/invest/presentation/controllers/investment_success_controller.dart';
import '../../features/invest/presentation/controllers/new_investment_controller.dart';
import '../../features/invest/presentation/controllers/topup_investment_controller.dart';
import '../../features/portfolio/presentation/controllers/portfolio_controller.dart';
import '../../features/profile/presentation/controllers/profile.dart';

import '../../features/beige_club/presentation/controllers/beige_club_group.dart';
import '../../features/beige_club/presentation/controllers/beige_club_subscirbed_screen.dart';
import '../../features/wallet/presentation/controllers/add_bank_account_controller.dart';
import '../../features/wallet/presentation/controllers/fund_bank_transfer_controller.dart';
import '../../features/wallet/presentation/controllers/fund_ussd_controller.dart';
import '../../features/wallet/presentation/controllers/transactions_controller.dart';
import '../../features/wallet/presentation/controllers/wallet_controller.dart';
import '../../features/wallet/presentation/controllers/withdraw_amount_controller.dart';
import '../../features/wallet/presentation/controllers/withdraw_destination_controller.dart';
import '../../features/wallet/presentation/controllers/withdraw_review_controller.dart';
import '../../features/wallet/presentation/controllers/withdraw_success_controller.dart';
import '../models/tenor.dart';
import '../shell/main_shell.dart';
import '../utils/enums.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

class AppRouter {
  AppRouter._();

  static final _homeKey = GlobalKey<NavigatorState>(debugLabel: 'home');
  static final _portfolioKey =
      GlobalKey<NavigatorState>(debugLabel: 'portfolio');
  static final _investKey = GlobalKey<NavigatorState>(debugLabel: 'invest');
  static final _walletKey = GlobalKey<NavigatorState>(debugLabel: 'wallet');
  static final _profileKey = GlobalKey<NavigatorState>(debugLabel: 'profile');

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
        path: '/forgot-password',
        name: ForgotPasswordScreen.route,
        parentNavigatorKey: rootNavigatorKey,
        builder: (_, __) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/forgot-password/verify',
        name: ForgotPasswordOtpScreen.route,
        parentNavigatorKey: rootNavigatorKey,
        builder: (_, state) => ForgotPasswordOtpScreen(
          email: state.extra as String,
        ),
      ),
      GoRoute(
        path: '/forgot-password/reset',
        name: ResetPasswordScreen.route,
        parentNavigatorKey: rootNavigatorKey,
        builder: (_, state) {
          final data = state.extra as Map<String, dynamic>;
          return ResetPasswordScreen(
            email: data['email'] as String,
            code: data['code'] as String,
          );
        },
      ),
      GoRoute(
        path: '/forgot-password/success',
        name: ForgotPasswordSuccessScreen.route,
        parentNavigatorKey: rootNavigatorKey,
        builder: (_, __) => const ForgotPasswordSuccessScreen(),
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
      GoRoute(
          name: RegisterStep3Screen.route,
          path: '/register/verify',
          builder: (_, state) {
            final data = state.extra as Map<String, dynamic>;
            return RegisterStep3Screen(
                phone: data['phone'], firstName: data['firstName']);
          }),

      GoRoute(
        name: RegisterSuccessScreen.route,
        path: '/register/success',
        builder: (_, state) => RegisterSuccessScreen(
          firstName: state.extra as String,
        ),
      ),
      GoRoute(
        name: WithdrawSuccessScreen.route, // 'withdraw_success'
        path: '/withdraw-success',
        parentNavigatorKey: rootNavigatorKey,
        builder: (_, state) {
          final data = state.extra as Map<String, dynamic>;
          return WithdrawSuccessScreen(
            amount: data['amount'] as double,
            account: data['account'] as LinkedBankAccount,
            reference: data['reference'] as String,
          );
        },
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
                    GoRoute(
                        name: BeigeClubDashboardScreen.route,
                        path: 'beige-club/dashboard',
                        parentNavigatorKey: rootNavigatorKey,
                        builder: (_, __) => const BeigeClubDashboardScreen(),
                        routes: [
                          GoRoute(
                              name: 'beige_club_groups',
                              path: 'beige-club/groups',
                              parentNavigatorKey: rootNavigatorKey,
                              builder: (_, __) =>
                                  const BeigeClubGroupsScreen()),
                          GoRoute(
                              name: BeigeClubGroupProgressScreen.route,
                              path: 'beige-club/progress',
                              parentNavigatorKey: rootNavigatorKey,
                              builder: (_, __) =>
                                  const BeigeClubGroupProgressScreen()),
                          GoRoute(
                              name: BeigeClubContributeScreen.route,
                              path: 'beige-club/contribute',
                              parentNavigatorKey: rootNavigatorKey,
                              builder: (_, __) =>
                                  const BeigeClubContributeScreen()),
                          GoRoute(
                              name: 'beige_club_history',
                              path: 'beige-club/history',
                              parentNavigatorKey: rootNavigatorKey,
                              builder: (_, __) =>
                                  const BeigeClubHistoryScreen()),
                        ]),
                    GoRoute(
                      name: BeigeClubIntroScreen.route,
                      path: 'beige-club',
                      parentNavigatorKey: rootNavigatorKey,
                      builder: (_, __) => const BeigeClubIntroScreen(),
                      routes: [
                        GoRoute(
                            name: BeigeClubSetupScreen.route,
                            path: 'beige-club/setup',
                            parentNavigatorKey: rootNavigatorKey,
                            builder: (_, __) => const BeigeClubSetupScreen()),
                        GoRoute(
                            name: BeigeClubReviewScreen.route,
                            path: 'beige-club/review',
                            parentNavigatorKey: rootNavigatorKey,
                            builder: (_, state) {
                              final d = state.extra as Map<String, dynamic>;
                              return BeigeClubReviewScreen(
                                amount: d['amount'],
                                startMonth: d['startMonth'],
                                contributionMode: d['mode'],
                                totalContributed: d['totalContributed'],
                                projectedInterest: d['projectedInterest'],
                                yearEndPayout: d['yearEndPayout'],
                                dailyAccrual: d['dailyAccrual'],
                              );
                            }),
                        GoRoute(
                            name: BeigeClubSuccessScreen.route,
                            path: 'beige-club/success',
                            parentNavigatorKey: rootNavigatorKey,
                            builder: (_, state) {
                              final d = state.extra as Map<String, dynamic>;
                              return BeigeClubSuccessScreen(
                                amount: d['amount'],
                                startMonth: d['startMonth'],
                                positionInRotation: d['positionInRotation'],
                                yearEndPayout: d['yearEndPayout'],
                                dailyAccrual: d['dailyAccrual'],
                              );
                            }),
                      ],
                    ),
                  ]),
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
                        return NewInvestmentScreen(
                            productName: data['productName']);
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
                    GoRoute(
                      name: InvestmentDetailScreen.route,
                      path: 'invest/detail',
                      parentNavigatorKey: rootNavigatorKey,
                      builder: (_, state) {
                        final extra =
                            state.extra as Map<String, dynamic>? ?? {};
                        return InvestmentDetailScreen(
                          productId: '0',
                          hasActiveInvestment:
                              extra['hasActiveInvestment'] ?? false,
                        );
                      },
                    ),
                    GoRoute(
                      name: TopUpInvestmentScreen.route,
                      path: 'invest/topup',
                      parentNavigatorKey: rootNavigatorKey,
                      builder: (_, state) {
                        final d = state.extra as Map<String, dynamic>;
                        return TopUpInvestmentScreen(
                          productName: d['productName'] ?? 'PMPS',
                          currentPrincipal: d['currentPrincipal'] ?? 2500,
                          currentValue: d['currentValue'] ?? 23044,
                          annualRate: d['annualRate'] ?? 12,
                          daysRemaining: d['daysRemaining'] ?? 200,
                          maturityDate: d['maturityDate'] ?? DateTime(2027),
                        );
                      },
                    ),
                    GoRoute(
                      name: TopUpReviewScreen.route,
                      path: 'invest/topup/review',
                      parentNavigatorKey: rootNavigatorKey,
                      builder: (_, state) {
                        final d = state.extra as Map<String, dynamic>;
                        return TopUpReviewScreen(
                          productName: d['productName'],
                          currentPrincipal: d['currentPrincipal'],
                          currentValue: d['currentValue'],
                          topUpAmount: d['topUpAmount'],
                          annualRate: d['annualRate'],
                          daysRemaining: d['daysRemaining'],
                          maturityDate: d['maturityDate'],
                          revisedPrincipal: d['revisedPrincipal'],
                          additionalInterest: d['additionalInterest'],
                          revisedTotalAtMaturity: d['revisedTotalAtMaturity'],
                        );
                      },
                    ),
                    GoRoute(
                      name: TopUpSuccessScreen.route,
                      path: 'invest/topup/success',
                      parentNavigatorKey: rootNavigatorKey,
                      builder: (_, state) {
                        final d = state.extra as Map<String, dynamic>;
                        return TopUpSuccessScreen(
                          productName: d['productName'],
                          topUpAmount: d['topUpAmount'],
                          revisedPrincipal: d['revisedPrincipal'],
                          revisedTotalAtMaturity: d['revisedTotalAtMaturity'],
                          maturityDate: d['maturityDate'],
                        );
                      },
                    ),
                  ]),
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
                  routes: [
                    GoRoute(
                        parentNavigatorKey: rootNavigatorKey,
                        path: 'fund-wallet',
                        name: FundWalletScreen.route,
                        builder: (_, __) => const FundWalletScreen(),
                        routes: [
                          GoRoute(
                            parentNavigatorKey: rootNavigatorKey,
                            path: 'fund-bank-transfer',
                            name: FundBankTransferScreen.route,
                            builder: (_, __) => const FundBankTransferScreen(),
                          ),
                          GoRoute(
                            parentNavigatorKey: rootNavigatorKey,
                            path: 'fund-ussd',
                            name: FundUssdScreen.route,
                            builder: (_, __) => const FundUssdScreen(),
                          ),
                          //  GoRoute(
                          //   path: 'fund-virtual-account',
                          //   name: ProfileScreen.route,
                          //   builder: (_, __) => const ProfileScreen(),
                          // ),
                        ]),
                    GoRoute(
                      name: WithdrawAmountScreen.route, // 'withdraw_amount'
                      path: 'withdraw',
                      parentNavigatorKey: rootNavigatorKey,
                      builder: (_, state) {
                        final data = state.extra as Map<String, dynamic>?;
                        return WithdrawAmountScreen(
                          availableBalance:
                              (data?['availableBalance'] as double?) ??
                                  250000.0,
                        );
                      },
                      routes: [
                        // Step 2 — Destination Selection
                        GoRoute(
                          name: WithdrawDestinationScreen
                              .route, // 'withdraw_destination'
                          path: 'destination',
                          parentNavigatorKey: rootNavigatorKey,
                          builder: (_, state) {
                            final data = state.extra as Map<String, dynamic>;
                            return WithdrawDestinationScreen(
                              amount: data['amount'] as double,
                              availableBalance:
                                  data['availableBalance'] as double,
                            );
                          },
                          routes: [
                            // Add Bank Account (reachable from destination)
                            GoRoute(
                              name: AddBankAccountScreen
                                  .route, // 'add_bank_account'
                              path: 'add-bank',
                              parentNavigatorKey: rootNavigatorKey,
                              builder: (_, __) => const AddBankAccountScreen(),
                            ),

                            // Step 3 — Review & Confirm
                            GoRoute(
                              name: WithdrawReviewScreen
                                  .route, // 'withdraw_review'
                              path: 'review',
                              parentNavigatorKey: rootNavigatorKey,
                              builder: (_, state) {
                                final data =
                                    state.extra as Map<String, dynamic>;
                                return WithdrawReviewScreen(
                                  amount: data['amount'] as double,
                                  account: data['account'] as LinkedBankAccount,
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ]),
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
