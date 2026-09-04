import 'package:flutter/material.dart';

enum TransactionStatus {
  pending('قيد المراجعة', Color(0xFFF59E0B), Icons.hourglass_top_rounded),
  processing('قيد المعالجة', Color(0xFF1E88E5), Icons.autorenew_rounded),
  approved('مقبولة', Color(0xFF22A06B), Icons.check_circle_rounded),
  completed('مكتملة', Color(0xFF22A06B), Icons.task_alt_rounded),
  rejected('مرفوضة', Color(0xFFE53935), Icons.cancel_rounded);

  const TransactionStatus(this.label, this.color, this.icon);
  final String label;
  final Color color;
  final IconData icon;
}

class TransactionModel {
  final String id;
  final String referenceNumber;
  final String serviceId;
  final String serviceTitle;
  final String serviceIconCode;
  final Color serviceColor;
  final TransactionStatus status;
  final DateTime submittedAt;
  final DateTime? updatedAt;
  final String applicantName;
  final String applicantPhone;
  final String notes;
  final int progress;
  final String stage;

  const TransactionModel({
    required this.id,
    required this.referenceNumber,
    required this.serviceId,
    required this.serviceTitle,
    required this.serviceIconCode,
    required this.serviceColor,
    required this.status,
    required this.submittedAt,
    required this.applicantName,
    required this.applicantPhone,
    required this.notes,
    required this.progress,
    required this.stage,
    this.updatedAt,
  });

  String get formattedDate {
    final d = submittedAt;
    return '${d.year.toString().padLeft(4, '0')}/${d.month.toString().padLeft(2, '0')}/${d.day.toString().padLeft(2, '0')}';
  }
}
