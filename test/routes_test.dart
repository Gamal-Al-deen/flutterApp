import 'package:flutter_test/flutter_test.dart';
import 'package:muamalat/app/routes.dart';
import 'package:muamalat/utils/constants.dart';

void main() {
  test('App constants are defined', () {
    expect(AppConstants.appName, 'معاملات');
    expect(AppConstants.appVersion, '1.0.0');
  });

  test('All required routes are defined', () {
    expect(AppRoutes.splash, '/');
    expect(AppRoutes.onboarding, '/onboarding');
    expect(AppRoutes.onboardingTwo, '/onboarding/two');
    expect(AppRoutes.onboardingThree, '/onboarding/three');
    expect(AppRoutes.login, '/login');
    expect(AppRoutes.signup, '/signup');
    expect(AppRoutes.forgotPassword, '/forgot-password');
    expect(AppRoutes.main, '/main');
    expect(AppRoutes.serviceDetails, '/service-details');
    expect(AppRoutes.createTransaction, '/create-transaction');
    expect(AppRoutes.transactionDetails, '/transaction-details');
    expect(AppRoutes.notifications, '/notifications');
  });
}
