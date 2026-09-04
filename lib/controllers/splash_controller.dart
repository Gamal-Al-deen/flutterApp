import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

enum SplashNext { onboarding, login }

class SplashController {
  Future<SplashNext> resolveNext() async {
    final prefs = await SharedPreferences.getInstance();
    final done = prefs.getBool(AppConstants.prefOnboardingDone) ?? false;
    return done ? SplashNext.login : SplashNext.onboarding;
  }
}
