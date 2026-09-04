import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

class SignupController extends ChangeNotifier {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  bool _obscure = true;
  bool _accept = false;
  bool get obscure => _obscure;
  bool get accept => _accept;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void toggleObscure() {
    _obscure = !_obscure;
    notifyListeners();
  }

  void toggleAccept(bool? v) {
    _accept = v ?? false;
    notifyListeners();
  }

  Future<bool> signup() async {
    if (!(_accept)) {
      return false;
    }
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 900));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.prefIsLoggedIn, true);
    await prefs.setString(AppConstants.prefUserName, nameController.text.trim());
    await prefs.setString(
        AppConstants.prefUserEmail, emailController.text.trim());
    _isLoading = false;
    notifyListeners();
    return true;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }
}
