import 'package:flutter/material.dart';
import '../data/notifications_data.dart';
import '../models/notification_model.dart';

class NotificationsController extends ChangeNotifier {
  List<NotificationModel> get items => NotificationsData.all;

  int get unreadCount => items.where((n) => !n.isRead).length;

  void markAllAsRead() {
    for (var i = 0; i < NotificationsData.all.length; i++) {
      NotificationsData.all[i] = NotificationsData.all[i].copyWith(isRead: true);
    }
    notifyListeners();
  }

  void toggleRead(String id) {
    final i = NotificationsData.all.indexWhere((n) => n.id == id);
    if (i == -1) return;
    final n = NotificationsData.all[i];
    NotificationsData.all[i] = n.copyWith(isRead: !n.isRead);
    notifyListeners();
  }

  void clearAll() {
    NotificationsData.all.clear();
    notifyListeners();
  }
}
