import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/users_data.dart';
import '../models/user_model.dart';
import '../utils/constants.dart';

class ProfileController extends ChangeNotifier {
  UserModel get user => UsersData.demo;

  bool _darkMode = false;
  bool get darkMode => _darkMode;

  bool _notifications = true;
  bool get notifications => _notifications;

  String _language = 'العربية';
  String get language => _language;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _darkMode = prefs.getBool(AppConstants.prefDarkMode) ?? false;
    _notifications = prefs.getBool('notif_enabled') ?? true;
    _language = prefs.getString(AppConstants.prefLanguage) ?? 'العربية';
    notifyListeners();
  }

  Future<void> setDarkMode(bool v) async {
    _darkMode = v;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.prefDarkMode, v);
  }

  Future<void> setNotifications(bool v) async {
    _notifications = v;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notif_enabled', v);
  }

  Future<void> setLanguage(String v) async {
    _language = v;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.prefLanguage, v);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.prefIsLoggedIn, false);
  }
}
