import 'package:flutter/material.dart';
import '../app/routes.dart';
import '../controllers/splash_controller.dart';
import '../theme/colors.dart';
import '../widgets/app_logo.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final _controller = SplashController();

  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(milliseconds: 1400));
    if (!mounted) return;
    final next = await _controller.resolveNext();
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(
      next == SplashNext.onboarding ? AppRoutes.onboarding : AppRoutes.login,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              AppColors.primaryDark,
              AppColors.primary,
              AppColors.primaryLight,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const AppLogo(size: 130),
              const SizedBox(height: 28),
              const Text(
                'معاملات',
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 38,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textOnPrimary,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'منصة الخدمات الإلكترونية والمعاملات الرقمية',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textOnPrimary.withValues(alpha: 0.85),
                ),
              ),
              const Spacer(),
              const SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(
                  strokeWidth: 2.6,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColors.textOnPrimary),
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'جارٍ التحميل...',
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 13,
                  color: AppColors.textOnPrimary,
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
