import 'package:flutter/material.dart';
import '../app/routes.dart';
import '../controllers/onboarding_controller.dart';
import '../theme/colors.dart';
import '../widgets/app_logo.dart';

class OnboardingScaffold extends StatelessWidget {
  final int index;
  final String imagePath;
  final String title;
  final String description;
  final bool showSkip;
  final String primaryLabel;
  final VoidCallback onPrimary;
  final bool isLast;

  const OnboardingScaffold({
    super.key,
    required this.index,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.showSkip,
    required this.primaryLabel,
    required this.onPrimary,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Row(
                children: [
                  const AppLogo(size: 36),
                  const SizedBox(width: 10),
                  const Text(
                    'معاملات',
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                  const Spacer(),
                  if (showSkip)
                    TextButton(
                      onPressed: () async {
                        await OnboardingController.markDone();
                        if (!context.mounted) return;
                        Navigator.of(context)
                            .pushReplacementNamed(AppRoutes.login);
                      },
                      child: const Text('تخطي'),
                    ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  AppColors.primary.withValues(alpha: 0.10),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Image.asset(imagePath, fit: BoxFit.contain),
                      ),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 14,
                        height: 1.7,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (i) {
                      final active = index == i;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 220),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: active ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: active
                              ? AppColors.primary
                              : AppColors.primary.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      if (isLast) {
                        await OnboardingController.markDone();
                        if (!context.mounted) return;
                      }
                      onPrimary();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          primaryLabel,
                          style: const TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          isLast
                              ? Icons.arrow_back_rounded
                              : Icons.arrow_forward_rounded,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
