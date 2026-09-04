import 'package:flutter/material.dart';

enum ServiceCategory {
  documents('الوثائق الرسمية', Icons.description_rounded),
  licenses('التراخيص', Icons.badge_rounded),
  civil('الأحوال المدنية', Icons.account_balance_rounded),
  education('التعليم', Icons.school_rounded),
  health('الصحة', Icons.medical_services_rounded),
  vehicles('المركبات', Icons.directions_car_rounded),
  housing('الإسكان', Icons.home_work_rounded),
  business('الأعمال', Icons.business_center_rounded);

  const ServiceCategory(this.label, this.icon);
  final String label;
  final IconData icon;
}

class ServiceModel {
  final String id;
  final String title;
  final String description;
  final String shortDescription;
  final ServiceCategory category;
  final IconData icon;
  final Color color;
  final int estimatedDays;
  final double fee;
  final double rating;
  final bool isFeatured;
  final List<String> requirements;
  final List<String> steps;

  const ServiceModel({
    required this.id,
    required this.title,
    required this.description,
    required this.shortDescription,
    required this.category,
    required this.icon,
    required this.color,
    required this.estimatedDays,
    required this.fee,
    required this.rating,
    required this.isFeatured,
    required this.requirements,
    required this.steps,
  });
}
