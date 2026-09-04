import 'package:flutter/material.dart';
import '../app/routes.dart';
import '../widgets/onboarding_scaffold.dart';

class OnboardingOneView extends StatelessWidget {
  const OnboardingOneView({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingScaffold(
      index: 0,
      imagePath: 'assets/images/onboarding/onboarding_1.png',
      title: 'منصة الخدمات الرقمية',
      description:
          'منصة موحدة تتيح لك الوصول إلى الخدمات الإلكترونية بسهولة ويسر، في أي وقت ومن أي مكان.',
      showSkip: true,
      primaryLabel: 'التالي',
      onPrimary: () =>
          Navigator.of(context).pushReplacementNamed(AppRoutes.onboardingTwo),
    );
  }
}
