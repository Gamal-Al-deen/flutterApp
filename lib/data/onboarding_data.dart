import '../models/onboarding_model.dart';

class OnboardingData {
  OnboardingData._();

  static const List<OnboardingModel> pages = [
    OnboardingModel(
      title: 'منصة الخدمات الرقمية',
      description:
          'منصة موحدة تتيح لك الوصول إلى الخدمات الإلكترونية بسهولة ويسر، في أي وقت ومن أي مكان.',
      imagePath: 'assets/images/onboarding/onboarding_1.png',
    ),
    OnboardingModel(
      title: 'اكتشف الخدمات المتنوعة',
      description:
          'تصفح مجموعة واسعة من الخدمات الإلكترونية، من الوثائق إلى التراخيص، في مكان واحد.',
      imagePath: 'assets/images/onboarding/onboarding_2.png',
    ),
    OnboardingModel(
      title: 'تابع معاملاتك لحظة بلحظة',
      description:
          'راقب حالة طلباتك ومعاملاتك بشكل مباشر، واستلم إشعارات فورية عند أي تحديث.',
      imagePath: 'assets/images/onboarding/onboarding_3.png',
    ),
  ];
}
