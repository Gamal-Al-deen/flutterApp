import 'package:flutter/material.dart';

class ForgotPasswordController extends ChangeNotifier {
  final emailController = TextEditingController();
  bool _isLoading = false;
  bool _sent = false;
  bool get isLoading => _isLoading;
  bool get sent => _sent;

  Future<bool> submit() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 900));
    _isLoading = false;
    _sent = true;
    notifyListeners();
    return true;
  }

  void reset() {
    _sent = false;
    emailController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
