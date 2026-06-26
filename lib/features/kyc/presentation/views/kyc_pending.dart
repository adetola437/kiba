import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class KycPendingScreen extends StatelessWidget {
  static const String route = 'kyc_pending';

  final int tier;
  const KycPendingScreen({super.key, required this.tier});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).maybePop(),
          child: const Icon(Icons.arrow_back_rounded),
        ),
        title: Text('Verification', style: textTheme.titleMedium),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.shadow.withOpacity(0.06),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Circular icon with pending badge
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorScheme.primaryContainer.withOpacity(0.2),
                        ),
                      ),
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorScheme.surface,
                          boxShadow: [
                            BoxShadow(
                              color: colorScheme.shadow.withOpacity(0.05),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            Icons.hourglass_top,
                            size: 44,
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.settings,
                                size: 14,
                                color: colorScheme.onPrimary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'PENDING',
                                style: textTheme.labelSmall?.copyWith(
                                  color: colorScheme.onPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  Text(
                    'Verification submitted',
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Thanks — your Tier $tier verification is under review.',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 18),

                  // Info box
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: colorScheme.primaryContainer.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 4,
                          height: 48,
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'We typically review documents within 48 hours. We will notify you via email and app notification when it is complete.',
                            style: textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 22),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: () => GoRouter.of(context).go('/home'),
                      icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                      label: const Text('Back to Home'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}