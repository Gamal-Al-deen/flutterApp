import 'package:flutter/material.dart';
import '../app/routes.dart';
import '../widgets/onboarding_scaffold.dart';

class OnboardingTwoView extends StatelessWidget {
  const OnboardingTwoView({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingScaffold(
      index: 1,
      imagePath: 'assets/images/onboarding/onboarding_2.png',
      title: 'اكتشف الخدمات المتنوعة',
      description:
          'تصفح مجموعة واسعة من الخدمات الإلكترونية، من الوثائق إلى التراخيص، في مكان واحد.',
      showSkip: true,
      primaryLabel: 'التالي',
      onPrimary: () =>
          Navigator.of(context).pushReplacementNamed(AppRoutes.onboardingThree),
    );
  }
}
