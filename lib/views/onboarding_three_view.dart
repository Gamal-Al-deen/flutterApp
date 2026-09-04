import 'package:flutter/material.dart';
import '../app/routes.dart';
import '../widgets/onboarding_scaffold.dart';

class OnboardingThreeView extends StatelessWidget {
  const OnboardingThreeView({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingScaffold(
      index: 2,
      imagePath: 'assets/images/onboarding/onboarding_3.png',
      title: 'تابع معاملاتك لحظة بلحظة',
      description:
          'راقب حالة طلباتك ومعاملاتك بشكل مباشر، واستلم إشعارات فورية عند أي تحديث.',
      showSkip: false,
      primaryLabel: 'ابدأ الآن',
      isLast: true,
      onPrimary: () =>
          Navigator.of(context).pushReplacementNamed(AppRoutes.login),
    );
  }
}
