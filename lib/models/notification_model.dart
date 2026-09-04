import 'package:flutter/material.dart';

enum NotificationType {
  transaction('معاملة', Icons.receipt_long_rounded, Color(0xFF1E88E5)),
  reminder('تذكير', Icons.notifications_active_rounded, Color(0xFFF59E0B)),
  announcement('إعلان', Icons.campaign_rounded, Color(0xFFE91E63)),
  success('نجاح', Icons.check_circle_rounded, Color(0xFF22A06B));

  const NotificationType(this.label, this.icon, this.color);
  final String label;
  final IconData icon;
  final Color color;
}

class NotificationModel {
  final String id;
  final String title;
  final String body;
  final DateTime date;
  final NotificationType type;
  final bool isRead;
  final String? relatedId;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
    required this.type,
    required this.isRead,
    this.relatedId,
  });

  NotificationModel copyWith({bool? isRead}) {
    return NotificationModel(
      id: id,
      title: title,
      body: body,
      date: date,
      type: type,
      isRead: isRead ?? this.isRead,
      relatedId: relatedId,
    );
  }
}
