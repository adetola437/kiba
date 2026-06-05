part of '../controllers/register_success_controller.dart';

class RegisterSuccessView extends StatelessWidget
    implements RegisterSuccessViewContract {
  const RegisterSuccessView({super.key, required this.controller});

  final RegisterSuccessControllerContract controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              // ── Dot grid top-right decoration ───────────────────────
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: REdgeInsets.only(top: 24),
                  child: _DotGrid(),
                ),
              ),

              const Spacer(),

              // ── Check animation ──────────────────────────────────────
              AnimatedBuilder(
                animation: controller.checkController,
                builder: (_, __) {
                  return SizedBox(
                    width: 160.r,
                    height: 160.r,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Ripple ring
                        Transform.scale(
                          scale: controller.ringScale.value,
                          child: Opacity(
                            opacity: controller.ringOpacity.value,
                            child: Container(
                              width: 160.r,
                              height: 160.r,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.limeGreen,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Check circle
                        Transform.scale(
                          scale: controller.checkScale.value,
                          child: Opacity(
                            opacity: controller.checkOpacity.value,
                            child: Container(
                              width: 100.r,
                              height: 100.r,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.limeGreen,
                              ),
                              child: Icon(
                                Icons.check_rounded,
                                size: 52.r,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              SizedBox(height: 48.h),

              // ── Content ──────────────────────────────────────────────
              SlideTransition(
                position: controller.contentSlide,
                child: FadeTransition(
                  opacity: controller.contentOpacity,
                  child: Column(
                    children: [
                      Text(
                        'Welcome,\n${controller.firstName}!',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.displaySmall.copyWith(
                          fontFamily: 'BWGradual',
                          color: AppColors.white,
                          height: 1.2,
                        ),
                      ),

                      SizedBox(height: 16.h),

                      Text(
                        'Your KIBA account is ready.\nStart investing with confidence.',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColors.white.withOpacity(0.65),
                          height: 1.6,
                        ),
                      ),

                      SizedBox(height: 40.h),

                      // ── Checkmarks list ─────────────────────────────
                     const _CheckItem(label: 'Account created'),
                      SizedBox(height: 12.h),
                      const _CheckItem(label: 'Phone verified'),
                      SizedBox(height: 12.h),
                      const _CheckItem(label: 'Ready to invest'),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              // ── Loading bar ──────────────────────────────────────────
              FadeTransition(
                opacity: controller.contentOpacity,
                child: Column(
                  children: [
                    Text(
                      'Proceed to Login...',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.white.withOpacity(0.45),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    _AutoProgressBar(),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Single check item ──────────────────────────────────────────────────────────
class _CheckItem extends StatelessWidget {
  const _CheckItem({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 20.r,
          height: 20.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.limeGreen.withOpacity(0.2),
          ),
          child: Icon(
            Icons.check_rounded,
            size: 12.r,
            color: AppColors.limeGreen,
          ),
        ),
        SizedBox(width: 10.w),
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.white.withOpacity(0.85),
          ),
        ),
      ],
    );
  }
}

// ── Auto-advancing progress bar ────────────────────────────────────────────────
class _AutoProgressBar extends StatefulWidget {
  @override
  State<_AutoProgressBar> createState() => _AutoProgressBarState();
}

class _AutoProgressBarState extends State<_AutoProgressBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _progress;

  @override
  void initState() {
    super.initState();
    // Matches the 2200ms hold in the controller before navigation
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..forward();

    _progress = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _progress,
      builder: (_, __) {
        return Container(
          height: 3.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(2.r),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: _progress.value,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.limeGreen,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ── Dot grid decoration ────────────────────────────────────────────────────────
class _DotGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (r) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (c) {
            return Container(
              margin: EdgeInsets.all(5.r),
              width: 5.r,
              height: 5.r,
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
            );
          }),
        );
      }),
    );
  }
}