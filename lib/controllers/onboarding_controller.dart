import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

class OnboardingController {
  static Future<void> markDone() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.prefOnboardingDone, true);
  }
}
