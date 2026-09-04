import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

class LoginController extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _obscure = true;
  bool get obscure => _obscure;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void toggleObscure() {
    _obscure = !_obscure;
    notifyListeners();
  }

  Future<bool> login() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 900));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.prefIsLoggedIn, true);
    await prefs.setString(
        AppConstants.prefUserEmail, emailController.text.trim());
    _isLoading = false;
    notifyListeners();
    return true;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
